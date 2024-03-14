//
//  FavouritesVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation

class FavouritesVM:BaseVM {
    @Published var isActiveDetailsView:Bool = false
    @Published var ItemCards : [Item] = []
    @Published var selectedItemCard : Item? = nil
    
    @Published var addFavoriteItems : Item?
    
    @Published var paginator : Paginator? = nil
}

//MARK: - GET ALL FAVOURITE ITEMS FUNCATION
extension FavouritesVM {
    func processWithAllFavoriteItem(page: Int, perPage: Int, isPaging: Bool = false, completion: @escaping (_ status: Bool) -> ()) {
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
        self.ItemCards.removeAll()
        
//        GiftsAPI.giftsGetGetFavouriteGifts(accept: ASP.shared.accept, perPage: 10) { data, error in
//            
//            if error != nil{
//                self.handleErrorResponse(error) { (status, statusCode, message) in
//                    self.isShowAlert = true
//                    self.alertTitle = .Error
//                    self.alertMessage = message
//                    print("❤️❤️ \(message) ❤️❤️")
//                    completion(false)
//                }
//                
//            } else {
//                guard let giftCardsResponse : [Gift] = data?.payload else {
//                    self.alertTitle = .Error
//                    self.alertMessage = .MissingData
//                    self.isShowAlert = true
//                    return
//                }
//                self.paginator = data?.paginator
//                
//                if isPaging {
//                    self.giftCards += giftCardsResponse
//                } else {
//                    self.giftCards = giftCardsResponse
//                }
//                completion(true)
//            }
//        }
    }
    
}


//MARK: - ADD OR REMOVE FAVORITES FUNCATION
extension FavouritesVM {
    func performProfileListData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.ItemCards = Dummy.ItemData
        }
    }
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
