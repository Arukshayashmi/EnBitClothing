//
//
// DropDownField.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-20.
//

import SwiftUI

struct CategoriesDropDownField: View {
    
    @Binding var selectedCategoryId: String
    var sectionHeader: String
    var placeholderText: String
    
    @Binding var values: [Categories]
    
    @State private var selectedCategoryName: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(sectionHeader)
                .font(.custom("Roboto-Regular", size: 14))
                .foregroundColor(Color.white)
                .padding(.bottom, 6)
            
            HStack {
                Text(selectedCategoryName.isEmpty ? placeholderText : selectedCategoryName)
                    .font(.custom("Roboto-Regular", size: 14))
                    .foregroundColor(selectedCategoryName.isEmpty ? Color.white.opacity(0.5) : Color.white)
                
                Spacer()
                
                Menu {
                    ForEach(values, id: \.id) { category in
                        Button(action: {
                            self.selectedCategoryId = category.id ?? ""
                            self.selectedCategoryName = category.category ?? ""
                        }) {
                            Text(category.category ?? "Unknown")
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
        .onAppear {
            if let selectedCategory = values.first(where: { $0.id == selectedCategoryId }) {
                selectedCategoryName = selectedCategory.category ?? ""
            }
        }
    }
}
