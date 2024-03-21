//
//  ColorExtension.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import SwiftUI

extension Color {
    static func custom(_ name: TxtaPrezColors) -> Color {
        return Color(name.rawValue)
    }
}

enum TxtaPrezColors: String {
    case _1B1A2B = "#1B1A2B"
    case _6347F3 = "#6347F3"
    case _FFFFFF = "#FFFFFF"
    case _F34770 = "#F34770"
    case _272643 = "#272643"
    case _E2E2E2 = "#E2E2E2"
    case _E9E9E9 = "#E9E9E9"
    case _B4B4B4 = "#B4B4B4"
    case _1B1B24 = "#1B1B24"
    case _F9F9F9 = "#F9F9F9"
    case _00000040 = "#000000.40"
    case _333333 = "#333333"
    case _767676 = "#767676"
    case _A5A5A5 = "#A5A5A5"
    case _F6DB34 = "#F6DB34"
    case _7EF347 = "#7EF347"
    
}
