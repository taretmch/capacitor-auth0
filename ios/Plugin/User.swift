//
//  User.swift
//  TaretmchCapacitorAuth0
//
//  Created by tomoki.mizogami on 2023/10/15.
//

import Foundation

import JWTDecode

struct User {

    public static let publicClaims = [
        "sub",
        "name",
        "given_name",
        "family_name",
        "middle_name",
        "nickname",
        "preferred_username",
        "profile",
        "picture",
        "website",
        "email",
        "email_verified",
        "gender",
        "birthdate",
        "zoneinfo",
        "locale",
        "phone_number",
        "phone_number_verified",
        "address",
        "updated_at"
    ]

    /**
     * The user identifier.
     */
    let id: String

    /**
     * The name of the user.
     * Require `profile` scope.
     */
    let name: String?

    /**
     * The given name of the user.
     * Require `profile` scope.
     */
    let givenName: String?

    /**
     * The family name of the user.
     * Require `profile` scope.
     */
    let familyName: String?

    /**
     * The middle name of the user.
     * Require `profile` scope.
     */
    let middleName: String?

    /**
     * The nickname of the user.
     * Require `profile` scope.
     */
    let nickname: String?

    /**
     * The preferred username of the user.
     * Require `profile` scope.
     */
    let preferredUsername: String?

    /**
     * The URL of the user's profile page.
     * Require `profile` scope.
     */
    let profile: String?

    /**
     * The URL of the user's profile picture.
     * Require `profile` scope.
     */
    let picture: String?

    /**
     * The URL of the user's website.
     * Require `profile` scope.
     */
    let website: String?

    /**
     * The gender of the user.
     * Require `profile` scope.
     */
    let gender: String?

    /**
     * The birthdate of the user.
     * Require `profile` scope.
     */
    let birthdate: String?

    /**
     * The zoneinfo of the user.
     * Require `profile` scope.
     */
    let zoneinfo: String?

    /**
     * The locale of the user.
     * Require `profile` scope.
     */
    let locale: String?

    /**
     * Datetime of last updated.
     * Requre `profile` scope.
     */
    let updatedAt: String?

    /**
     * The email address of the user.
     * Require `email` scope.
     */
    let email: String?

    /**
     * If the user's email is verified.
     * Require `email` scope.
     */
    let emailVerified: Bool?

    /**
     * The address of the user.
     * Require `address` scope.
     */
    let address: [String: String]?

    /**
     * The phone number of the user.
     * Require `phone` scope.
     */
    let phoneNumber: String?

    /**
     * If the user's phone number is verified.
     * Require `phone` scope.
     */
    let phoneNumberVerified: Bool?

    /**
     * Other claims from the identity token.
     */
    let customClaims: [String: Any]?

}

extension User {
    init?(from idToken: String) {
        guard let jwt = try? decode(jwt: idToken),
              let id = jwt.subject else {
            return nil
        }
        
        let name = jwt["name"].string
        let givenName = jwt["given_name"].string
        let familyName = jwt["family_name"].string
        let middleName = jwt["middle_name"].string
        let nickname = jwt["nickname"].string
        let preferredUsername = jwt["preferred_username"].string
        let profile = jwt["profile"].string
        let picture = jwt["picture"].string
        let website = jwt["website"].string
        let gender = jwt["gender"].string
        let birthdate = jwt["birthdate"].string
        let zoneinfo = jwt["zoneinfo"].string
        let locale = jwt["locale"].string
        let updatedAt = jwt["updated_at"].string
        let email = jwt["email"].string
        let emailVerified = jwt["email_verified"].boolean
        let address = jwt["address"].rawValue as? [String: String]
        let phoneNumber = jwt["phone_number"].string
        let phoneNumberVerified = jwt["phone_number_verified"].boolean
        
        var customClaims = jwt.body
        User.publicClaims.forEach { customClaims.removeValue(forKey: $0) }
        
        self.init(id: id,
                  name: name,
                  givenName: givenName,
                  familyName: familyName,
                  middleName: middleName,
                  nickname: nickname,
                  preferredUsername: preferredUsername,
                  profile: profile,
                  picture: picture,
                  website: website,
                  gender: gender,
                  birthdate: birthdate,
                  zoneinfo: zoneinfo,
                  locale: locale,
                  updatedAt: updatedAt,
                  email: email,
                  emailVerified: emailVerified,
                  address: address,
                  phoneNumber: phoneNumber,
                  phoneNumberVerified: phoneNumberVerified,
                  customClaims: customClaims)
    }
}
