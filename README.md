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
login() => Promise<LoginResult>
```

**Returns:** <code>Promise&lt;<a href="#loginresult">LoginResult</a>&gt;</code>

--------------------


### logout()

```typescript
logout() => Promise<void>
```

--------------------


### Interfaces


#### LoginResult

| Prop       | Type                                            |
| ---------- | ----------------------------------------------- |
| **`user`** | <code><a href="#auth0user">Auth0User</a></code> |


#### Auth0User

| Prop        | Type                |
| ----------- | ------------------- |
| **`id`**    | <code>string</code> |
| **`name`**  | <code>string</code> |
| **`email`** | <code>string</code> |

</docgen-api>
