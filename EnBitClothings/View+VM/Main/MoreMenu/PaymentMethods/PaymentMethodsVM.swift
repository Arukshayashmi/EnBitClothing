//
//  PaymentMethodsVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation
import SwiftUI

class PaymentMethodsVM:BaseVM{
    @Published var savedCardNumbers:[String] = []
    
    var defaultCardNumber:String = ""
    
    @Published var cardNumber:String = ""
    @Published var expirationDate:String = ""
    @Published var cvv:String = ""
    
    @Published var card: Card?
    
    func checkTextFields() ->Bool{
        if cardNumber.isEmpty{
            self.alertTitle = .Error
            self.alertMessage = "Enter Card Number"
            isShowAlert = true
            return true
        } else if expirationDate.isEmpty{
            self.alertTitle = .Error
            self.alertMessage = "Enter Expiration Date"
            isShowAlert = true
            return true
        }else if cvv.isEmpty{
            self.alertTitle = .Error
            self.alertMessage = "Enter cvv"
            isShowAlert = true
            return true
        }
     return false
    }
}
