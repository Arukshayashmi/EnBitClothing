//
//  Images.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-19.
//

import Foundation

// MARK: - ImageResponse
public struct ImageResponse: Codable {
    public let success: Bool?
    public let message: String?
    public let publicId: String?
    public let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case success, message
        case publicId = "publicId"
        case imageUrl = "imageUrl"
    }

    public init(success: Bool?, message: String?, publicId: String?, imageUrl: String?) {
        self.success = success
        self.message = message
        self.publicId = publicId
        self.imageUrl = imageUrl
    }
}
