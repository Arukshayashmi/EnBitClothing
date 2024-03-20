//
//  SignInView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//
import SwiftUI

struct SignInView: View {
    @StateObject var vm = SignInVM()
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            GeometryReader { geometry in
                ScrollView {
                    VStack{
                        NavigationBarWithBackButton(title: "Sign In", actionStatus: true){
                            ViewRouter.shared.currentRoot = .initialScreen
                        }
                        Image("logoSplash")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height * 0.15)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 24)
                        EmailField(text: $vm.email)
                            .padding(.top, 8)
                        PasswordField(showPassword: $vm.showPassword, password: $vm.password, slashImageName: "eye.slash.fill", showImageName: "eye.fill")
                            .padding(.top, 18)
                            .padding(.bottom, 8)
                        Button {
                            vm.forgotPasswordAction = true
                        } label: {
                            Text("Forgot Password?")
                                .font(.custom("Roboto-Medium", size: 14))
                                .foregroundColor(Color.custom(._FFFFFF))
                                .frame(height: geometry.size.height * 0.048)
                        }

                        CommenButton(buttonTitle: "Sign In", buttonWidth: 220, isFilled:true) {
                            signInApiCall()
                        }
                        .padding(.top, 8)
                        Spacer()
//                        //SocialLogin()
//                            .padding(.top, 48)
                        HStack(spacing: 3){
                            Text("Don’t have an account?")
                            Button {
                                ViewRouter.shared.currentRoot = .signUp
                            } label: {
                                Text("Sign Up")
                                    .foregroundColor(Color.custom(._6347F3))
                            }

                        } // : HStack
                        .font(.custom("Roboto-Medium", size: 14))
                        .foregroundColor(Color.custom(._FFFFFF))
                        .padding(.bottom, 20)
                    } // : VStack
                    .onAppear{
                        vm.email = ""
                        vm.password = ""
                    }
                    .padding(.horizontal, 16)
                    .frame(minHeight: geometry.size.height)
                    .alert(isPresented: $vm.isShowAlert) {
                        Alert(
                            title: Text(vm.alertTitle),
                            message: Text(vm.alertMessage),
                            dismissButton: .default(Text("OK"), action: {
                                if vm.isNotVerified {
                                    ViewRouter.shared.currentRoot = .signUpVerify
//                                    vm.verificationViewAction = true
                                }
                            })
                            )
                    }
                }
            } // : GeometryReader
            
        } // : ZStack
        .navigationBarHidden(true)
        .background(
            Group {
                NavigationLink(destination: SignUpView(),isActive: $vm.signUpAction, label: {})
                NavigationLink(destination: ForgotPasswordView(),isActive: $vm.forgotPasswordAction, label: {})
            }
        )
    }
    private func signInApiCall(){
        if !vm.signInCheck(){
            showErrorLogger(message: "Sign In Error")
            return
        }
        self.startLoading()
        vm.proceedSignInApi(email: vm.email, password: vm.password) { success, _ in
            self.stopLoading()
            if success{
                if EmailVerifiedAt() {
                    if IsProfileCompleted() {
                        ViewRouter.shared.currentRoot = .userTabs
                    } else {
                        ViewRouter.shared.currentRoot = .completeProfile
                    }
                } else {
                    ViewRouter.shared.currentRoot = .signUpVerify
                }
                iBSUserDefaults.isOnBoard = true
                iBSUserDefaults.guest = false
                showSuccessLogger(message: "Sign In Success")
            } else {
                showErrorLogger(message: "Sign In Error")
            }
        }
        
    }
    
}

#Preview {
    SignInView()
}
