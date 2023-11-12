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

capacitor-auth0 has no implementation for web. You can use [auth0-js](

## API

<docgen-index>

* [`configure(...)`](#configure)
* [`login()`](#login)
* [`logout()`](#logout)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### configure(...)

```typescript
configure(options: CapacitorAuth0Conf) => Promise<void>
```

| Param         | Type                                                              |
| ------------- | ----------------------------------------------------------------- |
| **`options`** | <code><a href="#capacitorauth0conf">CapacitorAuth0Conf</a></code> |

--------------------


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


#### CapacitorAuth0Conf

| Prop           | Type                |
| -------------- | ------------------- |
| **`domain`**   | <code>string</code> |
| **`clientId`** | <code>string</code> |


#### Auth0User

| Prop        | Type                |
| ----------- | ------------------- |
| **`id`**    | <code>string</code> |
| **`name`**  | <code>string</code> |
| **`email`** | <code>string</code> |

</docgen-api>
