//
//  ItemDetailsVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation
import SwiftUI

class ItemDetailsVM:BaseVM{
    @Published var currentPage = 0
    @Published var imageNames:[String] = ["GiftPlaceHolder","GiftPlaceHolder","GiftPlaceHolder","GiftPlaceHolder"]
    @Published var isActiveGenerateItemCardView:Bool = false
    @Published var clothItem:Item?
    @Published var addFavoriteGifts : Item?
    
    init(clothItem: Item?) {
        self.clothItem = clothItem
    }
}


//MARK: - ADD OR REMOVE FAVORITES FUNCATION
extension ItemDetailsVM {
    func processWithFavoriteItems(itemId: Int, favStatus: Int, completion: @escaping (_ status: Bool) -> ()) {
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
//        GiftsAPI.giftsPostAddToFavouriteGifts(giftId: giftId, status: favStatus, accept: ASP.shared.accept) { data, error in
//            
//            if error != nil{
//                self.handleErrorResponse(error) { (status, statusCode, message) in
//                    self.isShowAlert = true
//                    self.alertTitle = .Error
//                    self.alertMessage = message
//                    print("❤️❤️ \(message) ❤️❤️")
//                    completion(false)
//                }
//            } else {
//                guard let giftResponse = data?.payload else {
//                    self.alertTitle = .Error
//                    self.alertMessage = .MissingData
//                    self.isShowAlert = true
//                    return
//                }
//                self.addFavoriteItems = giftResponse
//                completion(true)
//            }
//        }
    }
        
}
