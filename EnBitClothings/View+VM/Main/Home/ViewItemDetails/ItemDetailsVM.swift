//
//  ItemDetailsVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation
import SwiftUI
import Alamofire

class ItemDetailsVM:BaseVM{
    @Published var currentPage = 0
    @Published var imageNames:[String] = ["GiftPlaceHolder","GiftPlaceHolder","GiftPlaceHolder","GiftPlaceHolder"]
    @Published var isActiveGenerateItemCardView:Bool = false
    @Published var clothItem:Product?
    @Published var addFavoriteGifts : Product?
    
    init(clothItem: Product?) {
        self.clothItem = clothItem
    }
}


//MARK: - ADD TO CART FUNCATION
extension ItemDetailsVM {
    func processWithAddToCartItems(itemId: String, completion: @escaping CompletionHandler) {
        // check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline. ")
            return
        }
        
        // Prepare the endpoint
        let endpoint = "/checkout/checkout-product"
        
        let parameters: [String: Any] = [
            "productId": itemId
        ]
        
        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .post, parameters: parameters, success: { (response: ProductResponse) in
            
            self.isShowAlert = true
            self.alertTitle = "Success"
            self.alertMessage = "Item Add to Cart Successfully"
            
            completion(true, "Success Product Add to Cart")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}

//MARK: - ADD OR REMOVE FAVORITES FUNCATION
extension ItemDetailsVM {
    func processWithFavoriteItems(itemId: String, favStatus: Int, completion: @escaping CompletionHandler) {
        // check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline. ")
            return
        }
        
        // Prepare the endpoint
        let endpoint = "/product/\(itemId)/like"
        
        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .put, encoding: URLEncoding.default, success: { (response: ProductResponse) in
            
            completion(true, "Sucess Product Data Getting..")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}
