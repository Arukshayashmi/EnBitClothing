//
//  InitialScreenView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import SwiftUI

struct InitialScreenView: View {
    @StateObject var vm = InitialScreenVM()
    var body: some View {
        ZStack {
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack(alignment:.center){
                Image("logoSplash")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.bottom, UIScreen.screenHeight * 0.05)
                    .padding(.top, UIScreen.screenHeight * 0.2)
                    .padding(.horizontal, 32)
                CommenButton(buttonTitle: "Sign Up", buttonWidth: 220, isFilled: true) {
                    vm.signUpAction = true
                }
                .padding(.bottom, UIScreen.screenHeight * 0.25)
                
                Button {
                    vm.exploreAsGuest = true
                    iBSUserDefaults.guest = true
                    
                } label: {
                    Text("Explore as Guest")
                        .padding(.bottom, 27)
                }
                HStack(spacing: 3){
                    Text("Already have an account?")
                    Button {
                        vm.signInAction = true
                    } label: {
                        Text("Sign In")
                            .foregroundColor(Color.custom(._6347F3))
                    }
                } // : HStack
                .padding(.bottom, 45)
                
            }// : VStack
            .foregroundColor(Color.custom(._FFFFFF))
            .font(.custom("Roboto-Medium", size: 14))
            
        }// : ZStack
        .navigationBarHidden(true)
        .background(
            Group {
                NavigationLink(destination:SignUpView(),isActive:$vm.signUpAction,label: {})
                NavigationLink(destination: SignInView(),isActive: $vm.signInAction, label: {})
                NavigationLink(destination: TabBarView(vm: TabBarVM(selectedTab: .homeView)),isActive: $vm.exploreAsGuest, label: {})
            }
        )
    }
}

#Preview {
    InitialScreenView()
}
