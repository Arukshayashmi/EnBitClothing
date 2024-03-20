//
//  AddItemView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-20.
//

import SwiftUI

struct AddItemView: View {
    @StateObject var vm = AddItemVM()
    
    @State var navigationTitle:String = "Add Item"
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack {
                // Navigation section
                NavigationBarWithRightButton(title: navigationTitle, imageName: "", isImage: true) {}
                
                VStack(spacing: 0){
                    ScrollView(showsIndicators: false){
                        //MARK: IMAGE UPLOAD
                        ImagePlaceholder(urlString: vm.imageUrl, isSendItemView: true)
                            .overlay(ImagePickerButton(image: $vm.selectedImage, isCameraIcon: true, customPadding: 100, isSendItemView: false, isAddLicenesViewView: true))
                            .onChange(of: vm.selectedImage) { _ in
                                performUpdateProfileImage()
                            }
                            .padding(.vertical, 10)
                        
                        CommonTextField(text: $vm.name, sectionHeader: "Name", placeholder: "Enter item name here")
                            .padding(.top, 16)
                        
                        CategoriesDropDownField(selectedCategoryId: $vm.categoryId, sectionHeader: "Category", placeholderText: "Select item category here", values: $vm.ItemCategories)
                            .padding(.top, 16)
                        
                        CommonTextField(text: $vm.price, sectionHeader: "Price", placeholder: "Enter item price here")
                            .padding(.top, 16)
                        
                        MultiLineInputTextField(text: $vm.dscription, placeHolder: "Maximum 400 characters", sectionHeader: "Description")
                            .frame(height: 170)
                            .padding(.top, 16)
                        
                        Spacer()
                        
                        CommenButton(buttonTitle: "Add Item", buttonWidth: 219, isFilled:true) {
                            withAnimation(.easeIn(duration: 0.3)){
                                proceedwithAddItemAPI()
                            }
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 50)
                    } //: ScrollView
                } //: VStack
                .padding(.top, 10)
            } //: VStack
            .padding(.horizontal, 16)
            .foregroundColor(Color.custom(._FFFFFF))
            
            .onAppear{
                //API Call for get favourite clothItem cards
                self.getCategories()
            }
            .alert(isPresented: $vm.isShowAlert, content: {
                Alert(
                    title: Text(vm.alertTitle),
                    message: Text(vm.alertMessage),
                    dismissButton: .cancel(Text("Ok")) {})
            })
        } //: ZStack
        .navigationBarHidden(true)
    }
    
    //MARK: - IMAGE UPLOAD API CALL
    func performUpdateProfileImage(){
        self.startLoading()
        vm.performUploadItemImage() { success, _ in
            self.stopLoading()
            if success {
                showSuccessLogger(message: "Image upload success !")
            } else {
                showErrorLogger(message: "Image upload Error !")
            }
        }
    }
    
    //MARK: - GET CATEGORIES API CALL
    func getCategories(){
        vm.processWithCategories() { success, _ in
            if success{
                showSuccessLogger(message: "category data get success !")
            }else{
                showErrorLogger(message:  "category data get Error !")
            }
        }
    }
    
    
    //MARK: - ADD OR REMOVE FAVORITE API CALL.
    func proceedwithAddItemAPI(){
        if !vm.addItemValidation(){
            print("Validation Error !")
            return
        }
        
        self.startLoading()
        vm.proceedAddItemAPI() { success, _ in
            self.stopLoading()
            if success {
                showSuccessLogger(message: "Item adding success !")
            } else {
                showErrorLogger(message: "Item adding Error !")
            }
        }
    }
    
}


#Preview {
    AddItemView()
}
