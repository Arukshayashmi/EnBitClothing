//
//  PasswordField.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import Foundation
import SwiftUI

struct PasswordField:View {
    
    @Binding var showPassword:Bool
    @Binding var password:String
    var slashImageName:String
    var showImageName:String
    var sectinHeader:String?
    
    var body: some View{
        
        VStack(alignment:.leading) {
            Text(sectinHeader ?? "Password")
                .font(.custom("Roboto-Regular", size: 14))
                .foregroundColor(Color.custom(._FFFFFF))
            
            
            HStack {
                VStack {
                    if showPassword {
                        TextField("", text: $password)
                            .placeholder(when: password.isEmpty) {
                                Text("Password")
                                    .foregroundColor(Color.custom(._FFFFFF).opacity(0.15))
                                    .font(.custom("Roboto-Regular", size: 14))
                            }
                        
                    } else {
                        SecureField("", text: $password)
                            .placeholder(when: password.isEmpty) {
                                Text("* * * * * * *")
                                    .foregroundColor(Color.custom(._FFFFFF).opacity(0.15))
                                    .font(.custom("Roboto-Regular", size: 14))
                                    .padding(.top, 5)
                                
                            }
                    }
                }
                
                
                Button(action: {
                    showPassword.toggle()
                }) {
                    if !showPassword {
                        Image( systemName: slashImageName)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.custom(._FFFFFF))
                            .frame(width: 22,height: 19)
                            .padding(.trailing, 16)
                    } else {
                        Image( systemName: showImageName)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.custom(._FFFFFF))
                            .frame(width: 22,height: 19)
                            .padding(.trailing, 16)
                    }
                    
                                         
                        
                }
                
            }
            .autocorrectionDisabled()
            .autocapitalization(.none)
            .padding(.leading, 16)
            .frame(height: 48)
            .foregroundColor(Color.white)
            .background(Color.custom(._FFFFFF).opacity(0.13))
            .cornerRadius(10)
        }
        
    }
}

