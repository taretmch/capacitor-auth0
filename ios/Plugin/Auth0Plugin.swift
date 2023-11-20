import Foundation
import Capacitor
import Auth0

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(Auth0Plugin)
public class Auth0Plugin: CAPPlugin {

    let credentialsManager: CredentialsManager = CredentialsManager(authentication: Auth0.authentication())
    
    @objc func load(_ call: CAPPluginCall) {
        self.credentialsManager.renew { result in
            switch result {
            case .success(let credentials):
                let user = User(from: credentials.idToken)
                call.resolve([
                    "id": user?.id as Any,
                    "name": user?.name as Any,
                    "givenName": user?.givenName as Any,
                    "familyName": user?.familyName as Any,
                    "middleName": user?.middleName as Any,
                    "nickname": user?.nickname as Any,
                    "preferredUsername": user?.preferredUsername as Any,
                    "profile": user?.profile as Any,
                    "picture": user?.picture as Any,
                    "website": user?.website as Any,
                    "gender": user?.gender as Any,
                    "birthdate": user?.birthdate as Any,
                    "zoneinfo": user?.zoneinfo as Any,
                    "locale": user?.locale as Any,
                    "updatedAt": user?.updatedAt as Any,
                    "email": user?.email as Any,
                    "emailVerified": user?.emailVerified as Any,
                    "address": user?.address as Any,
                    "phoneNumber": user?.phoneNumber as Any,
                    "phoneNumberVerified": user?.phoneNumberVerified as Any,
                    "customClaims": user?.customClaims as Any
                ])
            case .failure(_):
                call.resolve()
            }
        }
    }

    @objc func login(_ call: CAPPluginCall) {
        Auth0
            .webAuth()
            .scope("openid profile email offline_access") // Include refresh_token
            .start { result in
                switch result {
                case .success(let credentials):
                    let user = User(from: credentials.idToken)
                    let didStore = self.credentialsManager.store(credentials: credentials)
                    print("CapacitorAuth0 -- Credentials are saved: ", didStore)
                    call.resolve([
                        "id": user?.id as Any,
                        "name": user?.name as Any,
                        "givenName": user?.givenName as Any,
                        "familyName": user?.familyName as Any,
                        "middleName": user?.middleName as Any,
                        "nickname": user?.nickname as Any,
                        "preferredUsername": user?.preferredUsername as Any,
                        "profile": user?.profile as Any,
                        "picture": user?.picture as Any,
                        "website": user?.website as Any,
                        "gender": user?.gender as Any,
                        "birthdate": user?.birthdate as Any,
                        "zoneinfo": user?.zoneinfo as Any,
                        "locale": user?.locale as Any,
                        "updatedAt": user?.updatedAt as Any,
                        "email": user?.email as Any,
                        "emailVerified": user?.emailVerified as Any,
                        "address": user?.address as Any,
                        "phoneNumber": user?.phoneNumber as Any,
                        "phoneNumberVerified": user?.phoneNumberVerified as Any,
                        "customClaims": user?.customClaims as Any
                    ])
                case .failure(let error):
                    call.reject("Failed with: \(error)")
                }
            }

    }
    
    @objc func logout(_ call: CAPPluginCall) {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                case .success:
                    let didClear = self.credentialsManager.clear()
                    print("CapacitorAuth0 -- Credentials are cleared: ", didClear)
                    call.resolve()
                case .failure(let error):
                    call.reject("Failed with: \(error)")
                }
            }

    }
    
    @objc func isAuthenticated(_ call: CAPPluginCall) {
        guard self.credentialsManager.canRenew() else {
            call.resolve(["result": false])
            return
        }
        call.resolve(["result": true])
    }
    
    @objc func getUserInfo(_ call: CAPPluginCall) {
        guard self.credentialsManager.canRenew() else {
            call.reject("Not authenticated.")
            return
        }

        self.credentialsManager.renew { result in
            switch result {
            case .success(let credentials):
                let user = User(from: credentials.idToken)
                call.resolve([
                    "id": user?.id as Any,
                    "name": user?.name as Any,
                    "givenName": user?.givenName as Any,
                    "familyName": user?.familyName as Any,
                    "middleName": user?.middleName as Any,
                    "nickname": user?.nickname as Any,
                    "preferredUsername": user?.preferredUsername as Any,
                    "profile": user?.profile as Any,
                    "picture": user?.picture as Any,
                    "website": user?.website as Any,
                    "gender": user?.gender as Any,
                    "birthdate": user?.birthdate as Any,
                    "zoneinfo": user?.zoneinfo as Any,
                    "locale": user?.locale as Any,
                    "updatedAt": user?.updatedAt as Any,
                    "email": user?.email as Any,
                    "emailVerified": user?.emailVerified as Any,
                    "address": user?.address as Any,
                    "phoneNumber": user?.phoneNumber as Any,
                    "phoneNumberVerified": user?.phoneNumberVerified as Any,
                    "customClaims": user?.customClaims as Any
                ])
            case .failure(let error):
                call.reject("Renewing credentials is failed with: \(error)")
            }
        }

    }
    
    @objc func getCredentials(_ call: CAPPluginCall) {
        self.credentialsManager.credentials { result in
            switch result {
            case .success(let credentials):
                call.resolve([
                    "idToken": credentials.idToken,
                    "accessToken": credentials.accessToken,
                    "expiresAt": credentials.expiresIn,
                    "scope": credentials.scope as Any,
                    "refreshToken": credentials.refreshToken  as Any,
                    "tokenType": credentials.tokenType
                ])
            case .failure(let error):
                print("Failed with: \(error)")
                call.resolve()
            }
        }

    }
}
