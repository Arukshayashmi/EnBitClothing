//
//  CommonTextField.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import Foundation
import SwiftUI

struct CommonTextField:View {
    
    @Binding var text: String
    var sectionHeader: String
    var placeholder: String
    
    var body: some View{
        VStack(alignment: .leading, spacing: 0) {
            Text(sectionHeader)
                .font(.custom("Roboto-Regular", size: 14))
                .foregroundColor(Color.custom(._FFFFFF))
                .padding(.bottom, 6)
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text(placeholder)
                        .font(.custom("Roboto-Regular", size: 14))
                        .foregroundColor(Color.custom(._FFFFFF).opacity(0.5))
                }
                .padding()
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .frame(height: 48)
                .foregroundColor(Color.custom(._FFFFFF))
                .background(Color.custom(._FFFFFF).opacity(0.13))
                .cornerRadius(10)
        }
        
    }
}
