//
//  SignUpView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var vm = SignUpVM()
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            GeometryReader{ geometry in
                ScrollView {
                    VStack(alignment:.center){
                        NavigationBarWithBackButton(title: "Sign Up", actionStatus: true){
                            ViewRouter.shared.currentRoot = .initialScreen
                        }
                        
                        Image("logoSplash")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .padding(.vertical, 24)
                            .padding(.horizontal, 16)
                        EmailField(text: $vm.email)
                        
                        PasswordField(showPassword: $vm.showPassword, password: $vm.password, slashImageName: "eye.slash", showImageName: "eye")
                            .padding(.top, 16)
                        
                        Text("By continuing, you agree to our Terms and Conditions\n and confirm you have read our Privacy Policy.")
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .font(.custom("Roboto-Regular", size: 14))
                            .padding(.top, 20)
                            .lineSpacing(6)
                        CommenButton(buttonTitle: "Verify Account", buttonWidth: 220, isFilled:true) {
                            signUpApiCall()
                            
                        }
                        .padding(.top, 20)
                        Spacer()
                        HStack(spacing: 5){
                            Text("Already have an account?")
                                .font(.customFont(.RobotoMedium, 14))
                            Button {
                                ViewRouter.shared.currentRoot = .signIn
                            } label: {
                                Text("Sign In")
                                    .foregroundColor(Color.custom(._6347F3))
                            }
                        } // : HStack
                        .padding(.bottom, 20)
                        
                        
                    } // : VStack
                    .padding(.horizontal, 16)
                    .foregroundColor(Color.custom(._FFFFFF))
                    .frame(minHeight: geometry.size.height)
                    .alert(isPresented: $vm.isShowAlert) {
                        if vm.isEmailAlreadyExists{
                            return Alert(title: Text("Email Registered"),
                                         message: Text("The email address you have entered has already been registered"),primaryButton: .default(Text("Cancel")), secondaryButton: .default(Text("Sign In"), action: {ViewRouter.shared.currentRoot = .signIn})
                            )
                        } else {
                            return Alert(
                                title: Text(vm.alertTitle),
                                message: Text(vm.alertMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                    
                }
                
            } // : GeometryReader
        } // : ZStack
        .navigationBarHidden(true)
        .onAppear{
            vm.email = ""
            vm.password = ""
        }
    }
    
    func signUpApiCall(){
        //MARK: - VALIDATIONS
        if !vm.signUpCheck(){
            showErrorLogger(message: "Sign Up Error")
            return
        }
        
        self.startLoading()
        //MARK: - API CALL
        vm.proceedWithSignUp(email: vm.email, password: vm.password){ success, _ in
            if success{
                iBSUserDefaults.isOnBoard = true
                ViewRouter.shared.currentRoot = .signUpVerify
                showSuccessLogger(message: "Register Success..")
                stopLoading()
            } else {
                showErrorLogger(message: "Matching Email Error !")
                self.stopLoading()
            }
        }
    }
}

#Preview {
    SignUpView()
}
