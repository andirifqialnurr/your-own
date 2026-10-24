import { Module } from '@nestjs/common';
import { HealthController } from './health.controller.js';

// Public composition entry. The controller stays internal to this module.
@Module({ controllers: [HealthController] })
export class HealthModule {}
