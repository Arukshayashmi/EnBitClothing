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
}

//MARK: - CHANGE PASSWORD FUNCATION

extension ChangePasswordVM {
    func changePassword(newPassword: String, currentPassword: String, newPasswordConfirm: String, completion : @escaping CompletionHandler) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline.")
            return
        }
        
        // Prepare the endpoint
        let endpoint = "/user/password-update"
        
        // Prepare the data to be sent in the request body
        let parameters: [String: Any] = [
            "oldPassword": currentPassword,
            "newPassword": newPassword,
        ]
        
        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .put, parameters: parameters, success: { (response: UserResponse) in
            completion(true, "Change Password Success.")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}
