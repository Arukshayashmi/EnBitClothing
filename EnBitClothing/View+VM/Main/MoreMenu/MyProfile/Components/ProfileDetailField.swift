//
//  ProfileDetailField.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//



import SwiftUI

struct ProfileDetailField: View {
    
    var title:String
    var detail:String
    
    var body: some View {
        HStack{
            Text(title)
                .padding(.leading, 16)
            Spacer()
            Text(detail)
                .foregroundColor(Color.custom(._FFFFFF).opacity(0.40))
                .disabled(true)
                .padding(.trailing, 16)
            
        } //: HStack
        .padding(.vertical, 12)
        .font(.customFont(.RobotoRegular, 14))
        .frame(height: 48)
        .background(Color.custom(._FFFFFF).opacity(0.13))
        .cornerRadius(14)
    }
}

