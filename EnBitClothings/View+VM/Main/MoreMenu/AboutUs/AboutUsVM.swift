//
//  AboutUsVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation

class  AboutUsVM : BaseVM {
    

    @Published var aboutUsUrl:String = ""
    
    
    func loadAboutUsSettings(completion: @escaping (_ status: Bool) -> ()) {
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
//        SettingsAPI.settingsGetGetSetting(key: "ABOUT_US", accept: ASP.shared.accept, completion: { response, error in
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
//                self.aboutUsUrl = "\(details)"
//                completion(true)
//                
//            }
//            
//        })
    }
}
