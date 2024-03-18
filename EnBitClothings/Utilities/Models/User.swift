//
//  User.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


//import Foundation
//
//public struct UserResponse: Codable {
//
//    public var message: String?
//    public var success: Bool?
//    public var token: String?
//    public var user: User?
//
//}
//
//public struct User: Codable {
//
//    public var _id: String?
//    public var firstName: String?
//    public var lastName: String?
//    public var email: String?
//    public var phone: String?
//    public var avatarUrl: String?
//    public var emailVerifiedAt: String?
//    public var dateOfBirth: String?
//    public var address: String?
//    public var city: String?
//    public var postCode: String?
//
//
//    public init(_id: String?, firstName: String?, lastName: String?, email: String?, phone: String?, avatarUrl: String?, emailVerifiedAt: String?, dateOfBirth: String?, address: String?, city: String?, postCode: String?) {
//        self._id = _id
//        self.firstName = firstName
//        self.lastName = lastName
//        self.email = email
//        self.phone = phone
//        self.avatarUrl = avatarUrl
//        self.emailVerifiedAt = emailVerifiedAt
//        self.dateOfBirth = dateOfBirth
//        self.address = address
//        self.city = city
//        self.postCode = postCode
//    }
//
//    public enum CodingKeys: String, CodingKey {
//        case _id = "id"
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case email
//        case phone
//        case avatarUrl = "avatar_url"
//        case emailVerifiedAt = "email_verify_at"
//        case dateOfBirth = "date_of_birth"
//        case address
//        case city
//        case postCode = "post_code"
//    }
//
//
//}



import Foundation

// MARK: - User
public struct UserResponse: Codable {
    public let success: Bool?
    public let message: String?
    public var token: String?
    public let user: User?

    public init(success: Bool?, message: String?, token: String?, user: User?) {
        self.success = success
        self.message = message
        self.token = token
        self.user = user
    }
}

// MARK: - UserClass
public struct User: Codable {
    public let profilePic: ProfilePic?
    public let id, email, confirmationCode, emailVerifyAt: String?
    public let createdAt, updatedAt: String?
    public let adress, city, dob, firstName: String?
    public let lastName, phone, postCode: String?

    enum CodingKeys: String, CodingKey {
        case profilePic
        case id = "_id"
        case email
        case confirmationCode = "confirmation_code"
        case emailVerifyAt = "email_verify_at"
        case createdAt, updatedAt
        case adress, city, dob
        case firstName = "first_name"
        case lastName = "last_name"
        case phone
        case postCode = "post_code"
    }

    public init(profilePic: ProfilePic?, id: String?, email: String?, confirmationCode: String?, emailVerifyAt: String?, createdAt: String?, updatedAt: String?, v: Int?, adress: String?, city: String?, dob: String?, firstName: String?, lastName: String?, phone: String?, postCode: String?) {
        self.profilePic = profilePic
        self.id = id
        self.email = email
        self.confirmationCode = confirmationCode
        self.emailVerifyAt = emailVerifyAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.adress = adress
        self.city = city
        self.dob = dob
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.postCode = postCode
    }
}

// MARK: - ProfilePic
public struct ProfilePic: Codable {
    public let publicID: String?
    public let url: String?

    enum CodingKeys: String, CodingKey {
        case publicID = "public_id"
        case url
    }

    public init(publicID: String?, url: String?) {
        self.publicID = publicID
        self.url = url
    }
}
