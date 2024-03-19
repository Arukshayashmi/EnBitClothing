//
//  Product.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-19.
//

import Foundation

// MARK: - Product
public struct ProductResponse: Codable {
        public let success: Bool?
        public let message: String?
        public let totalProducts: Int?
        public let products: [Product]?

        public init(success: Bool?, message: String?, totalProducts: Int?, products: [Product]?) {
            self.success = success
            self.message = message
            self.totalProducts = totalProducts
            self.products = products
        }
    }

    // MARK: - ProductElement
    public struct Product: Codable {
        public let id, name, description: String?
        public let price: Int?
        public let category: Category?
        public let images: [Images]?
        public let createdAt, updatedAt: String?
        public let isFavourite: Bool?

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name, description, price, category, images, createdAt, updatedAt
            case isFavourite
        }

        public init(id: String?, name: String?, description: String?, price: Int?, category: Category?, images: [Images]?, createdAt: String?, updatedAt: String?, isFavourite: Bool?) {
            self.id = id
            self.name = name
            self.description = description
            self.price = price
            self.category = category
            self.images = images
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.isFavourite = isFavourite
        }
    }

    // MARK: - Category
    public struct Category: Codable {
        public let id, category: String?

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case category
        }

        public init(id: String?, category: String?) {
            self.id = id
            self.category = category
        }
    }

    // MARK: - Image
    public struct Images: Codable {
        public let publicID: String?
        public let url: String?
        public let id: String?

        enum CodingKeys: String, CodingKey {
            case publicID = "public_id"
            case url
            case id = "_id"
        }

        public init(publicID: String?, url: String?, id: String?) {
            self.publicID = publicID
            self.url = url
            self.id = id
        }
    }
