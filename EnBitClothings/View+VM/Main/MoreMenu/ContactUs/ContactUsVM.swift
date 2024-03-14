//
//  ContactUsVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation

class ContactUsVM:BaseVM{
    @Published var message:String = ""
}


extension ContactUsVM{
    func proceesdSendMessage(completion: @escaping (_ status: Bool) -> ()){
        //: Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }

//        ContactUsAPI.contactUsPostSendAMessage(message: message, accept: ASP.shared.accept) { data, error in
//            if error != nil {
//                self.handleErrorResponse(error) { (status, statusCode, message) in
//                    self.alertTitle = "Contact Us Error"
//                    self.alertMessage = message
//                    self.isShowAlert = true
//                    
//                    return
//                }
//                completion(false)
//            } else {
//                completion(true)
//            }
//        }
    }
}
