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
