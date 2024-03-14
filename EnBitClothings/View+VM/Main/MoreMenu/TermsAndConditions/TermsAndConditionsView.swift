//
//  TermsAndConditionsView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI

struct TermsAndConditionsView: View {
    
    @StateObject var vm = TermsAndConditionsVM()
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack{
                NavigationBarWithBackButton(title: "Terms & Conditions")
                    .padding(.bottom, 16)
                
                ScrollView(showsIndicators:false) {
                    Text(vm.termsUrl)
                        .font(.customFont(.RobotoMedium, 16))
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                .padding(.bottom, 18)
                .frame(width: UIScreen.screenWidth * 0.9)
                .background(Color.custom(._FFFFFF).opacity(0.13))
                .padding(.bottom, 10)
                Spacer()
            } //: VStack
            .padding(.horizontal, 16)
            .foregroundColor(Color.custom(._FFFFFF))
            .onAppear{
                loadTerms()
            }
        } //: ZStack
        .navigationBarHidden(true)
    }
    private func loadTerms(){
//        self.startLoading()
        vm.loadTermsSettings { status in
            self.stopLoading()
        }
    }
}



#Preview {
    TermsAndConditionsView()
}
