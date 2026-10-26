export type {
  ActorContext,
  ActorScope,
  ActorLifecycle,
  ActorAuthenticationState,
  ActorAssurance,
  StaffGrantContext,
} from './contracts/actor-context.js';
export type { IdentityAuthority, IdentityResolution } from './contracts/identity-authority.js';
export {
  evaluateIdentityAccess,
  type IdentityAccessRequirement,
  type IdentityAccessDecision,
} from './domain/identity-access.js';
