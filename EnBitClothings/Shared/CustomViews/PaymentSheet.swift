//
//  PaymentSheet.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI

struct PaymentSheet: View {
    @Binding var cardNumber:String
    @Binding var expirationDate:String
    @Binding var cvv:String
    @State var sheetHeight:CGFloat
    var actionClose: ()->()?
    var actionAdd: ()->()?
    
    @FocusState var keyboardActive:Bool
    
    var body: some View {
        VStack(spacing: 16){
            HStack {
                Text("Add Card Details")
                    .font(.customFont(.RobotoMedium, 14))
                Spacer()
                Button {
                    actionClose()
                } label: {
                    Image(systemName: "xmark")
                }
            } // : HStack
            .foregroundColor(Color.custom(._FFFFFF))
            .padding(.horizontal, 16)
            .padding(.top, 26)
            

            CardDetailField(cardNumber: $cardNumber, expirationDate: $expirationDate, cvv: $cvv)
            .padding(.horizontal, 16)
            .padding(.top, 16)

            CommenButton(buttonTitle: "Add", buttonWidth: 180, isFilled: true) {
                actionAdd()
            }
            .padding(.top, 32)
            Spacer()
        } // : VStack
        
        .foregroundColor(Color.custom(._FFFFFF))
        .background(Color.custom(._1B1A2B)
            .ignoresSafeArea())
        .frame(height:sheetHeight)
    }

}

