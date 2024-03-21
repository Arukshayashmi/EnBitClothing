//
//  CategoryButton.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI

struct CategoryButton: View {
    @State var categoryName : String
    @State var categoryId: String
    @Binding var selectedCategoryId: String
    let action: (() -> ())?
    
    var body: some View {
        ZStack{
            Button {
                action?()
                
            } label: {
                Text(categoryName)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 5)
                    .font(.customFont(.RobotoMedium, 14))
                    .foregroundColor(Color.custom(._FFFFFF))
                    .background(
                        RoundedRectangle(cornerRadius: 27)
                            .strokeBorder(Color.custom(._6347F3), lineWidth: 1)
                            .background(categoryId == selectedCategoryId ? Color.custom(._6347F3) : Color.custom(._FFFFFF).opacity(0.2))
                    )
                    .cornerRadius(27)
            }
        }//:ZStack
    }
}

