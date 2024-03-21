//
//  AboutUsView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//



import SwiftUI

struct AboutUsView: View {
    
    @StateObject var vm = AboutUsVM()
   
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack{
                NavigationBarWithBackButton(title: "About US")
                Image("logoSplash")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .padding(.horizontal, 16)
                    .padding(.top, UIScreen.screenHeight * 0.04)
                    .padding(.bottom, UIScreen.screenHeight * 0.02)
                ScrollView(showsIndicators: false) {
                    VStack{
                        Text(vm.aboutUs)
                            .font(.customFont(.RobotoMedium, 16))
                    } //: VStack
                    .padding(.vertical, 24)
                    .padding(.horizontal, 16)
                } //: Scroll View
                .frame(width: UIScreen.screenWidth * 0.9,height: UIScreen.screenHeight * 0.615)
                .background(Color.custom(._FFFFFF).opacity(0.13))
                .padding(.bottom, 8)
                .cornerRadius(10)
                
            } //: VStack
            .padding(.horizontal, 16)
            .foregroundColor(Color.custom(._FFFFFF))
        } //: ZStack
        .navigationBarHidden(true)
    }
}

#Preview {
    AboutUsView()
}
