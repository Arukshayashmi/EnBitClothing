//
//  VerificationView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import SwiftUI
import Combine

struct VerificationView: View {
    
    @StateObject var vm: VerificationVM
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack(alignment:.center){
                NavigationBarWithRightButton(title: "Sign Up", placeholderText: "Logout", isImage: false,actionRightButton:{
                    logoutAPiCall()
                })
                Text("Please enter your verification code")
                    .font(.custom("Roboto-Regular", size: 22))
                    .foregroundColor(Color.custom(._FFFFFF))
                    .padding(.top, 40)
                Text("The verification code has been sent to \(Text("\(vm.email)").font(.customFont(.RobotoMedium, 16)))")
                    .padding(.top, 24)
                    .multilineTextAlignment(.center)
                
                Text(vm.user?.email ?? "")
                
                
                OTPView(slotCount: 4, otpText: $vm.otpText)
                
                
                CommenButton(buttonTitle: "Next", buttonWidth: 220, isFilled:true) {
                    oTPVerification()
                }
                
                
                Spacer()
                
                HStack(spacing: 3){
                    Text("Didn’t receive the verification code?")
                        .font(.customFont(.RobotoRegular, 14))
                    Button {
                        resendOTPText()
                    } label: {
                        Text("Resend")
                            .foregroundColor(Color.custom(._6347F3))
                            .font(.customFont(.RobotoRegular, 14))
                    }
                    
                } // : HStack
                .padding(.bottom, 20)
            } // : VStack
            .padding(.horizontal, 16)
            .foregroundColor(Color.custom(._FFFFFF))
            .onAppear(){
                vm.email = PersistenceController.shared.loadUserData()?.email ?? ""
            }
            .alert(isPresented: $vm.isShowAlert) {
                Alert(
                    title: Text(vm.alertTitle),
                    message: Text(vm.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        } // : ZStack
        .navigationBarHidden(true)
    }
    
    func logoutAPiCall(){
        //MARK: - LOGOUT API CALL
        self.startLoading()
        vm.proceedLogoutAPi { status, _ in
            self.stopLoading()
            if status{
                ViewRouter.shared.currentRoot = .initialScreen
            }
            print(" ❌ User Logout success ! ❌ ")
        }
        
        //MARK: - CLEAN LOACL USER
        PersistenceController.shared.deleteUserData()
        
        Authenticated.send(false)
    }
    
    func oTPVerification(){
        if !vm.checkOTP(){
            showErrorLogger(message: "OTP Validation Error !")
            return
        }
        self.startLoading()
        vm.proceedWithVerification(pinText: vm.otpText) { status,_  in
            self.stopLoading()
            if status{
                ViewRouter.shared.currentRoot = .completeProfile
                showSuccessLogger(message: "VerificationView :  \(vm.otpText) :  \(status)")
            } else {
                showErrorLogger(message: "Matching OTP Error !")
            }
        }
    }
    
    func resendOTPText(){
        self.startLoading()
        vm.resendVerificationCode { status,_  in
            self.stopLoading()
            if status{
                showSuccessLogger(message: "OTP Resend Success !")
            } else {
                showErrorLogger(message: "OTP Resend Error !")
            }
        }
    }
}


#Preview {
    VerificationView(vm: VerificationVM(email: ""))
}
