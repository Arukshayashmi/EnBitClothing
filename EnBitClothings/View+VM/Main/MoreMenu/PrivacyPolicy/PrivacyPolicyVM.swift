//
//  PrivacyPolicyVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation

 
class PrivacyPolicyVM:BaseVM{
    @Published var privacyUrl:String = ""
    
    
    func loadPrivacyPolicySettings(completion: @escaping (_ status: Bool) -> ()) {
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
//        SettingsAPI.settingsGetGetSetting(key: "PRIVACY_POLICY", accept: ASP.shared.accept, completion: { response, error in
//            
//            if error != nil {
//                self.handleErrorAndShowAlert(error: error)
//                self.showErrorLogger(message: response?.message ?? "")
//                completion(false)
//                return
//                
//            } else {
//                guard let details = response?.payload?.value else {
//                    completion(false)
//                    return
//                }
//                self.privacyUrl = "\(details)"
//                completion(true)
//                
//            }
//            
//        })
    }
}
