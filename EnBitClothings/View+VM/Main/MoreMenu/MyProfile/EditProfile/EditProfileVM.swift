//
//  EditProfileVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//



import Foundation
import PhoneNumberKit
import Alamofire

class EditProfileVM:BaseVM{
        @Published var firstName:String = ""
        @Published var lastName:String = ""
        @Published var dob:Date = Date()
        @Published var dobValue:String = ""
        @Published var address:String = ""
        @Published var city:String = ""
        @Published var postCode:String = ""
     
        @Published var countryCode:String = ""
        @Published var phoneNumber:String = ""
        @Published var contactNumber:String = ""
        @Published var showCountryPicker:Bool = false
        let phoneNumberKit = PhoneNumberKit()
        
        @Published var user : User?

    
    var selectedDateString: String {
        dob.convertDateToString("yyyy-MM-dd")
    }
    
}

extension EditProfileVM{
    func editProfileValidation() -> Bool {
        if firstName.isEmpty {
            alertTitle = .Error
            alertMessage = "Please Enter First Name"
            isShowAlert = true
            return true
        
        } else if lastName.isEmpty {
            alertTitle = .Error
            alertMessage = "Please Enter Last Name"
            isShowAlert = true
            return true
        } else if phoneNumber.isEmpty{
            alertTitle = .Error
            alertMessage = "Please Enter Contact Number"
            isShowAlert = true
            return true
        }else if address.isEmpty{
            alertTitle = .Error
            alertMessage = "Enter bio"
            isShowAlert = true
            return true
        }
        return false
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


// MARK: - EDIT PROFILE DETAILS FUNCTION

extension EditProfileVM{
    func editProfileDetails(completion: @escaping CompletionHandler) {
        // check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline. ")
            return
        }

        // Prepare the endpoint
        let endpoint = "/user/profile-update"
        
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
        AFWrapper.shared.request(endpoint, method: .put, parameters: parameters, success: { (response: UserResponse) in
            guard let userModel = response.user else {
                completion(false, "User Model Missing..")
                return
            }
            //MARK: - LOCAL USER SAVE
            PersistenceController.shared.updateUserData(with: userModel)
            
            iBSUserDefaults.localUser = userModel

            completion(true, "Sucess Data updating..")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}


// MARK: - LOAD USER DATA FUNCTION

extension EditProfileVM{
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
            self.firstName = userModel.firstName ?? ""
            self.lastName = userModel.lastName ?? ""
            self.dob = self.convertStringToDate(userModel.dob ?? "", format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXX") ?? Date()
            self.address = userModel.adress ?? ""
            self.city = userModel.city ?? ""
            self.postCode = userModel.postCode ?? ""
            self.extractCountryCode(from: userModel.phone ?? "")

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

extension EditProfileVM{
    //MARK: - EXTRACT COUNTRY CODE FUNCTION
    func extractCountryCode(from contactNumber: String) {
        
        do {
            let contactNumber = try phoneNumberKit.parse(contactNumber)
            print(contactNumber.countryCode)
            print( contactNumber.nationalNumber)
            countryCode = "+\(contactNumber.countryCode)"
            phoneNumber = "\(contactNumber.nationalNumber)"
        }
        catch {
            self.isShowAlert = true
            self.showInfoLogger(message: "Generic parser error")
            self.alertMessage = "Generic parser error"
            self.alertTitle = .Error
        }
    }
}
