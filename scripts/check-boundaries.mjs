import { readdirSync, readFileSync } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { dartImports, typescriptImports } from './architecture/imports.mjs';
import { edgeViolation, sourceViolation } from './architecture/policy.mjs';

const args = process.argv.slice(2);
if (args.length && (args.length !== 2 || args[0] !== '--root')) {
  throw new Error('Usage: node scripts/check-boundaries.mjs [--root <fixture-root>]');
}
const root = args.length ? path.resolve(args[1]) : path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const apiManifest = JSON.parse(readFileSync(path.join(root, 'apps/api/package.json'), 'utf8'));
const tsconfig = JSON.parse(readFileSync(path.join(root, 'apps/api/tsconfig.json'), 'utf8'));
if (tsconfig.compilerOptions.paths || tsconfig.compilerOptions.baseUrl || apiManifest.imports) {
  throw new Error('New aliases/import maps need explicit boundary resolver support');
}
const apiPackages = new Set(Object.keys(apiManifest.dependencies));
const violations = [];
let files = 0;
let edges = 0;

function scan(directory, relative, language) {
  for (const entry of readdirSync(directory, { withFileTypes: true })) {
    const name = relative ? `${relative}/${entry.name}` : entry.name;
    const absolute = path.join(directory, entry.name);
    if (entry.isSymbolicLink()) {
      violations.push(`${language}/${name}: source symlinks need explicit ownership review`);
    } else if (entry.isDirectory()) scan(absolute, name, language);
    else if (/\.(?:[cm]?js|tsx?|dart)$/i.test(entry.name)) {
      files++;
      const sourceError = sourceViolation(language, name);
      if (sourceError) violations.push(`${language}/${name}: ${sourceError}`);
      if (!(language === 'api' ? name.endsWith('.ts') : name.endsWith('.dart'))) {
        violations.push(`${language}/${name}: unsupported source language in this application`);
        continue;
      }
      try {
        const source = readFileSync(absolute, 'utf8');
        const imports = language === 'api' ? typescriptImports(source, name) : dartImports(source);
        for (const specifier of imports) {
          edges++;
          const error = edgeViolation(language, name, specifier, apiPackages);
          if (error) violations.push(`${language}/${name} -> ${specifier}: ${error}`);
        }
      } catch (error) {
        violations.push(`${language}/${name}: ${error.message}`);
      }
    }
  }
}

scan(path.join(root, 'apps/api/src'), '', 'api');
scan(path.join(root, 'apps/mobile/lib'), '', 'mobile');
if (violations.length) {
  console.error(violations.join('\n'));
  process.exitCode = 1;
} else console.info(`Import boundaries passed: ${files} source files, ${edges} dependency directives.`);
