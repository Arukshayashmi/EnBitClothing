//
//  CartVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation
import SwiftUI

class CartVM:BaseVM{
    @Published var cardNumber:String = ""
    @Published var expirationDate:String = ""
    @Published var cvv:String = ""

    @Published var showCreditCardSheet:Bool = false
    @Published var isPaymentViewActive:Bool = false
    
    @Published var cartItems : [Item] = []
    @Published var selectedCartItem:Item?

    @Published var cartItemCount = 0
    
    
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
extension CartVM {
    func performCartData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.cartItems = Dummy.ItemData
        }
    }
}
