# @taretmch/capacitor-auth0

Native Auth0 SDK wrappter for capacitor

## Install

```bash
npm install @taretmch/capacitor-auth0
npx cap sync
```

### For iOS

Setup Custom URL Scheme at `Info.plist`.

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>${PRODUCT_BUNDLE_IDENTIFIER}</string>
        </array>
    </dict>
</array>
```

capacitor-auth0 uses [Auth0.swift](https://github.com/auth0/Auth0.swift) internally. For more information, see Auth0.swift quickstart guide.

### For Android

Setup Auth0 domain & clientId at `android/app/src/main/res/values/strings.xml`.

```xml
<?xml version='1.0' encoding='utf-8'?>
<resources>
    <string name="com_auth0_domain">{AUTH0_DOMAIN}</string>
    <string name="com_auth0_client_id">{AUTH0_CLIENT_ID}</string>
</resources>
```

Add manifestPlaceholders at `android/app/build.gradle`.

```gradle
android {
    ...
    defaultConfig {
        ...
        manifestPlaceholders = [auth0Domain: "@string/com_auth0_domain", auth0Scheme: "demo"]
    }
}
```

capacitor-auth0 uses [Auth0.Android](https://github.com/auth0/Auth0.Android) internally. For more information, see Auth0.Android quickstart guide.

### For Web

capacitor-auth0 has no implementation for web. You can use [auth0-spa-js](https://github.com/auth0/auth0-spa-js) instead.

## API

<docgen-index>

* [`configure(...)`](#configure)
* [`login()`](#login)
* [`logout()`](#logout)
* [`isAuthenticated()`](#isauthenticated)
* [`getUserInfo()`](#getuserinfo)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

Capacitor Auth0 Plugin

### configure(...)

```typescript
configure(options: CapacitorAuth0Conf) => Promise<void>
```

Configure the plugin with your Auth0 credentials.

| Param         | Type                                                              | Description                                          |
| ------------- | ----------------------------------------------------------------- | ---------------------------------------------------- |
| **`options`** | <code><a href="#capacitorauth0conf">CapacitorAuth0Conf</a></code> | <a href="#capacitorauth0conf">CapacitorAuth0Conf</a> |

--------------------


### login()

```typescript
login() => Promise<Auth0User>
```

Web Auth: Login with Auth0.

**Returns:** <code>Promise&lt;<a href="#auth0user">Auth0User</a>&gt;</code>

--------------------


### logout()

```typescript
logout() => Promise<void>
```

Web Auth: Logout from Auth0.

--------------------


### isAuthenticated()

```typescript
isAuthenticated() => Promise<{ result: boolean; }>
```

Check if a user is authenticated.

**Returns:** <code>Promise&lt;{ result: boolean; }&gt;</code>

--------------------


### getUserInfo()

```typescript
getUserInfo() => Promise<Auth0User>
```

Get a latest authenticated user profile.

**Returns:** <code>Promise&lt;<a href="#auth0user">Auth0User</a>&gt;</code>

--------------------


### Interfaces


#### CapacitorAuth0Conf

Configuration options for the plugin.

| Prop           | Type                | Description           |
| -------------- | ------------------- | --------------------- |
| **`domain`**   | <code>string</code> | Your Auth0 domain.    |
| **`clientId`** | <code>string</code> | Your Auth0 client ID. |


#### Auth0User

Auth0 user profile.

| Prop        | Type                | Description |
| ----------- | ------------------- | ----------- |
| **`id`**    | <code>string</code> | User ID.    |
| **`name`**  | <code>string</code> | User name.  |
| **`email`** | <code>string</code> | User email. |

</docgen-api>
