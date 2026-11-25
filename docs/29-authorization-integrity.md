# P0 authorization and integrity review
Proposed backend-only database access; no browser table grants. Identity must originate from verified JWT and active membership, never caller-supplied actor alone. Private room requires owner plus active project membership; shared room requires active project membership. Effective write permission is intersection of workspace and project role; viewers cannot mutate. Workspace owner does not automatically read private rooms or keys. AI actors never receive human credentials or membership privileges.

| Resource | Read | Write |
|---|---|---|
| Workspace/project | active membership and project ACL | owner/editor within scope |
| Room/messages | active project ACL and private owner or shared visibility | same plus editor/owner; AI output only through authorized run |
| Credential metadata | owner or valid shared grant | owner; revoke/rotate audited |
| Vault ciphertext | isolated resolver only | isolated rotation service |
| Context | source owner or authorized shared/granted source plus project ACL | authorized owner/editor; revoke rechecked |
| Budget/ledger | authorized payer or budget administrator | internal accounting service only |
| Jobs/outbox/tickets | internal scoped service | internal transaction primitives only |

## Physical changes
Room owner and visibility with composite project membership FK; typed generated budget scope FKs; workspace scope equality; GiST exclusion for overlapping half-open budget periods (btree_gist prerequisite); encrypted credential versions moved to separate private schema with forced RLS and no public grants. No policies granting access yet: deny-default remains intentional until backend role and trusted identity propagation are selected. Existing transaction functions remain invoker-only. No production grants.

## Dispatch integrity contract
Resolve participant model, credential version, provider/endpoint, pricing and consent manifest from persisted records, not request-supplied aliases. All must match workspace/project/room and destination; reject mismatch. Recheck active membership, grants, expiry, revocation and source revisions under transaction policy lock. Derive all applicable budget scopes server-side; no caller-selected subset. Budget edits and reservations must serialize on workspace policy row. No external call inside transaction. These checks are not yet enforced by executable routines.

## Planned tests
AUTH-01 outsider; AUTH-02 private room owner isolation; AUTH-03 viewer mutation; AUTH-04 revoked project member; AUTH-05 private credential; AUTH-06 expired shared grant; AUTH-07 vault denied to API role; AUTH-08 cross-tenant scope FK; AUTH-09 overlapping period rejection and adjacent period acceptance; AUTH-10 mismatched destination/pricing; AUTH-11 omitted budget scope; AUTH-12 revoked source before dispatch. No tests executed.
