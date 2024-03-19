//
//  HomeVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation
import SwiftUI
import Alamofire

class HomeVM:BaseVM {
    @Published var searchText:String = ""
    @Published var isActiveDetailsView:Bool = false
    
    @Published var ItemCategories:[Categories] = []
    @Published var selectedItemCategory : Categories? = nil
    
    @Published var ItemCards : [Product] = []
    @Published var selectedItemCard : Product? = nil
    
    @Published var addFavoriteItems : Product?
}

//MARK: - GET CATEGORIES FUNCATION
extension HomeVM {
    func processWithCategories(completion: @escaping CompletionHandler) {
        // check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline. ")
            return
        }
        
        // Prepare the endpoint
        let endpoint = "/category/get-all"
        
        
        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .get, encoding: URLEncoding.default, success: { (response: CategoryResponse) in
            guard let productModel = response.categories else {
                completion(false, "Product Model Missing..")
                return
            }
            
            self.ItemCategories = productModel
            
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

//MARK: - GET ITEM CARDS FUNCATION
extension HomeVM {
    func processWithItemCards(categoryId: String, q: String, completion: @escaping CompletionHandler) {
        // check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline. ")
            return
        }

        // Prepare the endpoint
        let endpoint = "/product/get-all?q=\(q)&categoryId=\(categoryId)"
        
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


//MARK: - FAVORITE FUNCATION
extension HomeVM {
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
