//
//  Card.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-19.
//

import Foundation

// MARK: - Category
public struct CardResponse: Codable {
    public let success: Bool?
    public let message: String?
    public let cards: [Card]?

    public init(success: Bool?, message: String?, cards: [Card]?) {
        self.success = success
        self.message = message
        self.cards = cards
    }
}

// MARK: - Categories
public struct Card: Codable {
    public var id: String?
    public var cardNumber: String?
    public var expMonth: String?
    public var cvv: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case cardNumber, expMonth, cvv
    }

    public init(id: String?, cardNumber: String?, expMonth: String?, cvv: String?) {
        self.id = id
        self.cardNumber = cardNumber
        self.expMonth = expMonth
        self.cvv = cvv
    }
}

