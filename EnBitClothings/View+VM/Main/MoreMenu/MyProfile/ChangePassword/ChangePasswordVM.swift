//
//  ChangePasswordVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//



import Foundation

class ChangePasswordVM:BaseVM{
    
    @Published var currentPassword:String = ""
    @Published var newPassword:String = ""
    @Published var newPasswordConfirm:String = ""
    
    
    
    @Published var showPassword:Bool = false
    @Published var showNewPassword:Bool = false
    @Published var showNewPasswordConfirm:Bool = false
    
}

extension ChangePasswordVM{
    func passwordValidation() -> Bool{
        if currentPassword.isEmpty {
            alertTitle = .Error
            alertMessage = "Please Enter First Name"
            isShowAlert = true
            return true
        
        } else if newPassword.isEmpty {
            alertTitle = .Error
            alertMessage = "Please Enter Last Name"
            isShowAlert = true
            return true
        } else if newPasswordConfirm.isEmpty {
            alertTitle = .Error
            alertMessage = "Please Enter Last Name"
            isShowAlert = true
            return true
        }
        return false
    }
    
    
    
    
    
    func changePassword(newPassword:String, currentPassword:String, newPasswordConfirm:String, completion : @escaping (_ status: Bool) -> ()){
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
//        AuthAPI.authPostUpdatePassword(password: newPassword, currentPassword: currentPassword, passwordConfirmation: newPasswordConfirm, accept: ASP.shared.accept) { data, error in
//            //
//            
//            if error != nil {
//                self.handleErrorAndShowAlert(error: error)
//                
//                self.isShowAlert = true
//                self.alertTitle = "Passwords Do Not Match"
//                self.alertMessage = data?.message ?? "The passwords you have entered do not match"
//                completion(false)
//                return
//                
//            } else {
//                self.isShowAlert = false
//                self.alertTitle = .Success
//                self.alertMessage = data?.message ?? ""
//                completion(true)
//                return
//            }
//        }
        
    }
}

