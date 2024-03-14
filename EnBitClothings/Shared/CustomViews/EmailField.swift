//
//  EmailField.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import Foundation
import SwiftUI

struct EmailField:View {
    @Binding var text:String
    var body: some View{
        CommonTextField(text: $text, sectionHeader: "Email", placeholder: "me@example .com")
            .validateCheck(with: text, validation: Validators().isValidEmailValidator)
        
    }
}

