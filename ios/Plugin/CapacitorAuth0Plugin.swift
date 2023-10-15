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
    
    @objc func configure(_ call: CAPPluginCall) {
        guard
            let clientId = call.getString("clientId"),
            let domain = call.getString("domain") else {
            call.reject("Failed to init CapacitorAuth0")
            return
        }
        
        self.clientId = clientId
        self.domain = domain
        call.resolve()
    }

    @objc func login(_ call: CAPPluginCall) {
        guard
            let clientId = self.clientId,
            let domain = self.domain else {
            call.reject("Plugin is not configured. Call configure method before login.")
            return
        }
        
        Auth0
            .webAuth(clientId: clientId, domain: domain)
            .start { result in
                switch result {
                case .success(let credentials):
                    let user = User(from: credentials.idToken)
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
            let domain = self.domain else {
            call.reject("Plugin is not configured. Call configure method before login.")
            return
        }
        
        Auth0
            .webAuth(clientId: clientId, domain: domain)
            .clearSession { result in
                switch result {
                case .success:
                    call.resolve()
                case .failure(let error):
                    call.reject("Failed with: \(error)")
                }
            }

    }
}
