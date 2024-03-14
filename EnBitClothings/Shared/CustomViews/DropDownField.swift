//
//
// DropDownField.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//



import SwiftUI

struct DropDownField: View {
    
    
    @Binding var text: String
    var sectionHeader: String
    var placeholderText: String
    @Binding var values: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(sectionHeader)
                .font(.custom("Roboto-Regular", size: 14))
                .foregroundColor(Color.custom(._FFFFFF))
                .padding(.bottom, 6)
            
            HStack {
                TextField("", text: $text)
                    .disabled(true)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholderText)
                            .font(.custom("Roboto-Regular", size: 14))
                            .foregroundColor(Color.custom(._FFFFFF).opacity(0.5))
                    }
                
                Menu {
                    Picker("",selection: $text) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                } label: {
                    Image("icon.arrow.dropdown")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.custom(._FFFFFF))
                        .frame(width: 24, height: 24, alignment: .trailing)
                }
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

