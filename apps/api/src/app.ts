import 'reflect-metadata';
import type { IncomingMessage, ServerResponse } from 'node:http';
import { NestFactory } from '@nestjs/core';
import { ExpressAdapter, type NestExpressApplication } from '@nestjs/platform-express';
import { AppModule } from './app.module.js';

export async function createApplication(): Promise<NestExpressApplication> {
  const adapter = new ExpressAdapter();
  adapter.disable('x-powered-by');
  const app = await NestFactory.create<NestExpressApplication>(AppModule, adapter, {
    logger: false,
    abortOnError: false,
    bodyParser: false,
  });
  app.setGlobalPrefix('v1');
  app.use((_request: IncomingMessage, response: ServerResponse, next: () => void) => {
    response.setHeader('Cache-Control', 'no-store');
    response.setHeader('X-Content-Type-Options', 'nosniff');
    next();
  });
  app.enableShutdownHooks();
  return app;
}
