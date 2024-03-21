//
//  CompleteProfileView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import SwiftUI
import Combine
import PhoneNumberKit

struct CompleteProfileView: View {
    @StateObject var vm = CompleteProfileVM()
    @State var contactNumberLength:Int = 9
    
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            
            VStack{
                NavigationBarWithRightButton(title: "Complete Profile", placeholderText: "Logout", isImage: false,actionRightButton:{
                    logoutAPiCall()
                })
                ScrollView(.vertical , showsIndicators: false) {
                    
                    //MARK: USER IMAGE
                    ImagePlaceholder(urlString: iBSUserDefaults.localUser?.profilePic?.url, isSendItemView: false)
                        .overlay(ImagePickerButton(image: $vm.selectedImage, isCameraIcon: true, customPadding: 100, isSendItemView: false, isAddLicenesViewView: false))
                        .onChange(of: vm.selectedImage) { _ in
                            performUpdateProfileImage()
                        }
                        .padding(.vertical, 10)
                    
                    HStack(spacing: 10) {
                        CommonTextField(text: $vm.firstName, sectionHeader: "First Name", placeholder: "Ex:John")
                        
                        CommonTextField(text: $vm.lastName, sectionHeader: "Last Name", placeholder: "Ex:Doe")
                    } // : HStack
                    .padding(.top, 15)
                    
                    //MARK: PHONE INPUT
                    PhoneInput(code: $vm.countryCode, number: $vm.phoneNumber)
                    
                    DatePickerField(dateOfBirth: $vm.dob, titleText: "Date of Birth", textFieldName: .constant("Enter your BOD"))
                        .padding(.top, 16)
                    
                    CommonTextField(text: $vm.address, sectionHeader: "Address", placeholder: "Enter your address here")
                        .padding(.top, 16)
                    
                    CommonTextField(text: $vm.city, sectionHeader: "City", placeholder: "Enter your city here")
                        .padding(.top, 16)
                    
                    CommonTextField(text: $vm.postCode, sectionHeader: "Post Code", placeholder: "Enter your post code here")
                        .padding(.top, 16)

                    
                    CommenButton(buttonTitle: "Continue", buttonWidth: 220, isFilled:true) {
                        proceedCompleteProfileAPI()
                        
                    }.padding(.top, UIScreen.screenHeight * 0.02)
                    
                    Spacer()
                } //:ScrollView
                .padding(.horizontal, 16)
                .foregroundColor(Color.custom(._FFFFFF))
                .alert(isPresented: $vm.isShowAlert) {
                    Alert(
                        title: Text(vm.alertTitle),
                        message: Text(vm.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }

            }//:VStack
            .withBaseViewMod()
        } //:ZStack
        .navigationBarHidden(true)
        .onAppear{
            vm.firstName = ""
            vm.lastName = ""
            vm.countryCode = "+61"
            vm.phoneNumber = ""
        }
    }
    
}

#Preview {
    CompleteProfileView()
}

extension CompleteProfileView{
    
    func logoutAPiCall(){
        //MARK: - LOGOUT API CALL
        self.startLoading()
        vm.proceedLogoutAPi { status, _ in
            self.stopLoading()
            if status{
                ViewRouter.shared.currentRoot = .initialScreen
            }
            print(" ❌ User Logout success ! ❌ ")
        }
        
        //MARK: - CLEAN LOACL USER
        PersistenceController.shared.deleteUserData()
        
        Authenticated.send(false)
    }
    
    func performUpdateProfileImage(){
        self.startLoading()
        vm.performUpdateProfileImage() { success, _ in
            self.stopLoading()
            if success {
                showSuccessLogger(message: "Profile Image get success !")
            } else {
                showErrorLogger(message: "Profile Image get Error !")
            }
        }
    }
    
    func proceedCompleteProfileAPI(){
        if !vm.completeProfileValidation(){
            print(" Complete Profile Validation Error !")
            return
        } else if !vm.checkPhoneNumber(){
            showErrorLogger(message: "TP error !")
            return
        }
        
        self.startLoading()
        ViewRouter.shared.currentRoot = .userTabs
        vm.proceedCompleteProfileAPI() { success, _ in
            self.stopLoading()
            
            if success {
                showSuccessLogger(message: "Profile data get success !")
            } else {
                showErrorLogger(message: "Profile data get Error !")
            }
        }
    }
}
