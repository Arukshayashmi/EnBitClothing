//
//  NavigationBar.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import Foundation
import SwiftUI


struct NavigationBarWithBackButton: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var title: String
    var actionStatus:Bool = false
    var action: (()->()?)? = nil
   
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    
                }
                .frame(height: geo.safeAreaInsets.top)
            }
            
            Text(title)
                .font(.custom("Roboto-Medium", size: 16))
                .foregroundColor(Color.custom(._FFFFFF))
                .lineLimit(2)
            
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.custom(._FFFFFF))
                    .frame(width: 12, height: 20)
                    .onTapGesture {
                        if actionStatus {
                            action!()
                        }
                        presentationMode.wrappedValue.dismiss()
                        
                    }
                Spacer()
            }//:HStack
        }//:ZStack
        .frame(height: 44)
    }
//    private func goBack(){
//        if routerActionGoBack{
//            router.goBack()
//        }
//        presentationMode.wrappedValue.dismiss()
//    }
}

struct NavigationBarWithRightButton:View {
    var title: String
    var imageName:String?
    var placeholderText:String?
    var isImage:Bool
    var actionRightButton: ()->()?
    
    var body: some View{
        ZStack {
            Text(title)
                .font(.customFont(.RobotoMedium, 16))
                .foregroundColor(Color.custom(._FFFFFF))
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    actionRightButton()
                }, label: {
                    if isImage == true {
                        Image(imageName ?? "")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.custom(._FFFFFF))
                            .frame(width: 20, height: 18.5)
                    } else {
                        Text(placeholderText ?? "")
                            .font(.customFont(.RobotoRegular, 16))
                            .foregroundColor(Color.custom(._FFFFFF))
                    }
                })
            }//:HStack
        }//:ZStack
        .padding(.horizontal, 16)
        .frame(height: 50)
    }
}


struct NavigationBarWithBothButton:View{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var title: String
    var buttonRightImage:Image
    var buttonLeftImage:Image
    var buttonText:String
    var buttonColor:Color?
    var actionRightButton: ()->()?
    
    var body: some View{
        ZStack{
            Text(title)
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    buttonLeftImage
                }
                Spacer()
                Button {
                    actionRightButton()
                } label: {
                    if buttonText.isEmpty {
                        buttonRightImage
                            .foregroundColor(buttonColor ?? Color.custom(._FFFFFF))
                    }
                    Text(buttonText)
                    
                }
            }
        } //:ZStack
        .foregroundColor(Color.custom(._FFFFFF))
        .padding(.vertical, 12)
        .font(.customFont(.RobotoMedium, 16))
        
    }
}


