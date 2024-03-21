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
            completion(false)
            return
        }
    }
}
