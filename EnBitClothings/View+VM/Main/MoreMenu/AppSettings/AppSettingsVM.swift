//
//  AppSettingsVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation

class AppSettingsVM:BaseVM{
   
    @Published var isAccountDeleted:Bool = false
    @Published var initialViewAction:Bool = false

}
extension AppSettingsVM{
    
    // MARK: - DELETE USER PROFILE
    func processWithAppSettingResponse(completion: @escaping (_ status: Bool) -> ()){
        
        // Check internet connection
        guard Reachability.isInternetAvailable()else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
//        ProfileAPI.profileDeleteDeleteAccount(accept: ASP.shared.accept) { data, error in
//            
//            if error != nil{
//                self.handleErrorAndShowAlert(error: error)
//                completion(false)
//                return
//           }
//           
//            completion(true)
//            PersistenceController.shared.deleteUserData()
//            SwaggerClientAPI.customHeaders.removeValue(forKey: "x-access-token")
//
//            
//        }
     }
    
    
    
}
    
