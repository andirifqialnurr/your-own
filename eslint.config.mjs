import js from '@eslint/js';
import tseslint from 'typescript-eslint';

export default tseslint.config(
  { ignores: ['**/node_modules/**', '**/dist/**', 'apps/mobile/**', '.local/**'] },
  js.configs.recommended,
  {
    files: ['**/*.{js,mjs,cjs}'],
    languageOptions: {
      globals: {
        process: 'readonly', console: 'readonly', Buffer: 'readonly',
        require: 'readonly', setTimeout: 'readonly', clearTimeout: 'readonly',
        setImmediate: 'readonly', URL: 'readonly', fetch: 'readonly',
      },
    },
  },
  {
    files: ['apps/api/src/**/*.ts'],
    extends: [tseslint.configs.recommendedTypeChecked],
    languageOptions: {
      parserOptions: { project: './apps/api/tsconfig.json', tsconfigRootDir: import.meta.dirname },
    },
  },
);
