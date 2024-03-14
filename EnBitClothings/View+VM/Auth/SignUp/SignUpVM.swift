//
//  SignUpVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation
import SwiftUI

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
    //MARK: - SIGNIN FUNCATION
    func proceedWithSignUp(email: String, password: String, completion: @escaping (_ status: Bool) -> ()) {
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
//        AuthAPI.authPostRegister(accept: ASP.shared.accept, deviceId: ASP.shared.deviceId, deviceType: ASP.shared.deviceType, email: email, password: password, passwordConfirmation: password, devicePushToken: iBSUserDefaults.getFCMToken(), token: iBSUserDefaults.getGiftToken()) { response, error in
//            
//            if error != nil {
//                self.handleErrorResponse(error) { (status, statusCode, message) in
//                    self.alertTitle = "Register error"
//                    self.alertMessage = message
//                    self.isShowAlert = true
//                    
//                    if (message) == "The email has already been taken." {
//                        self.isEmailAlreadyExists = true
//                        self.isShowAlert = true
//                    }
//                    
//                    return
//                }
//                completion(false)
//            }else{
//                
//                // Read access token from readable object
//                guard let user = response?.payload else {
//                    self.alertMessage =  "Type Missed Match"
//                    self.alertTitle = .Error
//                    self.isShowAlert  =  true
//                    
//                    completion(false)
//                    return
//                }
//                
//                print("❌ access token:  \(String(describing: user.accessToken))")
//                
//                iBSUserDefaults.removeGiftToken()
//                
//                guard let accessToken = user.accessToken else{ return }
//                
//                //MARK: - SET X ACCESS TOKEN
//                AppConstant.setAccessToken(token: accessToken)
//                
//                //MARK: - LOCAL USER SAVE
//                PersistenceController.shared.saveUserData(with: user)
//                
//                //MARK: Add access token to SwaggerAPIClient Custom headers
//                AppConstant.addAccessTokenToSwaggerAPIClientcustomHeaders()
//                
//                self.showInfoLogger(message: "✅ access tocken: \(String(describing: PersistenceController.shared.accessToken))")
//                
//                completion(true)
//            }
//        }
    }
    
}
