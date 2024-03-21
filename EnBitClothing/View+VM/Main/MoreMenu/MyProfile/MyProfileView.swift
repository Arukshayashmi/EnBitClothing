//
//  MyProfileView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//



import SwiftUI

struct MyProfileView: View {
    
    @StateObject var vm = MyProfileVM()
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack{
                NavigationBarWithBackButton(title: "My Profile")
                    .padding(.top, 1)
                ScrollView(showsIndicators: false){
                    VStack(spacing:10){
                        ImagePlaceholder(urlString: iBSUserDefaults.localUser?.profilePic?.url, isSendItemView: false)
                            .overlay{
                                ImagePickerButton(image: $vm.selectedImage, isCameraIcon: false, customPadding: 0, isSendItemView: false, isAddLicenesViewView: false)
                            }
                            .onChange(of: vm.selectedImage) { _ in
                                vm.performUpdateProfileImage{ success, _ in }
                            }
                            .padding(.top, 16)
                        
                        ProfileDetailField(title: "Email", detail: vm.email)
                            .padding(.top, 20)
                        
                        ProfileDetailField(title: "First Name", detail: vm.firstName)
                        
                        ProfileDetailField(title: "Last Name", detail: vm.lastName)
                        
                        ProfileDetailField(title: "Phone Number", detail: vm.phoneNumber == "" ? "" : "\(vm.countryCode)\(vm.phoneNumber)")
                        
                        ProfileDetailField(title: "Date of Birth", detail: vm.dob)
                        
                        ProfileDetailField(title: "Address", detail: vm.address)
                        
                        ProfileDetailField(title: "City", detail: vm.city)
                        
                        ProfileDetailField(title: "Post Code", detail: vm.postCode)
                        
                        
                        Spacer()

                        CommenButton(buttonTitle: "Edit Profile", buttonWidth: UIScreen.screenWidth * 0.9, isFilled: false) {
                            vm.editProfileViewAction.toggle()
                        }
                        CommenButton(buttonTitle: "Change Password", buttonWidth: UIScreen.screenWidth * 0.9, isFilled: true) {
                            vm.changePasswordViewAction.toggle()
                        }
                        
                    } //: VStack
                } //: Scroll View
            } //: VStack
            .padding(.horizontal, 16)
            .foregroundColor(Color.custom(._FFFFFF))
            .onAppear{
                self.startLoading()
                vm.loadProfileDetails{ success, _ in
                    self.stopLoading()
                    if success{
                        print("✅ User data loading success")
                    }
                }
            }
          
            .alert(isPresented: $vm.isShowAlert) {
                Alert(
                    title: Text(vm.alertTitle),
                    message: Text(vm.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        } //: ZStack
        .navigationBarHidden(true)
        .background(
            Group{
                NavigationLink(destination: EditProfileView(), isActive: $vm.editProfileViewAction ,label: {})
                NavigationLink(destination: ChangePasswordView(), isActive: $vm.changePasswordViewAction, label: {})
            })
    }
}

#Preview {
    MyProfileView()
}
