//
//  SocialButton.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI

struct SocialButton: View {
    let imageName: String
    let url: String
    
    var body: some View {
        Button(action: {
            guard let web = URL(string: url),
                  UIApplication.shared.canOpenURL(web) else {
                return
            }
            UIApplication.shared.open(web, options: [:], completionHandler: nil)
        }, label: {
            ZStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 36, height: 36)
            }//:ZStack
            .shadow(color: Color("applyFilterShadow"), radius: 10.0, x: 0.0, y: 0.1)
        })
    }
}
