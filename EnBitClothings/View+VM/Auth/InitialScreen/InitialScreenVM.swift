//
//  InitialScreenVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation
import SwiftUI

class InitialScreenVM: BaseVM{
    @Published var signUpAction: Bool = false
    @Published var signInAction: Bool = false
    @Published var exploreAsGuest: Bool = false
    
}

extension InitialScreenVM{
    func proceedGuestAPi(completion : @escaping (_ status: Bool) -> ()?){
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
//        GuestAPI.guestGetGuestSettings(accept: ASP.shared.accept) { data, error in
//            if error != nil {
//                self.handleErrorAndShowAlert(error: error)
//                completion(false)
//                return
//            }
//            
//            guard (data?.payload) != nil else {
//                self.isShowAlert = true
//                self.alertMessage = data?.message ?? ""
//                return
//            }
//            
//            completion(true)
//        }
    }
}


extension InitialScreenVM{
    
    func handleItemUrl(url: String){
        guard let token = url.components(separatedBy: "/").last else{
            return
        }

//        iBSUserDefaults.setGiftToken(token: token)
    }
}

