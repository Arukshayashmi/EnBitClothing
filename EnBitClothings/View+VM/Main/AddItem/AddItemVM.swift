//
//  AddItemVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-20.
//

import Foundation
import UIKit
import SwiftUI
import PhoneNumberKit
import Alamofire

class AddItemVM:BaseVM {
    @Published var selectedImage: UIImage? = nil
    @Published var name:String = ""
    @Published var categoryId:String = ""
    @Published var price:String = ""
    @Published var dscription:String = ""
    
    @Published var ItemCategories:[Categories] = []
    
    @Published var imageId: String = ""
    @Published var imageUrl: String = ""
}

extension AddItemVM {
    //MARK: - COMPLETE PROFILE VALIDATIONS
    func addItemValidation() -> Bool {
        if name.isEmpty {
            alertTitle = .Error
            alertMessage = "Please Enter Item Name"
            isShowAlert = true
            return false
            
        } else if categoryId.isEmpty {
            alertTitle = .Error
            alertMessage = "Please Enter Item Category"
            isShowAlert = true
            return false
            
        } else if price.isEmpty{
            alertTitle = .Error
            alertMessage = "Please Enter Item Price"
            isShowAlert = true
            return false
            
        } else if dscription.isEmpty{
            alertTitle = .Error
            alertMessage = "Please Enter Discription"
            isShowAlert = true
            return false
            
        }
        return true
    }

}

//MARK: - GET CATEGORIES FUNCATION
extension AddItemVM {
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

extension AddItemVM {
    func performUploadItemImage(completion: @escaping CompletionHandler) {
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline.")
            return
        }
        
        guard let selectedImage else {
            completion(false, "No image selected.")
            return
        }
        
        let endpoint = "/product/upload-picture"
        
        AFWrapper.shared.uploadImage(endpoint, image: selectedImage, imageName: "file", progressCompletion: { progress in
            print("Upload progress: \(progress)")
        }, success: { (response: ImageResponse) in
            
            self.imageId = response.publicId ?? ""
            self.imageUrl = response.imageUrl ?? ""
            
            completion(true, "Image uploaded successfully.")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, "Failed uploading image: \(error.localizedDescription)")
            }
        })
    }
}


//MARK: - COMPLETE PROFILE FUNCATION

extension AddItemVM {
    func proceedAddItemAPI(completion : @escaping CompletionHandler) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline.")
            return
        }
        
        // Prepare the endpoint
        let endpoint = "/product/add-details"
        
        // Prepare the data to be sent in the request body
        let parameters: [String: Any] = [
            "name": name,
            "description": dscription,
            "price": price,
            "category": categoryId,
            "publicId": imageId,
            "imageUrl": imageUrl
        ]
        
        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .post, parameters: parameters, success: { (response: ProductResponse) in
            
            self.alertTitle = "Alert"
            self.alertMessage = "Item Added Success!"
            self.isShowAlert = true
            
            completion(true, "Add Item Success.")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}

