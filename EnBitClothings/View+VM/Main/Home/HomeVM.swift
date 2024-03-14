//
//  HomeVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation

class HomeVM:BaseVM {
    @Published var searchText:String = ""
    @Published var isActiveDetailsView:Bool = false
    @Published var isActiveFilterView:Bool = false
    
    
    @Published var minPrice:String = ""
    @Published var maxPrice:String = ""
    
    @Published var ItemCategories:[Categories] = []
    @Published var selectedItemCategory : Categories? = nil
    
    @Published var ItemCards : [Item] = []
    @Published var selectedItemCard : Item? = nil
    
    @Published var addFavoriteItems : Item?
    
    @Published var paginator : Paginator? = nil
}

extension HomeVM {
    func performCategoryData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.ItemCategories = Dummy.category
            self.ItemCards = Dummy.ItemData

        }
    }
}

//MARK: - GET ITEM CARDS FUNCATION
extension HomeVM {
    
    func processWithItemCards(minPrice: String, maxPrice: String, categoryId: String, q: String, page: Int, perPage: Int, isPaging: Bool = false, completion: @escaping (_ status: Bool) -> ()) {
        //
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
        // Clean array before API call and load data
        if isPaging == false {
            ItemCards.removeAll()
        }
        
//        GiftsAPI.giftsGetGiftsListHome(accept: ASP.shared.accept, q: searchText, page: page, perPage: 10, categoryId: categoryId, minPrice: minPrice, maxPrice: maxPrice) { data, error in
//            print(categoryId)
//            print(q)
//            
//            print(data)
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
//                guard let giftCardsResponse : [Item] = data?.payload else {
//                    self.alertTitle = .Error
//                    self.alertMessage = .MissingData
//                    self.isShowAlert = true
//                    return
//                }
//                self.paginator = data?.paginator
//                
//                if isPaging {
//                    self.ItemCards += giftCardsResponse
//                } else {
//                    self.ItemCards = giftCardsResponse
//                }
//                
//                
//                completion(true)
//            }
//        }
    }
    
}


//MARK: - ADD OR REMOVE FAVORITES FUNCATION
extension HomeVM {
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


//MARK: - GET CATEGORIES FUNCATION
extension HomeVM {
    
    func processWithItemCategories(completion: @escaping (_ status: Bool) -> ()) {
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
        // Clean array before API call and load data
        ItemCategories.removeAll()
        
//        CategoryAPI.categoryGetListAllCategory(accept: ASP.shared.accept) { response, error in
//            print(response)
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
//                guard (response?.payload) != nil else {
//                    self.alertTitle = .Error
//                    self.alertMessage = .MissingData
//                    self.isShowAlert = true
//                    return
//                }
//                
//                self.giftCategories = response?.payload ?? []
//                completion(true)
//            }
//        }
    }
    
}

