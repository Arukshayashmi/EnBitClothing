//
//  ImagePickerButton.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import SwiftUI

struct ImagePickerButton: View {
    
    //MARK: - PROPERITY
    @Binding var image: UIImage?
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var isCameraIcon: Bool
    var customPadding: CGFloat
    var isSendItemView:Bool
    var isAddLicenesViewView:Bool
    var isImageUrlEmpty:String = ""
    
    
    //MARK: - BODY
    var body: some View {
        
        VStack{
            //MARK: - IMAGE PICKER BUTTON
            Button(action:{
                showSheet.toggle()
            }){
                if isSendItemView == true {
                    if image == nil {
                        VStack(alignment: .leading){
                            Image("SendGiftsPlaceholder")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                                .padding(.horizontal, 152)
                                .padding(.vertical, 62)
                                .foregroundColor(Color.custom(._FFFFFF).opacity(0.75))

                        } // : VStack
                    } else {
                        Image("")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                            .padding(.horizontal, 152)
                            .padding(.vertical, 62)
                            .foregroundColor(Color.custom(._FFFFFF).opacity(0.75))
                    }
                    
                } else if isAddLicenesViewView{
                    if image == nil {
                        if isImageUrlEmpty.isEmpty{
                            VStack(alignment: .leading){
                                Image("SendGiftsPlaceholder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                    .padding(30)
                                    .foregroundColor(Color.custom(._FFFFFF).opacity(0.75))

                            } // : VStack
                        } else {
                            Image("")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                                .padding(30)
                                .foregroundColor(Color.custom(._FFFFFF).opacity(0.75))
                        }
                        
                    } else {
                        Image("")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                            .padding(30)
                            .foregroundColor(Color.custom(._FFFFFF).opacity(0.75))
                    }
                }else {
                    if isCameraIcon == true {
                        Image("icon.camera")
                            .foregroundColor(Color.custom(._1B1A2B))
                            .background(Color.custom(._FFFFFF)
                            .frame(width: 32,height: 32)
                            .cornerRadius(8))
                            .padding(.top, 90)
                    } else {
                        Image("icon.edit")
                            .foregroundColor(Color.custom(._1B1A2B))
                            .background(Color.custom(._FFFFFF)
                            .frame(width: 32,height: 32)
                            .cornerRadius(8))
                            .padding(.top, 90)
                    }
                }
                
            }
        }//VStack
            .actionSheet(isPresented: $showSheet ){
                ActionSheet(title: Text("Select Photo"), buttons: [
                    .default(Text("Photo Library")){
                        showImagePicker = true
                        sourceType = .photoLibrary
                    },
                    .default(Text("Camera")){
                        showImagePicker = true
                        sourceType = .camera
                    },
                    .cancel()
                ])
            }
            .sheet(isPresented: self.$showImagePicker){
                ImagePicker(image: $image, isShown: self.$showImagePicker, sourceType: sourceType)
            }
        
    }
}


