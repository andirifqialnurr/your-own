import path from 'node:path';

const apiRoots = new Set(['config', 'common', 'infrastructure', 'modules', 'health']);
const mobileRoots = new Set(['app', 'core', 'features', 'shared_ui', 'l10n']);
const dartPure = new Set(['dart:core', 'dart:async', 'dart:collection', 'dart:math', 'dart:convert', 'dart:typed_data']);
const uiPackages = new Set(['flutter', 'flutter_localizations', 'intl']);

function owner(language, file) {
  const parts = file.toLowerCase().split('/');
  if (language === 'api' && parts[0] === 'health') return { name: 'health', tail: parts.slice(1) };
  if (parts[0] === (language === 'api' ? 'modules' : 'features') && parts.length >= 3) {
    return { name: parts[1], tail: parts.slice(2) };
  }
  return { name: null, tail: parts };
}

function pure(language, file) {
  const { name, tail } = owner(language, file);
  if (name) return ['domain', 'contracts'].includes(tail[0]) || tail.join('/') === (language === 'api' ? 'index.ts' : 'public.dart');
  return /^(common|core)\/domain\//.test(file.toLowerCase());
}

export function sourceViolation(language, file) {
  if (file.includes('\\') || path.posix.normalize(file) !== file || file.startsWith('../') || file.startsWith('/')) return 'source path must be canonical and app-local';
  const parts = file.toLowerCase().split('/');
  if (parts.length === 1) {
    const allowed = language === 'api'
      ? /^(main|app|app\.module|worker|worker\.module)\.ts$/
      : /^main(?:_(development|staging|production))?\.dart$/;
    return allowed.test(parts[0]) ? null : 'unexpected top-level source; use its owned layer';
  }
  if (!(language === 'api' ? apiRoots : mobileRoots).has(parts[0])) return 'unexpected source tree; do not create device-specific app copies';
  if (parts[0] === (language === 'api' ? 'modules' : 'features')) {
    if (parts.length < 3) return 'feature source needs an explicit owner';
    const layers = language === 'api'
      ? ['domain', 'contracts', 'application', 'transport', 'infrastructure']
      : ['domain', 'contracts', 'data', 'presentation'];
    const entry = language === 'api'
      ? parts[2] === 'index.ts' || parts[2].endsWith('.module.ts')
      : parts[2] === 'public.dart';
    if (!(parts.length === 3 ? entry : layers.includes(parts[2]))) return 'feature source needs a recognized layer or public entry';
  }
  return null;
}

export function edgeViolation(language, source, specifier, apiPackages = new Set()) {
  if (!specifier || /[\\\s%?#]/.test(specifier)) return 'dependency URI must be plain, nonempty and use forward slashes';
  source = source.toLowerCase();
  const from = owner(language, source);
  const isPure = pure(language, source);
  const isUi = language === 'mobile' && (from.tail[0] === 'presentation' || /^(shared_ui|l10n)\//.test(source));
  let target;
  if (language === 'mobile' && specifier.startsWith('package:your_own/')) {
    target = path.posix.normalize(specifier.slice('package:your_own/'.length));
  } else if (specifier.startsWith('./') || specifier.startsWith('../')
    || (language === 'mobile' && !specifier.includes(':') && !specifier.startsWith('/'))) {
    target = path.posix.normalize(path.posix.join(path.posix.dirname(source), specifier));
    if (language === 'api') target = target.replace(/\.js$/, '.ts');
  } else {
    if (isPure) {
      return language === 'mobile' && dartPure.has(specifier) ? null : 'domain/contracts cannot depend on frameworks, transport, I/O or third-party packages';
    }
    if (language === 'api') {
      const name = specifier.startsWith('@') ? specifier.split('/').slice(0, 2).join('/') : specifier.split('/')[0];
      return specifier.startsWith('node:') || apiPackages.has(name) ? null : 'unsupported alias or undeclared runtime package';
    }
    if (specifier.startsWith('dart:')) return !isUi || dartPure.has(specifier) || specifier === 'dart:ui' ? null : 'presentation must not perform direct I/O';
    const packageName = /^package:([a-z_][a-z_0-9]*)\//.exec(specifier)?.[1];
    if (!packageName) return 'unsupported dependency URI scheme';
    if (packageName === 'hugeicons') return source === 'shared_ui/icons/app_icon.dart' ? null : 'Hugeicons must go through the owned AppIcon adapter';
    if (packageName === 'go_router') return source.startsWith('app/') ? null : 'router integration belongs in app composition; inject feature callbacks';
    return !isUi || uiPackages.has(packageName) ? null : 'presentation package needs review; keep transport/storage in data adapters';
  }
  if (target === '..' || target.startsWith('../') || path.posix.isAbsolute(target)) return 'dependency escapes this application source root';
  if (!target.endsWith(language === 'api' ? '.ts' : '.dart')) return 'local dependency must name a checked source file (.js for API, .dart for Flutter)';
  target = target.toLowerCase();
  const to = owner(language, target);
  const moduleEntry = [`${to.name}.module.ts`, `${to.name}.http.module.ts`].includes(to.tail.join('/'));
  if (source === 'worker.module.ts' && target.endsWith('.http.module.ts')) return 'worker composition must not import the HTTP module entry';
  const targetPure = pure(language, target);
  if (isPure && !targetPure) return 'domain/contracts may import only domain/contracts and pure shared code';
  if (from.name && to.name && from.name !== to.name) {
    const publicEntry = language === 'api' ? 'index.ts' : 'public.dart';
    const moduleWiring = language === 'api' && source.endsWith('.module.ts') && moduleEntry;
    if (to.tail.join('/') !== publicEntry && !moduleWiring) return 'cross-feature access must use the explicit public contract';
  }
  if (from.name && to.name === from.name) {
    if (from.tail[0] === 'application' && ['transport', 'infrastructure'].includes(to.tail[0])) return 'application depends on contracts, not transport/infrastructure';
    if (from.tail[0] === 'presentation' && to.tail[0] === 'data') return 'presentation must receive domain contracts, not data implementations';
    if (from.tail[0] === 'data' && to.tail[0] === 'presentation') return 'data must not depend on presentation';
    if (from.tail[0] === 'transport' && to.tail[0] === 'infrastructure') return 'transport must call application services, not infrastructure';
  }
  if (isUi && target.startsWith('core/') && !target.startsWith('core/domain/')) return 'presentation may use pure core/domain contracts, not core infrastructure';
  if (!from.name && /^(common|config|infrastructure|core|shared_ui|l10n)\//.test(source)
    && /^(app\/|app\.|main\.|worker\.)/.test(target)) return 'shared code must not depend on application composition';
  if (from.name && !to.name) {
    if (language === 'mobile' && (target.startsWith('app/') || target.startsWith('main'))) return 'feature must not depend on application composition';
    if (language === 'api' && /^(app|main|worker)[./]/.test(target)) return 'module must not depend on application composition';
    if (from.tail[0] === 'application' && target.startsWith('infrastructure/')) return 'application must depend on an infrastructure contract';
  }
  if (!from.name && to.name) {
    if (/^(common|core|shared_ui|l10n)\//.test(source)) return 'shared code must not depend on features';
    if (language === 'api') {
      if (to.tail.join('/') !== 'index.ts'
        && !(source.endsWith('.module.ts') && moduleEntry)) return 'composition imports the module entry, not its internal controller/service';
    } else if (!source.startsWith('app/')) return 'only app composition may wire feature implementations';
  }
  return null;
}
