//
//  MoreMenuVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//



import Foundation
import SwiftUI


class MoreMenuVM:BaseVM {
    
    @Published var initialViewAction:Bool = false
    @Published var destination:AnyView?
    @Published var destinationAction:Bool = false
    
    
    @Published var moreMenuButtons:[MoreMenuItem] = [
        MoreMenuItem(buttonTitle: "My Profile", buttonImageName:"icon.profile", destination: AnyView(MyProfileView())),
        MoreMenuItem(buttonTitle: "Payment Method", buttonImageName:"icon.wallet", destination: AnyView(PaymentMethodsView())),
        MoreMenuItem(buttonTitle: "About Us", buttonImageName:"icon.info", destination: AnyView(AboutUsView())),
        MoreMenuItem(buttonTitle: "Contact Us", buttonImageName:"icon.contact", destination: AnyView(ContactUsView())),
        MoreMenuItem(buttonTitle: "Privacy Policy", buttonImageName:"icon.shield", destination: AnyView(PrivacyPolicyView())),
        MoreMenuItem(buttonTitle: "Terms & Conditions", buttonImageName:"icon.terms", destination: AnyView(TermsAndConditionsView())),
        MoreMenuItem(buttonTitle: "App Settings", buttonImageName: "icon.setting", destination: AnyView(AppSettingsView()))
    ]
    
    struct MoreMenuItem:Identifiable{
        var id = UUID()
        
        var buttonTitle:String
        var buttonImageName:String
        var destination:AnyView
    }
}
