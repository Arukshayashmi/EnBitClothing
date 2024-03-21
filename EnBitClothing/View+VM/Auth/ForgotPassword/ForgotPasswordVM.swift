//
//  ForgotPasswordVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation
import Alamofire

class ForgotPasswordVM:BaseVM {
    @Published var email:String = ""
    @Published var forgotPasswordSuccess:Bool = false
}
extension ForgotPasswordVM {
    func checkEmail() -> Bool{
        if email.isEmpty{
            self.alertMessage = "Please enter email address"
            self.alertTitle = "Empty Email"
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


//: MARK: - REGISTER FUNCTION

extension ForgotPasswordVM {
    func proceedWithResetPasswordRequest(email: String, completion: @escaping CompletionHandler) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline.")
            return
        }

        // Prepare the endpoint
        let endpoint = "/user/reset-password"

        // Prepare the data to be sent in the request body
        let parameters: [String: Any] = [
            "email": email
        ]

        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .post, parameters: parameters, success: { (response: UserResponse) in
            
            completion(true, "Password Reset Success.")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}
