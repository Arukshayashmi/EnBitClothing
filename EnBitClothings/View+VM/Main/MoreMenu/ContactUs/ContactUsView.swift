//
//  ContactUsView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI

struct ContactUsView: View {
    
    @StateObject var vm = ContactUsVM()
    
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack{
                NavigationBarWithBackButton(title: "Contact Us")
                
                ScrollView(showsIndicators:false) {
                    VStack(spacing: 0){
                        Text("Have a question?")
                            .padding(.bottom, 5)
                        Text("Get in touch and we’ll get back to you.")
                            .padding(.bottom, 44)
                        MultiLineInputTextField(text: $vm.message, placeHolder: "Maximum 400 characters", sectionHeader: "Message")
                            .padding(.bottom, 24)
                        CommenButton(buttonTitle: "Submit", buttonWidth: 220, isFilled: true) {
                            contactUsAPICall()
                        }
                        .padding(.top, 32)
                    } //: VStack
                    .padding(.top, 40)
                .font(.customFont(.RobotoRegular, 16))
                } //: Scroll View
                
            } //: VStack
            .padding(.horizontal, 16)
            .foregroundColor(Color.custom(._FFFFFF))
            .alert(isPresented: $vm.isShowAlert){
                Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), dismissButton: .default(Text("Ok")))
            }
        } //: ZStack
        .navigationBarHidden(true)
    }
    private func contactUsAPICall(){
        self.startLoading()
        vm.proceesdSendMessage { status in
            self.stopLoading()
            if status {
                vm.alertTitle = "Succees"
                vm.alertMessage = "Message Sended"
                vm.isShowAlert = true
            }
        }
    }

}

#Preview {
    ContactUsView()
}
