/** Internal application intent, not a transport realm or token claim. */
export type ActorScope = 'personal' | 'operator';

export type ActorLifecycle = 'active' | 'suspended' | 'deleting' | 'deleted';

export type ActorAuthenticationState = 'current' | 'pending' | 'revoked' | 'expired';

/**
 * The future authority must establish method/freshness from trusted evidence.
 * These values do not verify a code, read a clock or adopt timeout policy.
 */
export type ActorAssurance =
  | { readonly method: 'primary' | 'mfa' | 'recovery' }
  | { readonly method: 'totp'; readonly freshness: 'fresh' | 'stale' };

export type StaffGrantContext =
  | { readonly status: 'none' | 'revoked' }
  | {
    readonly status: 'current';
    readonly authorityReference: string;
    readonly capabilities: readonly string[];
  };

/**
 * Authority-owned snapshot for internal policy evaluation, never a request DTO.
 * No credential, hash, email address, profile, JWT or SQL representation belongs
 * here. References are non-secret correlation references, not bearer authority.
 * A matching TypeScript/JSON shape does not establish trusted provenance or
 * current state. A future authority and operation coordination must do that.
 */
export interface ActorContext {
  readonly userId: string;
  readonly authorityReference: string;
  readonly scope: ActorScope;
  readonly lifecycle: ActorLifecycle;
  readonly authenticationState: ActorAuthenticationState;
  readonly emailVerified: boolean;
  readonly assurance: ActorAssurance;
  readonly staffGrant: StaffGrantContext;
}
