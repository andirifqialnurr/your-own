export interface AppConfig {
  readonly environment: 'development' | 'test';
  readonly host: '127.0.0.1';
  readonly port: number;
}

export class ConfigurationError extends Error {}

export function readEnvironment(env: NodeJS.ProcessEnv): AppConfig {
  const environment = env.APP_ENV;
  if (environment !== 'development' && environment !== 'test') {
    throw new ConfigurationError('APP_ENV must be development or test. Deployment is not configured.');
  }
  if (env.API_HOST !== undefined && env.API_HOST !== '127.0.0.1') {
    throw new ConfigurationError('API_HOST must be 127.0.0.1 for this local bootstrap.');
  }
  const rawPort = env.API_PORT ?? '3000';
  if (!/^[1-9][0-9]{0,4}$/.test(rawPort) || Number(rawPort) > 65535) {
    throw new ConfigurationError('API_PORT must be an integer from 1 to 65535.');
  }
  return Object.freeze({ environment, host: '127.0.0.1', port: Number(rawPort) });
}
