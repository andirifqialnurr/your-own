import ts from 'typescript';

// Use the installed compiler, not a regex, for TypeScript dependency syntax.
export function typescriptImports(source, filename = 'source.ts') {
  const file = ts.createSourceFile(filename, source, ts.ScriptTarget.Latest, true);
  if (file.parseDiagnostics.length) throw new Error(`Invalid TypeScript syntax: ${filename}`);
  const imports = [];
  const add = (node) => {
    if (!node || !ts.isStringLiteralLike(node)) {
      throw new Error('Computed module loading is not supported by the boundary policy');
    }
    imports.push(node.text);
  };
  const visit = (node) => {
    if (ts.isImportDeclaration(node)) add(node.moduleSpecifier);
    else if (ts.isExportDeclaration(node) && node.moduleSpecifier) add(node.moduleSpecifier);
    else if (ts.isExternalModuleReference(node)) add(node.expression);
    else if (ts.isImportTypeNode(node)) {
      add(ts.isLiteralTypeNode(node.argument) ? node.argument.literal : undefined);
    } else if (ts.isCallExpression(node)) {
      const expression = node.expression;
      if (expression.kind === ts.SyntaxKind.ImportKeyword
        || (ts.isIdentifier(expression) && expression.text === 'require')
        || (ts.isPropertyAccessExpression(expression)
          && ts.isIdentifier(expression.expression) && expression.expression.text === 'require'
          && expression.name.text === 'resolve')) add(node.arguments[0]);
    }
    ts.forEachChild(node, visit);
  };
  visit(file);
  return imports;
}

// A small, lazy lexer for Dart's library-directive prefix only. Body syntax is
// left to dart analyze. Comments/string contents are never treated as imports.
function* dartTokens(source) {
  let i = 0;
  while (i < source.length) {
    if (/\s/.test(source[i])) { i++; continue; }
    if (source.startsWith('//', i)) {
      const end = source.indexOf('\n', i);
      i = end < 0 ? source.length : end;
      continue;
    }
    if (source.startsWith('/*', i)) {
      let depth = 1;
      i += 2;
      while (depth && i < source.length) {
        if (source.startsWith('/*', i)) { depth++; i += 2; }
        else if (source.startsWith('*/', i)) { depth--; i += 2; }
        else i++;
      }
      if (depth) throw new Error('Unclosed Dart directive comment');
      continue;
    }
    const raw = source[i] === 'r' && /['"]/.test(source[i + 1] ?? '');
    if (raw || /['"]/.test(source[i])) {
      if (raw) i++;
      const quote = source[i];
      const delimiter = source.startsWith(quote.repeat(3), i) ? quote.repeat(3) : quote;
      i += delimiter.length;
      const start = i;
      while (i < source.length && !source.startsWith(delimiter, i)) {
        if (!raw && source[i] === '\\') i += 2;
        else i++;
      }
      if (i >= source.length) throw new Error('Unclosed Dart directive string');
      const value = source.slice(start, i);
      i += delimiter.length;
      yield { kind: 'string', value };
      continue;
    }
    const identifier = /^[a-zA-Z_$][\w$]*/.exec(source.slice(i));
    if (identifier) {
      i += identifier[0].length;
      yield { kind: 'identifier', value: identifier[0] };
    } else yield { kind: 'symbol', value: source[i++] };
  }
}

export function dartImports(source) {
  const lexer = dartTokens(source);
  let token = lexer.next().value;
  const advance = () => { const previous = token; token = lexer.next().value; return previous; };
  const imports = [];
  while (token) {
    if (token.value === '@') {
      advance();
      if (token?.kind !== 'identifier') throw new Error('Unsupported Dart directive annotation');
      advance();
      while (token?.value === '.' || token?.value === '<') {
        if (token.value === '.') { advance(); advance(); }
        else {
          let depth = 0;
          do {
            if (!token) throw new Error('Unclosed Dart annotation type arguments');
            if (token.value === '<') depth++;
            if (token.value === '>') depth--;
            advance();
          } while (depth);
        }
      }
      if (token?.value === '(') {
        let depth = 0;
        do {
          if (!token) throw new Error('Unclosed Dart annotation');
          if (token.value === '(') depth++;
          if (token.value === ')') depth--;
          advance();
        } while (depth);
      }
      continue;
    }
    if (!['import', 'export', 'part', 'library'].includes(token.value)) break;
    const directive = advance().value;
    let depth = 0;
    const uris = [];
    while (token && token.value !== ';') {
      if (token.value === '(') depth++;
      if (token.value === ')') depth--;
      if (token.kind === 'string' && depth === 0) uris.push(token.value);
      advance();
    }
    if (!token || depth !== 0) throw new Error('Malformed Dart library directive');
    advance();
    if (directive === 'library') continue;
    if (!uris.length) throw new Error('Dependency directives must use literal URIs (including part of)');
    for (const uri of uris) {
      // Avoid misinterpreting escaped/interpolated URIs; ordinary relative,
      // package and dart URIs need neither. Check every conditional branch.
      if (/[\\$\r\n]/.test(uri)) throw new Error('Escaped/interpolated Dart dependency URI is not supported');
      imports.push(uri);
    }
  }
  return imports;
}
