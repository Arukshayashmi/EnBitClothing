//
//  MyProfileVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//



import Foundation
import PhoneNumberKit
import UIKit

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
    func performUpdateProfileImage() {
//        self.startLoading()
        
        guard Reachability.isInternetAvailable() else {
            self.showNoInternetAlert()
            self.stopLoading()
            return
        }
        
        guard let selectedImage else {
            self.stopLoading()
            return
        }
        
        guard let selectedImageURL = getSavedURL(image: selectedImage, name: "") else {
            self.stopLoading()
            return
        }
        
//        ProfileAPI.profilePostUpdateMyAvatar(accept: ASP.shared.accept, image: selectedImageURL) { response, error in
//            
//            guard error == nil else {
//                self.alertMessage = "Failed Uploading Avatar Image!"
//                self.isShowAlert = true
//                self.stopLoading()
//                return
//            }
//            
//            self.isShowAlert = true
//            self.alertMessage = "Image uploaded successfully."
//            self.alertTitle = "Image Upload"
//            
//            guard let user = response?.payload else {
//                self.isShowAlert = true
//                self.alertMessage = response?.message ?? ""
//                self.stopLoading()
//                return
//            }
//            
//            self.user = user
//            self.loadProfileDetails { status in
//                // to get new updated profile image
//            }
//            self.stopLoading()
//            
//            
//            //MARK: - LOCAL USER SAVE
//            PersistenceController.shared.updateUserData(with: user)
//            
//            //MARK: Add access token to SwaggerAPIClient Custom headers
//            AppConstant.addAccessTokenToSwaggerAPIClientcustomHeaders()
//        }
    }
}


//MARK: - LOAD USER DATA FUNCTION
extension MyProfileVM{
    func loadProfileDetails(completion: @escaping (_ status: Bool) -> ()){
        
        //:Check internet connection
        if !Reachability.isInternetAvailable(){
            self.showNoInternetAlert()
            self.stopLoading()
            return
        }
        
        
//        ProfileAPI.profileGetMyProfile(accept: ASP.shared.accept){ response, error in
//           //print(response)
//            
//            if error != nil {
//                self.handleErrorAndShowAlert(error: error)
//                completion(false)
//            } else {
//                guard let user = response?.payload else {
//                    completion(false)
//                    return
//                }
//                self.setupUI(user: user)
//                
//                completion(true)
//            }
//        }
    }
    func setupUI(user:User) {
        
        self.email = user.email ?? ""
        self.firstName = user.firstName ?? ""
        self.lastName = user.lastName ?? ""
        self.imageUrl = user.profilePic?.url ?? ""
        self.dob = user.dob ?? ""
        self.address = user.adress ?? ""
        self.city = user.city ?? ""
        self.postCode = user.postCode ?? ""
        self.phoneNumber = user.phone ?? ""
       
        
    }
    
    func EditProfileDetails(completion: @escaping (_ status: Bool) -> ()){
        
        //:Check internet connection
        if !Reachability.isInternetAvailable(){
            self.showNoInternetAlert()
            self.stopLoading()
            return
        }
        
        
//        ProfileAPI.profilePostUpdateProfileStep1(accept: ASP.shared.accept, firstName: firstName, lastName: lastName, phone: phoneNumber, countryCode: countryCode, dateOfBirth: dob, address: address, city: city, postCode: postCode, state: state){ response, error in
//           //print(response)
//            
//            if error != nil {
//                self.handleErrorAndShowAlert(error: error)
//                completion(false)
//            } else {
//                guard let user = response?.payload else {
//                    completion(false)
//                    return
//                }
//                self.setupUI(user: user)
//                
//                completion(true)
//            }
//        }
    }
}


//extension MyProfileVM{
//    //MARK: - EXTRACT COUNTRY CODE FUNCTION
//    func extractCountryCode(from contactNumber: String) {
//        
//        do {
//            let contactNumber = try phoneNumberKit.parse(contactNumber)
//            print(contactNumber.countryCode)
//            print( contactNumber.nationalNumber)
//            countryCode = "+\(contactNumber.countryCode)"
//            phoneNumber = "\(contactNumber.nationalNumber)"
//        }
//        catch {
//            self.isShowAlert = true
//            self.showInfoLogger(message: "Generic parser error")
//            self.alertMessage = "Generic parser error"
//            self.alertTitle = .Error
//        }
//    }
//}
