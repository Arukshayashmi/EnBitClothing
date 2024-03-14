//
//  ForgotPasswordVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation

class ForgotPasswordVM:BaseVM {
    @Published var email:String = ""
    @Published var forgotPasswordSuccess:Bool = false
}
extension ForgotPasswordVM {
    func checkEmail() -> Bool{
        if email.isEmpty{
            self.alertMessage = "Please enter  email address"
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

extension ForgotPasswordVM {
    func proceedWithResetPasswordRequest(email : String, completion : @escaping (_ status: Bool) -> ()) {
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
//        ForgotPasswordAPI.forgotpasswordPostResetPassword(accept: ASP.shared.accept, email: email) { response, error in
//            
//            if error != nil {
//                self.handleErrorAndShowAlert(error: error)
//                completion(false)
//                return
//            }
//            
//            guard (response?.payload) != nil else {
//                self.isShowAlert = true
//                self.alertMessage = response?.message ?? ""
//                return
//            }
//            
//            completion(true)
//        }
    }
}

