//
//  SearchBar.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation
import SwiftUI

struct SearchBar:View {
    @Binding var searchText:String
    var placeholder:String = "Start typing here"
    var clearAction: (() -> ())
    
    var body: some View{
        HStack{
            TextField("", text: $searchText)
                .placeholder(when: searchText.isEmpty) {
                    Text(placeholder)
                        .font(.customFont(.RobotoRegular, 16))
                }
                .autocorrectionDisabled(true)
            
            Spacer()
            Image(systemName:searchText.isEmpty ? "magnifyingglass" :"xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 18)
                
                .onTapGesture {
                    if !searchText.isEmpty{
                        searchText = ""
                        clearAction()
                    }
                }
        } //: HStack
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .foregroundStyle(Color.custom(._FFFFFF))
        .frame(height: 48)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.custom(._FFFFFF).opacity(0.29), lineWidth: 1)
                .background(Color.custom(._FFFFFF).opacity(0.22))
        )
        .cornerRadius(12)
        
    }
}

