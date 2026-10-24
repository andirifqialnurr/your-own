import { Module } from '@nestjs/common';
import { HealthModule } from './health/health.module.js';

// Compose public module entries, not their internal controllers or services.
@Module({ imports: [HealthModule] })
export class AppModule {}
