import type { ActorContext } from './actor-context.js';

/** Internal outcomes, not an HTTP status/response or authentication protocol. */
export type IdentityResolution =
  | { readonly status: 'authenticated'; readonly actor: ActorContext }
  | { readonly status: 'denied' }
  | { readonly status: 'unavailable' };

/**
 * Future request-bound authority port; intentionally no implementation or DI.
 * A future adapter must verify its server-held request context and current
 * authority state before returning an actor. It must not read an actor from a
 * client DTO, use shared mutable request state or return a fixture identity.
 * Credential extraction/verification and transport binding are outside S0.
 */
export interface IdentityAuthority {
  resolveActor(): Promise<IdentityResolution>;
}
