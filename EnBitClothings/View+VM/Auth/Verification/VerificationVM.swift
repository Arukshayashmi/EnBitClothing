//
//  VerificationVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation

class VerificationVM:BaseVM {
    @Published var email:String = ""
    @Published var completeProfileAction:Bool = false
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


extension VerificationVM {
    func proceedWithVerification(pinText : String, completion: @escaping (_ status: Bool) -> ()) {
        
        // : Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
//        AuthAPI.authGetEmailVerification(code: pinText, accept: ASP.shared.accept) { data, error in
//            if error != nil {
//                self.handleErrorAndShowAlert(error: error)
//                self.alertTitle = "Incorrect Verification Code"
//                completion(false)
//                
//                return
//            }
//            
//            guard let user = data?.payload else {
//                self.isShowAlert = true
//                self.alertMessage = data?.message ?? ""
//                return
//            }
//            
//            PersistenceController.shared.updateUserData(with: user)
//            print(PersistenceController.shared.loadUserData()?.accessToken)
//            
//            completion(true)
//        }
        
    }
    
    func resendVerificationCode( completion : @escaping (_ status: Bool) -> ()){
        
        // : Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
//        AuthAPI.authGetResendVerificationCode(accept: ASP.shared.accept) { data, error in
//            if error != nil {
//                self.handleErrorAndShowAlert(error: error)
//                completion(false)
//                
//                return
//                
//            } else {
//                self.isShowAlert = true
//                self.alertTitle = .Success
//                self.alertMessage = data?.message ?? ""
//                
//                completion(true)
//            }
//        }
    }
}


