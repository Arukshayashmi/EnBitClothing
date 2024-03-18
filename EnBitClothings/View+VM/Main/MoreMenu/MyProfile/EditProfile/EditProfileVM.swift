//
//  EditProfileVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//



import Foundation
import PhoneNumberKit

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
    
//    //MARK: - PHONE NUMBER VALIDATIONS
//    func checkPhoneNumber() -> Bool {
//        
//        contactNumber = countryCode + phoneNumber
//        
//        do {
//            print("✅ phone is: \(self.contactNumber)")
//            let validatedPhoneNumber = try self.phoneNumberKit.parse(self.contactNumber)
//            print("✅✅ Validated Number: \(validatedPhoneNumber)")
//        }
//        catch {
//            self.alertMessage = "Please enter valid mobile number"
//            self.alertTitle = .Error
//            self.isShowAlert = true
//            
//            return false
//        }
//        return true
//    }
}


//MARK: - LOAD USER DATA FUNCTION
extension EditProfileVM{
    func loadProfileDetails(completion: @escaping (_ status: Bool) -> ()){
        
        //:Check internet connection
        if !Reachability.isInternetAvailable(){
            self.showNoInternetAlert()
            self.stopLoading()
            return
        }
        
//        ProfileAPI.profilePostUpdateProfileStep1(accept: ASP.shared.accept, firstName: firstName, lastName: lastName, phone: phoneNumber, countryCode: countryCode, dateOfBirth: selectedDateString, address: address, city: city, postCode: postCode, state: state){ response, error in
//            //print(response)
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
//                PersistenceController.shared.updateUserData(with: user)
//                completion(true)
//            }
//        }
    }
    func setupUI(user:User) {
        
        self.firstName = user.firstName ?? ""
        self.lastName = user.lastName ?? ""
        self.dobValue = user.dob ?? ""
        self.address = user.adress ?? ""
        self.city = user.city ?? ""
        self.postCode = user.postCode ?? ""
        self.phoneNumber = user.phone ?? ""
        
    }
}

