//
//  Item.swift
//  EnBitClothings
//
//  Created by Dilshan Thalagahapitiya on 2024-03-14.
//

import Foundation



public struct Item: Codable {

    public var _id: Int?
    public var itemTitle: String?
    public var categoryId: String?
    public var price: Double?
    public var _description: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var imageUrl: String?
    public var imagePath: String?
    public var imageDisk: String?
    public var type: String?
    public var userId: String?
    public var isFavourite: Bool?

    public init(_id: Int?, itemTitle: String?, categoryId: String?, price: Double?, _description: String?, createdAt: String?, updatedAt: String?, imageUrl: String?, imagePath: String?, imageDisk: String?, type: String?, userId: String?, isFavourite: Bool?) {
        self._id = _id
        self.itemTitle = itemTitle
        self.categoryId = categoryId
        self.price = price
        self._description = _description
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.imageUrl = imageUrl
        self.imagePath = imagePath
        self.imageDisk = imageDisk
        self.type = type
        self.userId = userId
        self.isFavourite = isFavourite
    }

    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case itemTitle = "item_title"
        case categoryId = "category_id"
        case price
        case _description = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case imageUrl = "image_url"
        case imagePath = "image_path"
        case imageDisk = "image_disk"
        case type
        case userId = "user_id"
        case isFavourite = "is_favourite"
    }


}


