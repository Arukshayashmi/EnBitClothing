//
//  ChangePasswordView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//



import SwiftUI

struct ChangePasswordView: View {
    
    @StateObject var vm = ChangePasswordVM()
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack{
                NavigationBarWithBackButton(title: "Change Password")
                ScrollView(showsIndicators: false) {
                    VStack{
                        Text("Stay secure and change your password")
                            .font(.customFont(.RobotoRegular, 16))
                            .padding(.bottom, 24)
                        
                        PasswordField(showPassword: $vm.showPassword, password: $vm.currentPassword, slashImageName: "eye.fill", showImageName: "eye.slash.fill", sectinHeader: "Current Password")
                            .padding(.bottom, 16)
                        PasswordField(showPassword: $vm.showNewPassword, password: $vm.newPassword, slashImageName: "eye.fill", showImageName: "eye.slash.fill", sectinHeader: "New Password")
                            .padding(.bottom, 16)
                        PasswordField(showPassword: $vm.showNewPasswordConfirm, password: $vm.newPasswordConfirm, slashImageName: "eye.fill", showImageName: "eye.slash.fill", sectinHeader: "Confirm Password")
                            .padding(.bottom, 24)
                        
                        CommenButton(buttonTitle: "Reset Password", buttonWidth: 220, isFilled: true) {
                            changePasswordAPI()
                        }
                        
                    } //: VStack
                    .padding(.top, 40)
                }
                Spacer()
            } //: VStack
            .foregroundColor(Color.custom(._FFFFFF))
            .padding(.horizontal, 16)
            .alert(isPresented: $vm.isShowAlert) {
                Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), dismissButton: .default(Text("OK")))
            }
        } //: ZStack
        .navigationBarHidden(true)
    }
    
    func changePasswordAPI(){
        if vm.passwordValidation(){
            print("Error")
            return
        }
        self.startLoading()
        vm.changePassword(newPassword: vm.newPassword, currentPassword: vm.currentPassword, newPasswordConfirm: vm.newPasswordConfirm) { status, _ in
            self.stopLoading()
            if status{
                print("Password Updated")
                vm.alertTitle = "Done"
                vm.alertMessage = "Password Updated"
                vm.isShowAlert = true
            } else {
                print("Password not Updated")
                vm.alertTitle = "Error"
                vm.alertMessage = "Error Updating Password"
                vm.isShowAlert = true
            }
        }
    }
}


#Preview {
    ChangePasswordView()
}
