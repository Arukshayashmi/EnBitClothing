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
                NavigationBarWithBackButton(title: "Sign Up"){
                    //
                }
                Text("Please enter your verification code")
                    .font(.custom("Roboto-Regular", size: 22))
                    .foregroundColor(Color.custom(._FFFFFF))
                    .padding(.top, 40)
                Text("The verification code has been sent to \(Text("\(vm.email)").font(.customFont(.RobotoMedium, 16)))")
                    .padding(.top, 24)
                    .multilineTextAlignment(.center)
                
                Text(vm.user?.email ?? "")
                

                
                if #available(iOS 15.0, *) {
                    OTPView(slotCount: 4, otpText: $vm.otpText)
                } else {
                    // Fallback on earlier versions
                }
               
                
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
        .background(
            Group {
                NavigationLink(destination: CompleteProfileView(),isActive: $vm.completeProfileAction, label: {})
            }
        )
    }
    func oTPVerification(){
        if !vm.checkOTP(){
            print("OTP Validation Error !")
            return
        }
//        self.startLoading()
        vm.completeProfileAction = true

        vm.proceedWithVerification(pinText: vm.otpText) { status in
            self.stopLoading()
            
            if status{
                vm.completeProfileAction = true
                
                print( "VerificationView :  \(vm.otpText) :  \(status)")
            } else {
                print("Matching OTP Error !")
            }
        }
    }
    
    func resendOTPText(){
//        self.startLoading()
       
        vm.resendVerificationCode { status in
            self.stopLoading()
            if status{
                print( "OTP Resend Success !")
            } else {
                print("OTP Resend Error !")
            }
        }
    }
}


#Preview {
    VerificationView(vm: VerificationVM(email: ""))
}
