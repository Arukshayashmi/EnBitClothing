//
//  MyProfileVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//



import Foundation
import PhoneNumberKit
import UIKit
import Alamofire

class MyProfileVM:BaseVM{
    @Published var selectedImage:UIImage? = nil
    @Published var imageUrl:String = ""
    
    @Published var email:String = ""
    @Published var firstName:String = ""
    @Published var lastName:String = ""
    @Published var dob:String = ""
    @Published var address:String = ""
    @Published var city:String = ""
    @Published var postCode:String = ""
    
    @Published var countryCode:String = ""
    @Published var phoneNumber:String = ""
    @Published var contactNumber:String = ""
    
    @Published var editProfileViewAction:Bool = false
    @Published var changePasswordViewAction:Bool = false
    
    @Published var user : User?
    let phoneNumberKit = PhoneNumberKit()
}


//MARK: - USER PROFILE UPDATE FUNCTION
extension MyProfileVM{
    func performUpdateProfileImage(completion: @escaping CompletionHandler) {
        self.startLoading()
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline.")
            self.stopLoading()
            return
        }
        
        guard let selectedImage else {
            completion(false, "No image selected.")
            self.stopLoading()
            return
        }
        
        let endpoint = "/user/photo-update"
        
        AFWrapper.shared.uploadImage(endpoint, image: selectedImage, imageName: "file", progressCompletion: { progress in
            print("Upload progress: \(progress)")
        }, success: { (response: UserResponse) in
            guard let userModel = response.user else {
                self.isShowAlert = true
                self.alertMessage = response.message ?? ""
                completion(false, "User Model Missing.")
                self.stopLoading()
                return
            }
            self.isShowAlert = true
            self.alertMessage = "Image uploaded successfully."
            self.alertTitle = "Image Upload"
            
            //MARK: - LOCAL USER SAVE
            PersistenceController.shared.updateUserData(with: userModel)
            
            iBSUserDefaults.localUser = userModel
            
            completion(true, "Image uploaded successfully.")
            self.stopLoading()
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                self.alertMessage = "Failed Uploading Avatar Image!"
                self.isShowAlert = true
                completion(false, afError.errorMessage)
                self.stopLoading()
            } else {
                completion(false, "Failed uploading image: \(error.localizedDescription)")
                self.stopLoading()
            }
        })
    }
}


// MARK: - LOAD USER DATA FUNCTION
extension MyProfileVM{
    func loadProfileDetails(completion: @escaping CompletionHandler) {
        // check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline. ")
            return
        }

        // Prepare the endpoint
        let endpoint = "/user/profile"
        
        let id = iBSUserDefaults.localUser?.id ?? String()
        
        // Prepare the data to be sent in the request body
        let parameters: [String: Any] = [
            "_id": id
        ]
        
        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .get, parameters: parameters, encoding: URLEncoding.default, success: { (response: UserResponse) in
            guard let userModel = response.user else {
                completion(false, "User Model Missing..")
                return
            }
            self.email = userModel.email ?? ""
            self.firstName = userModel.firstName ?? ""
            self.lastName = userModel.lastName ?? ""
            self.imageUrl = userModel.profilePic?.url ?? ""
            self.dob = self.extractDate(from: userModel.dob ?? "")
            self.address = userModel.adress ?? ""
            self.city = userModel.city ?? ""
            self.postCode = userModel.postCode ?? ""
            self.phoneNumber = userModel.phone ?? ""

            completion(true, "Sucess Data getting..")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}
