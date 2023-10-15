import Foundation
import Capacitor
import Auth0

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorAuth0Plugin)
public class CapacitorAuth0Plugin: CAPPlugin {

    @objc func login(_ call: CAPPluginCall) {
        Auth0
            .webAuth()
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
}
