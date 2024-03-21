//
//  Favourites.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-19.
//

import Foundation

// MARK: - Favourite
public struct FavouriteResponse: Codable {
    public let success: Bool?
    public let message: String?
    public let totalLikedProducts: Int?
    public let likedProducts: [Product]?

    public init(success: Bool?, message: String?, totalLikedProducts: Int?, likedProducts: [Product]?) {
        self.success = success
        self.message = message
        self.totalLikedProducts = totalLikedProducts
        self.likedProducts = likedProducts
    }
}
