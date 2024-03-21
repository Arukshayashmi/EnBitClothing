//
//  AppSettingsVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation
import Alamofire

class AppSettingsVM:BaseVM{
   
    @Published var isAccountDeleted:Bool = false
    @Published var initialViewAction:Bool = false

}
    
// MARK: - DELETE USER PROFILE
extension AppSettingsVM{
    func processWithAppSettingResponse( completion: @escaping CompletionHandler) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline.")
            return
        }

        // Prepare the endpoint
        let endpoint = "/user/delete-account"

        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .delete, encoding: URLEncoding.default, success: { (response: UserResponse) in
            
            completion(true, "Account Delete successful.")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}
