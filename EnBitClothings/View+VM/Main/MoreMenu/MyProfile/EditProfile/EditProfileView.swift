//
//  EditProfileView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//



import SwiftUI

struct EditProfileView: View {
    @StateObject var vm = EditProfileVM()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack{
                NavigationBarWithBackButton(title: "Edit Profile")
                ScrollView(showsIndicators: false) {
                    VStack{
                        CommonTextField(text: $vm.firstName, sectionHeader: "First Name", placeholder: "First Name")
                            .padding(.top, 30)
                        
                        CommonTextField(text: $vm.lastName, sectionHeader: "Last Name", placeholder: "Last Name")
                            .padding(.top, 15)
                        
                        //MARK: PHONE INPUT
                        PhoneInput(code: $vm.countryCode, number: $vm.phoneNumber)
                            .padding(.bottom, 10)
                        
                        DatePickerField(dateOfBirth: $vm.dob, textDate: vm.dobValue, titleText: "Date of Birth", textFieldName: .constant("\(vm.dobValue)"))
                            .padding(.top, 16)
                        
                        CommonTextField(text: $vm.address, sectionHeader: "Address", placeholder: "Enter your address here")
                            .padding(.top, 16)
                        
                        CommonTextField(text: $vm.city, sectionHeader: "City", placeholder: "Enter your city here")
                            .padding(.top, 16)
                        
                        CommonTextField(text: $vm.postCode, sectionHeader: "Post Code", placeholder: "Enter your post code here")
                            .padding(.top, 16)
                        

                        
                        Spacer()
                    } //: VStack
                    CommenButton(buttonTitle: "Save Changes", buttonWidth: UIScreen.screenWidth * 0.9, isFilled: true) {
                        //editProfileAPiCall()
                        loadProfileDetailsEdit()
                    }
                    .padding(.top, 16)
                } //: Scroll View
            } //: VStack
            .padding(.horizontal, 16)
            .alert(isPresented: $vm.isShowAlert) {
                Alert(
                    title: Text(vm.alertTitle),
                    message: Text(vm.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        } //: ZStack
        .withBaseViewMod()
        .onAppear{
            
            loadProfileDetailsLoading()

        }

        .navigationBarHidden(true)
        
    }
}


#Preview {
    EditProfileView()
}

extension EditProfileView{
    func loadProfileDetailsLoading(){
//        self.startLoading()
        vm.loadProfileDetails{ success in
            self.stopLoading()
            
            if success {
                showSuccessLogger(message: "User data loding success !")
                
            } else {
                showErrorLogger(message: "User data loading Error !")
            }
        }
    }
    
    func loadProfileDetailsEdit(){
//        self.startLoading()
        presentationMode.wrappedValue.dismiss()

        vm.loadProfileDetails{ success in
            self.stopLoading()
            
            if success {
                showSuccessLogger(message: "User data edit success !")
                presentationMode.wrappedValue.dismiss()
            } else {
                showErrorLogger(message: "User data edit Error !")
            }
        }
    }
}
