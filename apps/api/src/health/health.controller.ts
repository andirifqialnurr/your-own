import { Controller, Get, HttpCode } from '@nestjs/common';

@Controller('health')
export class HealthController {
  @Get('live')
  live(): { status: 'ok' } {
    return { status: 'ok' };
  }

  // Listening is not readiness to accept personal records or production traffic.
  @Get('ready')
  @HttpCode(503)
  ready(): { status: 'not_ready' } {
    return { status: 'not_ready' };
  }
}
