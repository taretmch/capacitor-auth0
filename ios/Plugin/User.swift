//
//  User.swift
//  TaretmchCapacitorAuth0
//
//  Created by tomoki.mizogami on 2023/10/15.
//

import Foundation

import JWTDecode

struct User {
    let id: String
    let name: String
    let email: String
}

extension User {
    init?(from idToken: String) {
        guard let jwt = try? decode(jwt: idToken),
              let id = jwt.subject,
              let name = jwt["name"].string,
              let email = jwt["email"].string else {
            return nil
        }
        self.id = id
        self.name = name
        self.email = email
    }
}
