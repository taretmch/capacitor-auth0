# @taretmch/capacitor-auth0

Native Auth0 SDK wrappter for capacitor

## Install

```bash
npm install @taretmch/capacitor-auth0
npx cap sync
```

### For iOS

Setup Auth0 domain & clientId at `ios/App/App/Auth0.plist`.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>ClientId</key>
    <string>{AUTH0_CLIENT_ID}</string>
    <key>Domain</key>
    <string>{AUTH0_DOMAIN}</string>
</dict>
</plist>
```

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

* [`load()`](#load)
* [`login()`](#login)
* [`logout()`](#logout)
* [`isAuthenticated()`](#isauthenticated)
* [`getUserInfo()`](#getuserinfo)
* [`getCredentials()`](#getcredentials)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

Capacitor Auth0 Plugin

### load()

```typescript
load() => Promise<User>
```

Load auth0 plugin.
Get the authenticated user profile and update the credentials
using the refresh token if the access token is expired.
For android, initialize the plugin with your Auth0 configuration.
Return undefined if the user is not authenticated.

**Returns:** <code>Promise&lt;<a href="#user">User</a>&gt;</code>

--------------------


### login()

```typescript
login() => Promise<User>
```

Web Auth: Login with Auth0.

**Returns:** <code>Promise&lt;<a href="#user">User</a>&gt;</code>

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

Check if the user is authenticated.

**Returns:** <code>Promise&lt;{ result: boolean; }&gt;</code>

--------------------


### getUserInfo()

```typescript
getUserInfo() => Promise<User>
```

Get the authenticated user profile.
If the access token is expired, yield new credentials using the refresh token.
Throws an error if the user is not authenticated.

**Returns:** <code>Promise&lt;<a href="#user">User</a>&gt;</code>

--------------------


### getCredentials()

```typescript
getCredentials() => Promise<Credentials>
```

Get credentials and yield new credentials using the refresh token if the access token is expired.
Return undefined if the user is not authenticated.

**Returns:** <code>Promise&lt;<a href="#credentials">Credentials</a>&gt;</code>

--------------------


### Interfaces


#### User

Auth0 user profile.

| Prop                      | Type                          | Description                                                     |
| ------------------------- | ----------------------------- | --------------------------------------------------------------- |
| **`id`**                  | <code>string</code>           | The user identifier.                                            |
| **`name`**                | <code>string</code>           | The name of the user. Require `profile` scope.                  |
| **`givenName`**           | <code>string</code>           | The given name of the user. Require `profile` scope.            |
| **`familyName`**          | <code>string</code>           | The family name of the user. Require `profile` scope.           |
| **`middleName`**          | <code>string</code>           | The middle name of the user. Require `profile` scope.           |
| **`nickname`**            | <code>string</code>           | The nickname of the user. Require `profile` scope.              |
| **`preferredUsername`**   | <code>string</code>           | The preferred username of the user. Require `profile` scope.    |
| **`profile`**             | <code>string</code>           | The URL of the user's profile page. Require `profile` scope.    |
| **`picture`**             | <code>string</code>           | The URL of the user's profile picture. Require `profile` scope. |
| **`website`**             | <code>string</code>           | The URL of the user's website. Require `profile` scope.         |
| **`gender`**              | <code>string</code>           | The gender of the user. Require `profile` scope.                |
| **`birthdate`**           | <code>string</code>           | The birthdate of the user. Require `profile` scope.             |
| **`zoneinfo`**            | <code>string</code>           | The zoneinfo of the user. Require `profile` scope.              |
| **`locale`**              | <code>string</code>           | The locale of the user. Require `profile` scope.                |
| **`updatedAt`**           | <code>string</code>           | Datetime of last updated. Requre `profile` scope.               |
| **`email`**               | <code>string</code>           | The email address of the user. Require `email` scope.           |
| **`emailVerified`**       | <code>boolean</code>          | If the user's email is verified. Require `email` scope.         |
| **`address`**             | <code>[string: string]</code> | The address of the user. Require `address` scope.               |
| **`phoneNumber`**         | <code>string</code>           | The phone number of the user. Require `phone` scope.            |
| **`phoneNumberVerified`** | <code>boolean</code>          | If the user's phone number is verified. Require `phone` scope.  |
| **`customClaims`**        | <code>[string: any]</code>    | Other claims from the identity token.                           |


#### Credentials

Auth0 credentials.

| Prop               | Type                | Description                                                                                                                                      |
| ------------------ | ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **`idToken`**      | <code>string</code> | Identity token that contains user profile information.                                                                                           |
| **`accessToken`**  | <code>string</code> | Access token for Auth0 API.                                                                                                                      |
| **`expiresAt`**    | <code>string</code> | Access token expiration date. Once expired, the access token can no longer be used to access an API and a new access token needs to be obtained. |
| **`scope`**        | <code>string</code> | Granted scopes for the access token. Undefined if no scope is granted.                                                                           |
| **`refreshToken`** | <code>string</code> | Refresh token that can be used to request a new access token without signin again. Undefined if no refresh token is granted.                     |
| **`tokenType`**    | <code>string</code> | Type of received token.                                                                                                                          |

</docgen-api>
