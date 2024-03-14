//
//  AppSettingsView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI

struct AppSettingsView: View {
    @StateObject var vm = AppSettingsVM()
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack {
                NavigationBarWithBackButton(title: "App Settings")
                    .padding(.bottom, 17)
                

                    ButtonWithIcon(buttonTitle: "Delete Account", buttonImage: Image(systemName: "chevron.right")) {
                        vm.isShowAlert = true
                    }
                
                Spacer()
            } //: VStack
            .padding(.horizontal, 16)
            .foregroundColor(Color.custom(._FFFFFF))
            .alert("Alert", isPresented: $vm.isShowAlert, actions: {
                Button("Cancel", role: .cancel, action: {})
                Button("Delete", role: .destructive, action: {
                    deleteAPIcall()
                })
            }, message: {
                Text("Are you sure you want delete account? Once done this cannot be undone.")
            })
            .alert(isPresented: $vm.isAccountDeleted, content: {
                Alert(
                    title: Text("Alert"),
                    message: Text("Account deleted successfully! Please cancel subscriptions manually from phone settings"),
                    dismissButton: .cancel(Text("Ok")){
                        ViewRouter.shared.currentRoot = .initialScreen
                    })
            })

        } //: ZStack
        .navigationBarHidden(true)
    }
        
    //delete API call
    func deleteAPIcall(){
        self.startLoading()
        vm.processWithAppSettingResponse { status in
            self.stopLoading()
            
            if status {
                vm.isShowAlert = false
                vm.isAccountDeleted = true
                Authenticated.send(false)
            }
            else {
                vm.alertTitle = "ERROR"
                vm.alertMessage = "Faild to delete account"
                vm.isShowAlert = true
            }
        }
    }
}


#Preview {
    AppSettingsView()
}
