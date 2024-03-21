//
//  ForgotPasswordView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject var vm = ForgotPasswordVM()
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            GeometryReader { geometry in
                ScrollView {
                    VStack{
                        NavigationBarWithBackButton(title: "Forgot Password"){
                            //
                        }
                        Text("Enter your registered email address below and we’ll send you a password reset email")
                            .font(.custom("Roboto-Regular", size: 16))
                            .foregroundColor(Color.custom(._FFFFFF))
                            .padding(.top, 40)
                            .multilineTextAlignment(.center)
                            .lineSpacing(5)
                            .padding(.bottom, 24)
                        EmailField(text: $vm.email)
                        CommenButton(buttonTitle: "Submit", buttonWidth: 220, isFilled: true) {
                            submitAction()
                        }
                        .padding(.top, 24)
                        
                        Spacer()
                    } // : VStack
                    .padding(.horizontal, 16)
                    .alert(isPresented: $vm.isShowAlert) {
                        Alert(
                            title: Text(vm.alertTitle),
                            message: Text(vm.alertMessage),
                            dismissButton: .default(Text("OK"))
                            )
                    }
                }
            }
            
        } // : ZStack
        .navigationBarHidden(true)
        .background(
            Group {
                NavigationLink(destination: ForgotPasswordSuccess(email: vm.email),isActive: $vm.forgotPasswordSuccess, label: {})
            }
        )
        .onAppear{
            vm.email = ""
        }
    }
    
    func submitAction(){
        if !vm.checkEmail(){
            return
        }
        self.startLoading()
        vm.proceedWithResetPasswordRequest(email: vm.email) { status, _ in
            self.stopLoading()
            if status {
                vm.forgotPasswordSuccess = true
            } else {
                print("Matching Email Error!")
            }
        }
    }
    
}

#Preview {
    ForgotPasswordView()
}
