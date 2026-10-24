import { Module } from '@nestjs/common';
import { HealthController } from './health/health.controller.js';

// HTTP composition only. No worker consumers, providers or domain writes yet.
@Module({ controllers: [HealthController] })
export class AppModule {}
