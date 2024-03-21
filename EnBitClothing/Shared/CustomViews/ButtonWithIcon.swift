//
//  ButtonWithIcon.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import Foundation
import SwiftUI

struct ButtonWithIcon:View{
    var buttonTitle:String
    var buttonImage:Image
    var buttonAction: ()->()?
    
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            HStack{
                Text(buttonTitle)
                Spacer()
                buttonImage
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(height: 48)
            .background(Color.custom(._FFFFFF).opacity(0.13))
            .cornerRadius(14)
        }
    }
    
}
