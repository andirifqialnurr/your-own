import type { ActorContext, ActorAssurance, StaffGrantContext } from '../contracts/actor-context.js';
import type { IdentityResolution } from '../contracts/identity-authority.js';

/** Server-owned requirement, never selected by a client flag or request body. */
export type IdentityAccessRequirement =
  | { readonly kind: 'own-data'; readonly ownerUserId: string }
  | { readonly kind: 'operator'; readonly capability: string };

/** A local policy verdict, not a credential or an authenticated principal. */
export type IdentityAccessDecision = {
  readonly status: 'allowed' | 'denied' | 'unavailable';
};

function record(value: unknown): value is Record<string, unknown> {
  return typeof value === 'object' && value !== null && !Array.isArray(value);
}

function reference(value: unknown): value is string {
  return typeof value === 'string' && value.length > 0 && value.trim() === value
    && [...value].every((character) => {
      const code = character.charCodeAt(0);
      return code >= 32 && code !== 127;
    });
}

function assurance(value: unknown): value is ActorAssurance {
  if (!record(value)) return false;
  return value.method === 'primary' || value.method === 'mfa' || value.method === 'recovery'
    || (value.method === 'totp' && (value.freshness === 'fresh' || value.freshness === 'stale'));
}

function staffGrant(value: unknown): value is StaffGrantContext {
  if (!record(value)) return false;
  return value.status === 'none' || value.status === 'revoked'
    || (value.status === 'current' && reference(value.authorityReference)
      && Array.isArray(value.capabilities) && Array.from(value.capabilities).every(reference));
}

function actor(value: unknown): value is ActorContext {
  return record(value) && reference(value.userId) && reference(value.authorityReference)
    && (value.scope === 'personal' || value.scope === 'operator')
    && (value.lifecycle === 'active' || value.lifecycle === 'suspended'
      || value.lifecycle === 'deleting' || value.lifecycle === 'deleted')
    && (value.authenticationState === 'current' || value.authenticationState === 'pending'
      || value.authenticationState === 'revoked' || value.authenticationState === 'expired')
    && typeof value.emailVerified === 'boolean' && assurance(value.assurance) && staffGrant(value.staffGrant);
}

function requirement(value: unknown): value is IdentityAccessRequirement {
  return record(value) && ((value.kind === 'own-data' && reference(value.ownerUserId))
    || (value.kind === 'operator' && reference(value.capability)));
}

/**
 * Evaluate only an already trusted, authority-owned snapshot. Defensive shape
 * checks are not authentication and do not prove freshness or current grants.
 * This function performs no I/O and cannot establish an authorization point
 * for a concurrent domain mutation. No application route currently calls it.
 */
export function evaluateIdentityAccess(
  resolution: IdentityResolution | null | undefined,
  required: IdentityAccessRequirement,
): IdentityAccessDecision {
  if (!requirement(required) || !record(resolution)) return { status: 'denied' };
  if (resolution.status === 'unavailable') return { status: 'unavailable' };
  if (resolution.status !== 'authenticated' || !actor(resolution.actor)) return { status: 'denied' };

  const context = resolution.actor;
  if (context.lifecycle !== 'active' || context.authenticationState !== 'current'
    || context.emailVerified !== true) return { status: 'denied' };

  if (required.kind === 'own-data') {
    return {
      status: context.scope === 'personal' && context.userId === required.ownerUserId ? 'allowed' : 'denied',
    };
  }

  return {
    status: context.scope === 'operator' && context.staffGrant.status === 'current'
      && context.staffGrant.capabilities.includes(required.capability)
      && context.assurance.method === 'totp' && context.assurance.freshness === 'fresh'
      ? 'allowed' : 'denied',
  };
}
