//
//  Category.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-19.
//

import Foundation

// MARK: - Category
public struct CategoryResponse: Codable {
    public let success: Bool?
    public let message: String?
    public let totalCategories: Int?
    public let categories: [Categories]?

    public init(success: Bool?, message: String?, totalCategories: Int?, categories: [Categories]?) {
        self.success = success
        self.message = message
        self.totalCategories = totalCategories
        self.categories = categories
    }
}

// MARK: - Categories
public struct Categories: Codable {
    public let id, category, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case category, createdAt, updatedAt
    }

    public init(id: String?, category: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.category = category
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
