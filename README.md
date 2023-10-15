# @taretmch/capacitor-auth0

Native Auth0 SDK wrappter for capacitor

## Install

```bash
npm install @taretmch/capacitor-auth0
npx cap sync
```

## API

<docgen-index>

* [`login()`](#login)
* [`logout()`](#logout)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### login()

```typescript
login() => Promise<Auth0User>
```

**Returns:** <code>Promise&lt;<a href="#auth0user">Auth0User</a>&gt;</code>

--------------------


### logout()

```typescript
logout() => Promise<void>
```

--------------------


### Interfaces


#### Auth0User

| Prop        | Type                |
| ----------- | ------------------- |
| **`id`**    | <code>string</code> |
| **`name`**  | <code>string</code> |
| **`email`** | <code>string</code> |

</docgen-api>
