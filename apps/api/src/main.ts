import { createApplication } from './app.js';
import { ConfigurationError, readEnvironment } from './config/environment.js';

async function main(): Promise<void> {
  const config = readEnvironment(process.env);
  const app = await createApplication();
  try {
    await app.listen(config.port, config.host);
    console.info(`Local API: http://${config.host}:${config.port}/v1/health/live`);
  } catch (error: unknown) {
    await app.close();
    throw error;
  }
}

void main().catch((error: unknown) => {
  // Do not echo raw environment values, connection strings or error payloads.
  console.error(error instanceof ConfigurationError ? error.message : 'API startup failed. Check local configuration and port availability.');
  process.exitCode = 1;
});
