//
//  SignInVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation

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
    func proceedSignInApi(email : String, password : String, completion : @escaping (_ status: Bool) -> ()){
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
//        AuthAPI.authPostLogin(accept: ASP.shared.accept, deviceId: ASP.shared.deviceId, deviceType: ASP.shared.deviceType, email: email, password: password) { data, error in
//            if error != nil {
//                self.handleErrorAndShowAlert(error: error)
//                completion(false)
//                return
//            }
//            
//            guard let user = data?.payload else {
//                self.isShowAlert = true
//                self.alertMessage = data?.message ?? ""
//                completion(false)
//                return
//            }
//            
//            //MARK: - LOCAL USER DELETE
//            PersistenceController.shared.deleteUserData()
//            
//            //MARK: - LOCAL USER SAVE
//            PersistenceController.shared.saveUserData(with: user)
//            
//            //MARK: Add access token to SwaggerAPIClient Custom headers
//            AppConstant.addAccessTokenToSwaggerAPIClientcustomHeaders()
//            
//            self.showInfoLogger(message: "✅ FCM Tocken: \(String(describing: iBSUserDefaults.getFCMToken())) ✅")
//            
//            self.showInfoLogger(message: "✅ access tocken: \(String(describing: PersistenceController.shared.accessToken))")
//            
//            self.showInfoLogger(message: "Is User EmailVerifiedAt \( PersistenceController.shared.loadUserData()?.emailVerifiedAt != nil )")
//            
//            if  PersistenceController.shared.loadUserData()?.emailVerifiedAt != nil {
//                completion(true)
//            } else {
//                self.alertMessage =  "The email address you have entered has already been registered. But this account is not verified."
//                self.alertTitle = "Please Verify Your Account"
//                self.isShowAlert  =  true
//                self.isNotVerified = true
//                completion(false)
//            }
//        }
    }
    
}
