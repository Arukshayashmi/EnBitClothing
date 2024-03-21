//
//  SavedCardView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI

struct SavedCardView: View {
    var creditCardNumber:String
    var body: some View {
        HStack(spacing: 8){
            Image(detectCardType())
                .resizable()
                .scaledToFit()
                .frame(height: 20)
                .padding(.leading, 8)
                .padding(.vertical, 12)
            Text(creditCardNumber)
                .font(.customFont(.RobotoBold, 14))
                .padding(.vertical, 12)
                .padding(.trailing, 113)
        } // : HStack
        .background(Color.custom(._FFFFFF).opacity(0.13))
        .cornerRadius(10)
        .frame(width: UIScreen.screenWidth * 0.826)
    }
    private func detectCardType() -> String {
        let cleanedNumber = creditCardNumber.replacingOccurrences(of: " ", with: "")
            
            if cleanedNumber.hasPrefix("4") {
                return "Visa"
            } else if let firstDigit = cleanedNumber.first, let digit = Int(String(firstDigit)), digit >= 5 && digit <= 6 {
                return "MasterCard"
            } else if cleanedNumber.hasPrefix("34") || cleanedNumber.hasPrefix("37") {
                return "AmericanExpress"
            } else {
                return "Visa"
            }
        }
}

