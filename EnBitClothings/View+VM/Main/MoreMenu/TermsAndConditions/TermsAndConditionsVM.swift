//
//  TermsAndConditionsVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation


class TermsAndConditionsVM:BaseVM{
    
    @Published var termsUrl:String = ""
    
    
    func loadTermsSettings(completion: @escaping (_ status: Bool) -> ()) {
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
//        SettingsAPI.settingsGetGetSetting(key: "TERMS_AND_CONDITIONS", accept: ASP.shared.accept, completion: { response, error in
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
//                self.termsUrl = "\(details)"
//                completion(true)
//                
//            }
//            
//        })
    }
    
    
    
}
