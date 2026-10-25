import { existsSync, readFileSync } from 'node:fs';
import path from 'node:path';

// Deliberately small: repository ATX headings, fenced examples and inline links.
// Not a general Markdown renderer; external URLs are never fetched.
export function markdownFacts(text) {
  const anchors = new Set();
  const seen = new Map();
  const prose = [];
  const errors = [];
  let fence;
  let block = [];
  let examples = 0;
  let table = [];
  for (const [index, line] of text.replaceAll('\r\n', '\n').split('\n').entries()) {
    if (line.trimEnd() !== line) errors.push(`line ${index + 1}: trailing whitespace`);
    if (line.startsWith('```')) {
      if (fence === undefined) { fence = line.slice(3).trim(); block = []; }
      else {
        if (fence === 'json') {
          try { JSON.parse(block.join('\n')); examples++; }
          catch { errors.push(`line ${index + 1}: invalid JSON example`); }
        }
        fence = undefined;
      }
      continue;
    }
    if (fence !== undefined) { block.push(line); continue; }
    prose.push(line);
    const heading = /^#{1,6}\s+(.+?)\s*#*$/.exec(line);
    if (heading) {
      const slug = heading[1].toLowerCase().replace(/[^\p{L}\p{N}_ -]/gu, '').replaceAll(' ', '-');
      const count = seen.get(slug) ?? 0;
      seen.set(slug, count + 1);
      anchors.add(count ? `${slug}-${count}` : slug);
    }
    if (line.startsWith('|')) table.push([...line.matchAll(/(?<!\\)\|/g)].length);
    else if (table.length) {
      if (new Set(table).size !== 1) errors.push(`line ${index + 1}: inconsistent table columns`);
      table = [];
    }
  }
  if (new Set(table).size > 1) errors.push('inconsistent table columns');
  if (fence !== undefined) errors.push('unclosed fence');
  return { anchors, prose: prose.join('\n'), errors, examples };
}

export function checkDocumentation(root, names) {
  const documents = new Map();
  const errors = [];
  let links = 0;
  let examples = 0;
  for (const name of names.filter(name => name.endsWith('.md'))) {
    const facts = markdownFacts(readFileSync(path.join(root, name), 'utf8'));
    documents.set(path.resolve(root, name), facts);
    errors.push(...facts.errors.map(error => `${name}: ${error}`));
    examples += facts.examples;
  }
  for (const [file, { prose }] of documents) {
    for (const match of prose.matchAll(/!?\[[^\]\n]*\]\(([^)\s]+)(?:\s+"[^"]*")?\)/g)) {
      const target = match[1];
      if (/^[a-zA-Z][a-zA-Z0-9+.-]*:/.test(target)) continue;
      links++;
      try {
        const [location, fragment] = target.split('#');
        const resolved = location ? path.resolve(path.dirname(file), decodeURIComponent(location)) : file;
        const relative = path.relative(root, resolved);
        if (relative === '..' || relative.startsWith(`..${path.sep}`) || path.isAbsolute(relative)) {
          throw new Error('target leaves repository');
        }
        if (!existsSync(resolved)) throw new Error('missing target');
        if (fragment && resolved.endsWith('.md') && !documents.get(resolved)?.anchors.has(decodeURIComponent(fragment))) {
          throw new Error('missing heading');
        }
      } catch (error) { errors.push(`${path.relative(root, file)}: ${target}: ${error.message}`); }
    }
  }
  if (errors.length) throw new Error(errors.join('\n'));
  return { files: documents.size, links, examples };
}

export function formatErrors(text) {
  const errors = [];
  const normalized = text.replaceAll('\r\n', '\n');
  if (!normalized.endsWith('\n')) errors.push('missing final newline');
  if (normalized.includes('\t')) errors.push('tab character (use spaces)');
  if (normalized.includes('\r')) errors.push('bare carriage return');
  if (normalized.split('\n').some(line => line.trimEnd() !== line)) errors.push('trailing whitespace');
  return errors;
}
