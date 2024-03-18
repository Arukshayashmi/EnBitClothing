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
import Alamofire

class CompleteProfileVM:BaseVM {
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
    func performUpdateProfileImage(completion: @escaping CompletionHandler) {
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline.")
            return
        }
        
        guard let selectedImage else {
            completion(false, "No image selected.")
            return
        }
        
        let endpoint = "/user/photo-update"
        
        AFWrapper.shared.uploadImage(endpoint, image: selectedImage, imageName: "file", progressCompletion: { progress in
            print("Upload progress: \(progress)")
        }, success: { (response: UserResponse) in
            guard let userModel = response.user else {
                completion(false, "User Model Missing.")
                return
            }
            
            //MARK: - LOCAL USER SAVE
            PersistenceController.shared.updateUserData(with: userModel)
            
            iBSUserDefaults.localUser = userModel
            
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

extension CompleteProfileVM {
    func proceedCompleteProfileAPI(completion : @escaping CompletionHandler) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline.")
            return
        }
        
        // Prepare the endpoint
        let endpoint = "/user/profile-complete"
        
        // Prepare the data to be sent in the request body
        let parameters: [String: Any] = [
            "first_name": firstName,
            "last_name": lastName,
            "phone": contactNumber,
            "dob": selectedDateString,
            "adress": address,
            "city": city,
            "post_code": postCode
        ]
        
        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .post, parameters: parameters, success: { (response: UserResponse) in
            guard let userModel = response.user else {
                completion(false, "User Model Missing.")
                return
            }
            
            //MARK: - LOCAL USER SAVE
            PersistenceController.shared.updateUserData(with: userModel)
            
            iBSUserDefaults.localUser = userModel
            
            completion(true, "Complete Profile Success.")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}
