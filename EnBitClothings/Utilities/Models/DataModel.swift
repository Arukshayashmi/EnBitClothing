//
//  DataModel.swift
//  EnBitClothings
//
//  Created by Dilshan Thalagahapitiya on 2024-03-14.
//

import SwiftUI

enum Dummy {
    
    static let category = [
        Categories(_id: 1, categoryName: "Kids"),
        Categories(_id: 2, categoryName: "Ladies"),
        Categories(_id: 3, categoryName: "Gents"),
        Categories(_id: 4, categoryName: "Other")
        
    ]
    
    static let ItemData = [
        Item(_id: 1, itemTitle: "Frock", categoryId: "1", price: 750.00, _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat", createdAt: "", updatedAt: "", imageUrl: "", imagePath: "", imageDisk: "", type: "", userId: "1", isFavourite: false),
        Item(_id: 2, itemTitle: "Shirt", categoryId: "2", price: 750.00, _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat", createdAt: "", updatedAt: "", imageUrl: "", imagePath: "", imageDisk: "", type: "", userId: "1", isFavourite: true)
        ]
    
    
}
