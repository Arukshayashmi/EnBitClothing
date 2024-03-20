//
//  CartVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation
import SwiftUI
import Alamofire

class CartVM:BaseVM{
    var defaultCardNumber:String = ""
    
    @Published var cardNumber:String = ""
    @Published var expirationDate:String = ""
    @Published var cvv:String = ""

    @Published var showCreditCardSheet:Bool = false
    @Published var isPaymentViewActive:Bool = false
    
    @Published var cartItems : [CheckoutProduct] = []
    @Published var selectedCartItem:CheckoutProduct?

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

//MARK: - GET CATEGORIES FUNCATION
extension CartVM {
    func processWithCart(completion: @escaping CompletionHandler) {
        // check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline. ")
            return
        }
        
        // Prepare the endpoint
        let endpoint = "/checkout/getall"
        
        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .get, encoding: URLEncoding.default, success: { (response: CartResponse) in
            guard let cartModel = response.checkoutProducts else {
                completion(false, "Product Model Missing..")
                return
            }
            
            self.cartItems = cartModel
            
            completion(true, "Sucess Categories Getting..")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}
