//
//  SignUpVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation
import SwiftUI
import Alamofire

class SignUpVM:BaseVM {
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var showPassword:Bool = false
    @Published var isEmailAlreadyExists:Bool = false
    @Published var signInAction:Bool = false
    @Published var verifyAccountAction:Bool = false
    var emailExists:String = "me@gmail.com"
        
    
}
extension SignUpVM {
    func signUpCheck() -> Bool{
        if email.isEmpty{
            self.alertMessage = "Please enter email address"
            self.alertTitle = "Valid Email Required"
            self.isShowAlert = true
            
            return false
        } else if password.isEmpty {
            self.alertMessage = "Please enter Password"
            self.alertTitle = "Valid Password Required"
            self.isShowAlert = true
            
            return false
        } else if !Validators().isValidPasswordValidator(value: password).isSuccess {
            self.alertMessage = "Password should contain minimum of 8 characters"
            self.alertTitle = .Error
            self.isShowAlert = true
            
            return false
        } else if !Validators().isValidEmailValidator(value: email).isSuccess {
            
            self.alertMessage = "Please enter a valid email address"
            self.alertTitle = "Valid Email Required"
            self.isShowAlert = true
            
            return false
        }
        return true
    }
}


extension SignUpVM {
    func proceedWithSignUp(email: String, password: String, completion: @escaping CompletionHandler) {
        // check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline. ")
            return
        }

        // Prepare the endpoint
        let endpoint = "/user/register"

        // Prepare the data to be sent in the request body
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]

        AFWrapper.shared.request(endpoint, method: .post, parameters: parameters, success: { (response: UserResponse) in
            guard let userModel = response.user else {
                completion(false, "User Model Missing..")
                return
            }

            //MARK: - LOCAL USER SAVE
            PersistenceController.shared.saveUserData(with: userModel)
            
            iBSUserDefaults.localUser = userModel
            
            iBSUserDefaults.authToken = response.token!
            
            completion(true, "Registration Success..")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}
