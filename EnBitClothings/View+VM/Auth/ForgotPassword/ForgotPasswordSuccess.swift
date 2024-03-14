//
//  ForgotPasswordSuccess.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import SwiftUI

struct ForgotPasswordSuccess: View {
    @ObservedObject var vm = ForgotPasswordVM()
    var email: String
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            GeometryReader { geometry in
                VStack{
                    NavigationBarWithBackButton(title: "Forgot Password"){
                        //
                    }
                    
                    Text("Please Check Your Email")
                        .padding(.top, 40)
                        .font(.customFont(.RobotoRegular, 22))
                    Text("A password reset link has been sent to your dedicated email")
                        .font(.customFont(.RobotoRegular, 16))
                        .padding(.top, 24)
                        .multilineTextAlignment(.center)
                    HStack(spacing:1){
                        Text("Didn’t receive the link? ")
                            .font(.customFont(.RobotoRegular, 14))
                        Button {
                            ForgotPasswordSuccessApiCall()
                        } label: {
                            Text("Resend")
                                .foregroundColor(Color.custom(._6347F3))
                                .font(.customFont(.RobotoRegular, 14))
                        }

                    } // : HStack
                    .padding(.top, 44)
                    
                    
                    
                    Spacer()
                } // : VStack
                .padding(.horizontal, 16)
                .foregroundColor(Color.custom(._FFFFFF))
            } // : GeometryReader
        } // : ZStack
        .navigationBarHidden(true)
    }
    
    func ForgotPasswordSuccessApiCall(){
        self.startLoading()
        //MARK: - API CALL
        vm.proceedWithResetPasswordRequest(email: email){ success in
            self.stopLoading()
            if success {
                print(email)
                print("Resend Success !")
            } else {
                print("Matching Email !")
                vm.isShowAlert = true
            }
        }
    }
    
}

#Preview {
    ForgotPasswordSuccess(email: "")
}
