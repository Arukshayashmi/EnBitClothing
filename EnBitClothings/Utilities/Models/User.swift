//
//  User.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import Foundation



public struct User: Codable {

    public var _id: String?
    public var uuid: String?
    public var firstName: String?
    public var lastName: String?
    public var fullName: String?
    public var email: String?
    public var phone: String?
    public var image: String?
    public var avatarUrl: String?
    public var timezone: String?
    public var emailVerifiedAt: String?
    public var countryCode: String?
    public var dateOfBirth: String?
    public var address: String?
    public var city: String?
    public var postCode: String?
    public var state: String?
    public var profileCompleteStep: Int?
    public var isProfileCompleted: Bool?
    public var deactivatedAt: String?
    public var accessToken: String?


    public init(_id: String?, uuid: String?, firstName: String?, lastName: String?, fullName: String?, email: String?, phone: String?, image: String?, avatarUrl: String?, timezone: String?, emailVerifiedAt: String?, countryCode: String?, dateOfBirth: String?, address: String?, city: String?, postCode: String?, state: String?, profileCompleteStep: Int?, isProfileCompleted: Bool?, deactivatedAt: String?, accessToken: String?) {
        self._id = _id
        self.uuid = uuid
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.email = email
        self.phone = phone
        self.image = image
        self.avatarUrl = avatarUrl
        self.timezone = timezone
        self.emailVerifiedAt = emailVerifiedAt
        self.countryCode = countryCode
        self.dateOfBirth = dateOfBirth
        self.address = address
        self.city = city
        self.postCode = postCode
        self.state = state
        self.profileCompleteStep = profileCompleteStep
        self.isProfileCompleted = isProfileCompleted

    }

    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case uuid
        case firstName = "first_name"
        case lastName = "last_name"
        case fullName = "full_name"
        case email
        case phone
        case image
        case avatarUrl = "avatar_url"
        case timezone
        case emailVerifiedAt = "email_verified_at"
        case countryCode = "country_code"
        case dateOfBirth = "date_of_birth"
        case address
        case city
        case postCode = "post_code"
        case state
        case profileCompleteStep = "profile_complete_step"
        case isProfileCompleted = "is_completed_profile"

    }


}
