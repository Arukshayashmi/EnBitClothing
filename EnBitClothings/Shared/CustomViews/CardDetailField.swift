//
//  CardDetailField.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI

struct CardDetailField: View {
    @Binding var cardNumber:String
    @Binding var expirationDate:String
    @Binding var cvv:String
    @FocusState var keyboardActive:Bool
    var body: some View {
        HStack(spacing:0){
            Image(detectCardType())
                .resizable()
                .scaledToFit()
                .frame(height: 20)
                .padding(.trailing, 21)
            TextField("Card Number", text: $cardNumber)
            .placeholder(when: cardNumber.isEmpty) {
                    Text("1234 5674 3456 2345")
                        .font(.custom("Roboto-Regular", size: 14))
                        .foregroundColor(Color.custom(._FFFFFF).opacity(0.5))
                }
            
            .keyboardType(.numberPad)
            .focused($keyboardActive)
            .toolbar{
                ToolbarItemGroup(placement:.keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        keyboardActive = false
                    }
                }
            }
            .onChange(of: cardNumber) { newValue in
                       cardNumber = formatCreditCardNumber(newValue)
                if cardNumber.count > 19 {
                    cardNumber = String(cardNumber.prefix(19))
                                }
                
                   }
            .onAppear {
                cardNumber = formatCreditCardNumber(cardNumber)
            }
            .foregroundColor(Color.custom(._FFFFFF))
            .keyboardType(.numberPad)
            .frame(width: 137)

            TextField("MM/YY", text: $expirationDate)
                .placeholder(when: expirationDate.isEmpty) {
                    Text("MM/YY")
                        .font(.custom("Roboto-Regular", size: 14))
                        .foregroundColor(Color.custom(._FFFFFF).opacity(0.5))
                }
                .focused($keyboardActive)
                .frame(width: 55)
                .onChange(of: expirationDate) { newValue in
                           expirationDate = formatExpirationDate(newValue)
                    if expirationDate.count > 5 {
                        expirationDate = String(expirationDate.prefix(5))
                    }
                    
                }
                .onAppear {
                    expirationDate = formatExpirationDate(expirationDate)
                }
                .foregroundColor(Color.custom(._FFFFFF))
                .keyboardType(.numberPad)
                .padding(.leading, 21)
//
            TextField("CVV", text: $cvv)
                .placeholder(when: cvv.isEmpty) {
                    Text("CVV")
                        .font(.custom("Roboto-Regular", size: 14))
                        .foregroundColor(Color.custom(._FFFFFF).opacity(0.5))
                }
                .focused($keyboardActive)
                .onChange(of: cvv) { newValue in
                    if cvv.count > 3 {
                        cvv = String(cvv.prefix(3))
                    }
                    
                }
                .foregroundColor(Color.custom(._FFFFFF))
                .keyboardType(.numberPad)
                .padding(.leading, 24)
        } // : HStack
        .padding(.vertical, 12)
        .padding(.leading, 16)
        .padding(.trailing, 9)
        .background(Color.custom(._FFFFFF).opacity(0.13))
        .cornerRadius(10)
        .font(.customFont(.RobotoRegular, 14))
        //.frame(height: 100)
    }
    private func formatCreditCardNumber(_ number: String) -> String {
            let trimmedNumber = number.replacingOccurrences(of: " ", with: "")
            var formattedNumber = ""
            
            for (index, character) in trimmedNumber.enumerated() {
                if index > 0 && index % 4 == 0 {
                    formattedNumber += " "
                }
                formattedNumber.append(character)
            }
            
            return formattedNumber
        }
    private func formatExpirationDate(_ date: String) -> String {
            let trimmedDate = date.replacingOccurrences(of: "/", with: "")
            var formattedDate = ""
            
            for (index, character) in trimmedDate.enumerated() {
                if index > 0 && index % 2 == 0 {
                    formattedDate += "/"
                }
                formattedDate.append(character)
            }
            
            return formattedDate
        }
    private func detectCardType() -> String {
        let cleanedNumber = cardNumber.replacingOccurrences(of: " ", with: "")
            
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


