//
//  Cart.swift
//  EnBitClothings
//
//  Created by Anushka on 2024-03-19.
//

import Foundation

// MARK: - Cart
public struct CartResponse: Codable {
    public let success: Bool?
    public let message: String?
    public let checkoutProducts: [CheckoutProduct]?

    public init(success: Bool?, message: String?, checkoutProducts: [CheckoutProduct]?) {
        self.success = success
        self.message = message
        self.checkoutProducts = checkoutProducts
    }
}

// MARK: - CheckoutProduct
public struct CheckoutProduct: Codable {
    public let id: String?
    public let productDetails: Product?
    public let status: Int?
    public let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case productDetails, status, createdAt, updatedAt
    }

    public init(id: String?, productDetails: Product?, status: Int?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.productDetails = productDetails
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
