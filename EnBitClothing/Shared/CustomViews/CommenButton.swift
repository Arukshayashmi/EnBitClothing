//
//  CommenButton.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation
import SwiftUI

struct CommenButton:View {
    let buttonTitle:String
    let buttonWidth:CGFloat
    var isFilled:Bool
    
    let action: ()->()?
    
    
    var body: some View{
        
        Button {
            action()
        } label: {
            Text(buttonTitle)
                .foregroundColor(Color.custom(._FFFFFF))
                .font(.custom("Roboto-Medium", size: 14))
                .frame(width: buttonWidth ,height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.custom(._6347F3), lineWidth: 1)
                        .background(isFilled ? Color.custom(._6347F3) : Color.clear)
                )
                .cornerRadius(14)
                
        }.buttonStyle(.plain)

       
    }
}

