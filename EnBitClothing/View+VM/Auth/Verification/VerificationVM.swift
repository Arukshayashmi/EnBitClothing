//
//  VerificationVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation
import Alamofire

class VerificationVM:BaseVM {
    @Published var email:String = ""
    @Published var otpText:String = ""
    
    @Published var user: User?

    init(email: String) {
        self.email = email
    }
    
    func checkOTP() -> Bool{
        if otpText.isEmpty {
            self.alertMessage = "Please enter the verification code"
            self.alertTitle = .Error
            self.isShowAlert = true
            
            return false
        } else if !(otpText.count == 4) {
            self.alertMessage = "Invalid OTP Number"
            self.alertTitle = .Error
            self.isShowAlert = true
                
            return false
        }
        return true
    }
}


//: MARK: -

extension VerificationVM {
    func proceedWithVerification(pinText : String, completion: @escaping CompletionHandler) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline.")
            return
        }

        // Prepare the endpoint
        let endpoint = "/user/verify"
        
        // Prepare the data to be sent in the request body
        let parameters: [String: Any] = [
            "code": pinText
        ]

        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .post, parameters: parameters, success: { (response: UserResponse) in
            guard let userModel = response.user else {
                completion(false, "User Model Missing.")
                return
            }

            //MARK: - LOCAL USER SAVE
            PersistenceController.shared.saveUserData(with: userModel)
            
            iBSUserDefaults.localUser = userModel
            
            completion(true, "Verification successful.")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}


//: MARK: -

extension VerificationVM {
    func resendVerificationCode( completion: @escaping CompletionHandler) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline.")
            return
        }

        // Prepare the endpoint
        let endpoint = "/user/resend-code"

        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .get, encoding: URLEncoding.default, success: { (response: UserResponse) in
            
            completion(true, "Verification resend successful.")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}
