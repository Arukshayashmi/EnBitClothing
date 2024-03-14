//
//  CompleteProfileVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation
import UIKit
import SwiftUI
import PhoneNumberKit

class CompleteProfileVM:BaseVM {
    //:CompleteProfileView_1
    @Published var selectedImage: UIImage? = nil
    @Published var firstName:String = ""
    @Published var lastName:String = ""
    @Published var dob:Date = Date()
    @Published var address:String = ""
    @Published var city:String = ""
    @Published var postCode:String = ""
    @Published var countryCode:String = ""
    @Published var phoneNumber:String = ""
    @Published var contactNumber:String = ""
    @Published var showCountryPicker:Bool = false
    let phoneNumberKit = PhoneNumberKit()
    
    
    
    var selectedDateString: String {
        dob.convertDateToString("yyyy-MM-dd")
    }
    
    
    @Published var user : User?
    
    @Published var fieldOfState: [String] = ["New South Wales", "Queensland", "South Australia", "Tasmania", "Victoria", "Western Australia", "Australian Capital Territory", "Northern Territory"]
    
    @Published var isNavLicenseDetailsView:Bool = false

}
extension CompleteProfileVM {
    //MARK: - COMPLETE PROFILE VALIDATIONS
    func completeProfileValidation() -> Bool {
        if firstName.isEmpty {
            alertTitle = .Error
            alertMessage = "Please Enter First Name"
            isShowAlert = true
            return false
        
        } else if lastName.isEmpty {
            alertTitle = .Error
            alertMessage = "Please Enter Last Name"
            isShowAlert = true
            return false
            
        } else if phoneNumber.isEmpty{
            alertTitle = .Error
            alertMessage = "Please Enter Contact Number"
            isShowAlert = true
            return false
            
        }
        return true
    }
    

    //MARK: - PHONE NUMBER VALIDATIONS
    func checkPhoneNumber() -> Bool {
        
        contactNumber = countryCode + phoneNumber
        
        do {
            print("✅ phone is: \(self.contactNumber)")
            let validatedPhoneNumber = try self.phoneNumberKit.parse(self.contactNumber)
            print("✅✅ Validated Number: \(validatedPhoneNumber)")
        }
        catch {
            self.alertMessage = "Please enter valid mobile number"
            self.alertTitle = .Error
            self.isShowAlert = true
            
            return false
        }
        return true
    }
}


extension CompleteProfileVM {
    func performUpdateProfileImage(completion : @escaping (_ status: Bool) -> ()) {
        self.startLoading()
        
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
//            self.stopLoading()
//            
//            //MARK: - LOCAL USER SAVE
//            PersistenceController.shared.updateUserData(with: user)
//            
//            //MARK: Add access token to SwaggerAPIClient Custom headers
//            AppConstant.addAccessTokenToSwaggerAPIClientcustomHeaders()
//        }
    }
}

extension CompleteProfileVM {
    func performUploadImage() {
        self.startLoading()
        
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
//                self.alertMessage = "Failed Uploading Image!"
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
//            self.user = user
//            self.stopLoading()
//        }
    }
}

extension CompleteProfileVM {
    //MARK: - COMPLETE PROFILE 01 FUNCATION
    
    func proceedCompleteProfileAPI(completion : @escaping (_ status: Bool) -> ()){
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
//        ProfileAPI.profilePostUpdateProfileStep1(accept: ASP.shared.accept, firstName: firstName, lastName: lastName, phone: phoneNumber, countryCode: countryCode, dateOfBirth: selectedDateString, address: address, city: city, postCode: postCode, state: state)
//        
//        { data, error in
//            
//            if error != nil {
//                self.handleErrorAndShowAlert(error: error)
//                completion(false)
//                return
//            }
//            
//            guard let user = data?.payload else {
//                self.isShowAlert = true
//                self.alertMessage = data?.message ?? ""
//                completion(false)
//                return
//            }
//            
//            PersistenceController.shared.updateUserData(with: user)
//            
//            AppConstant.addAccessTokenToSwaggerAPIClientcustomHeaders()
//            print("contact no:- \(PersistenceController.shared.loadUserData()?.phone)")
//            
//            completion(true)
//        }
        
    }
}


