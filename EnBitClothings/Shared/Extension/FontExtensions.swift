//
//  FontExtensions.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import Foundation
import SwiftUI

extension Font {
    static func customFont(_ name: TxtaPrezFonts, _ size: CGFloat) -> Font {
        return Font.custom(name.rawValue, size: size)
    }
}

enum TxtaPrezFonts: String {
    
    case RobotoRegular = "Roboto-Regular"
    case RobotoMedium = "Roboto-Medium"
    case RobotoBold = "Roboto-Bold"
    case RobotoItalic = "Roboto-Italic"
    
}
