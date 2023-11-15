import Foundation
import Capacitor
import Auth0

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorAuth0Plugin)
public class CapacitorAuth0Plugin: CAPPlugin {
    
    var clientId: String?
    var domain: String?
    var credentialsManager: CredentialsManager?
    
    @objc func configure(_ call: CAPPluginCall) {
        guard
            let clientId = call.getString("clientId"),
            let domain = call.getString("domain") else {
            call.reject("Failed to init CapacitorAuth0")
            return
        }
        
        self.clientId = clientId
        self.domain = domain
        self.credentialsManager = CredentialsManager(authentication: Auth0.authentication())
        call.resolve()
    }

    @objc func login(_ call: CAPPluginCall) {
        guard
            let clientId = self.clientId,
            let domain = self.domain,
            let credentialsManager = self.credentialsManager else {
            call.reject("Plugin is not configured. Call configure method before login.")
            return
        }
        
        Auth0
            .webAuth(clientId: clientId, domain: domain)
            .scope("openid profile offline_access") // Include refresh_token
            .start { result in
                switch result {
                case .success(let credentials):
                    let user = User(from: credentials.idToken)
                    let didStore = credentialsManager.store(credentials: credentials)
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
        guard
            let clientId = self.clientId,
            let domain = self.domain,
            let credentialsManager = self.credentialsManager else {
            call.reject("Plugin is not configured. Call configure method before login.")
            return
        }
        
        Auth0
            .webAuth(clientId: clientId, domain: domain)
            .clearSession { result in
                switch result {
                case .success:
                    let didClear = credentialsManager.clear()
                    print("CapacitorAuth0 -- Credentials are cleared: ", didClear)
                    call.resolve()
                case .failure(let error):
                    call.reject("Failed with: \(error)")
                }
            }

    }
    
    @objc func isAuthenticated(_ call: CAPPluginCall) {
        guard
            let credentialsManager = self.credentialsManager else {
            call.reject("Plugin is not configured. Call configure method before login.")
            return
        }
        
        guard credentialsManager.canRenew() else {
            call.resolve(["result": false])
            return
        }
        call.resolve(["result": true])
    }
    
    @objc func getUserInfo(_ call: CAPPluginCall) {
        guard
            let credentialsManager = self.credentialsManager else {
            call.reject("Plugin is not configured. Call configure method before login.")
            return
        }

        guard credentialsManager.canRenew() else {
            call.reject("Not authenticated.")
            return
        }

        credentialsManager.renew { result in
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
