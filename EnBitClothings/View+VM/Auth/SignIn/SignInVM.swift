//
//  SignInVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation
import Alamofire

class SignInVM: BaseVM {
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var showPassword:Bool = false
    
    // : View Navigation actions
    @Published var signUpAction:Bool = false
    @Published var forgotPasswordAction:Bool = false
    @Published var homeViewAction:Bool = false
    
    // : Check user Verified
    @Published var verificationViewAction:Bool = false
    @Published var isNotVerified:Bool = false
}

extension SignInVM {
    func signInCheck() -> Bool{
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
        }else if !Validators().isValidEmailValidator(value: email).isSuccess {
            
            self.alertMessage = "Please enter a valid email address"
            self.alertTitle = "Valid Email Required"
            self.isShowAlert = true
            
            return false
        }
        return true
    }
}


extension SignInVM {
    func proceedSignInApi(email: String, password: String, completion: @escaping CompletionHandler) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline.")
            return
        }

        // Prepare the endpoint
        let endpoint = "/user/login"

        // Prepare the data to be sent in the request body
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]

        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .post, parameters: parameters, success: { (response: UserResponse) in
            guard let userModel = response.user else {
                self.isShowAlert = true
                self.alertTitle = "Error"
                self.alertMessage = "Incorrect Email or Password"
                completion(false, "User Model Missing..")
                return
            }

            //MARK: - LOCAL USER DELETE
            PersistenceController.shared.deleteUserData()
            
            //MARK: - LOCAL USER SAVE
            PersistenceController.shared.saveUserData(with: userModel)
            
            iBSUserDefaults.localUser = userModel

            iBSUserDefaults.authToken = response.token!
            
            completion(true, "Login Success.")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}

//            if  PersistenceController.shared.loadUserData()?.emailVerifiedAt != nil {
//                completion(true)
//            } else {
//                self.alertMessage =  "The email address you have entered has already been registered. But this account is not verified."
//                self.alertTitle = "Please Verify Your Account"
//                self.isShowAlert  =  true
//                self.isNotVerified = true
//                completion(false)
//            }
