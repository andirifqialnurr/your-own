import { execFileSync } from 'node:child_process';
import { readFileSync } from 'node:fs';
import path from 'node:path';
import { checkDocumentation, formatErrors } from './tooling/documentation.mjs';

if (process.argv.length !== 2) throw new Error('Usage: node scripts/check-docs.mjs');
const root = path.resolve(import.meta.dirname, '..');
// Include new unignored files while developing, never node_modules or ignored .env.
const names = [...new Set(execFileSync('git', ['ls-files', '--cached', '--others', '--exclude-standard', '-z'], {
  cwd: root, encoding: 'utf8',
}).split('\0').filter(Boolean))];
const result = checkDocumentation(root, names);
let formatted = 0;
for (const name of names) {
  const owned = name === 'package.json' || name === 'eslint.config.mjs' ||
    name.startsWith('scripts/') || /^apps\/api\/(?:src\/|test\/|package.json$|tsconfig.json$)/.test(name);
  if (!owned || !/\.(?:[cm]?js|ts|json)$/.test(name)) continue;
  const errors = formatErrors(readFileSync(path.join(root, name), 'utf8'));
  if (errors.length) throw new Error(`${name}: ${errors.join(', ')}`);
  formatted++;
}
console.info(`Documentation passed: ${result.files} Markdown, ${result.links} local links, ${result.examples} JSON examples; ${formatted} owned JS/TS/JSON whitespace checks.`);
