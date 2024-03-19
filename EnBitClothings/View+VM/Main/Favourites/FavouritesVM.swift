//
//  FavouritesVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation
import Alamofire

class FavouritesVM:BaseVM {
    @Published var isActiveDetailsView:Bool = false
    @Published var ItemCards : [Product] = []
    @Published var selectedItemCard : Product? = nil
    @Published var addFavoriteItems : Product?
}

//MARK: - GET ALL FAVOURITE ITEMS FUNCATION
extension FavouritesVM {
    func processWithAllFavoriteItem(completion: @escaping CompletionHandler) {
                // check internet connection
                guard Reachability.isInternetAvailable() else {
                    completion(false, "Internet connection appears to be offline. ")
                    return
                }

                // Prepare the endpoint
                let endpoint = "/productlikes/get"
                
                self.ItemCards.removeAll()
                
                // Make the request with JSON encoding
                AFWrapper.shared.request(endpoint, method: .get, encoding: URLEncoding.default, success: { (response: ProductResponse) in
                    guard let productModel = response.products else {
                        completion(false, "Product Model Missing..")
                        return
                    }
                    
                    self.ItemCards = productModel

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


//MARK: - ADD OR REMOVE FAVORITES FUNCATION
extension FavouritesVM {
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
