//
//  PrivacyPolicyView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI

struct PrivacyPolicyView: View {
    
    @StateObject var vm = PrivacyPolicyVM()
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack{
                NavigationBarWithBackButton(title: "Privacy Policy")
                
                ScrollView(showsIndicators:false) {
                    VStack(spacing:0){
                        Text(vm.privacyUrl)
                            .font(.customFont(.RobotoMedium, 16))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 16)
                            .padding(.top, 24)
                            .padding(.bottom, 18)
                        
                    } //: VStack
                    
                } //: Scroll View
                .frame(width:UIScreen.screenWidth * 0.9,height: UIScreen.screenHeight * 0.83)
                .background(Color.custom(._FFFFFF).opacity(0.13))
                .cornerRadius(10)
                Spacer()
            } //: VStack
            .foregroundColor(Color.custom(._FFFFFF))
            .padding(.horizontal, 16)
            .onAppear{
                loadPrivacyPolicy()
            }
        } //: ZStack
        .navigationBarHidden(true)
    }
    private func loadPrivacyPolicy(){
//        self.startLoading()
        vm.loadPrivacyPolicySettings { status in
            self.stopLoading()
        }
    }
}

#Preview {
    PrivacyPolicyView()
}
