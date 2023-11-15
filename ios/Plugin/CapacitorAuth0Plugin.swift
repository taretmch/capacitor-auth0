import Foundation
import Capacitor
import Auth0

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorAuth0Plugin)
public class CapacitorAuth0Plugin: CAPPlugin {

    let credentialsManager: CredentialsManager = CredentialsManager(authentication: Auth0.authentication())
    
    @objc func load(_ call: CAPPluginCall) {
        self.credentialsManager.renew { result in
            switch result {
            case .success(let credentials):
                let user = User(from: credentials.idToken)
                call.resolve([
                    "id": user?.id,
                    "name": user?.name,
                    "email": user?.email
                ])
            case .failure(let error):
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
                        "id": user?.id,
                        "name": user?.name,
                        "email": user?.email
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
                    "id": user?.id,
                    "name": user?.name,
                    "email": user?.email
                ])
            case .failure(let error):
                call.reject("Renewing credentials is failed with: \(error)")
            }
        }

    }
}
