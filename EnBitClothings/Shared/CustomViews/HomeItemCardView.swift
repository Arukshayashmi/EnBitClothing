//
//  HomeItemCardView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct HomeItemCardView:View {
    @State var itemCard : Item?
    @State var isFav:Bool = false
    let viewAction: (() -> ())?
    var addToFavAction: (() -> ())?
    var removeFromFavAction: (() -> ())?

    var body: some View{
        VStack(alignment: .leading){
            HStack(){
                Text("LKR \(formatNumber(number: itemCard?.price ?? 0))")
                    .font(.customFont(.RobotoBold, 16))
                    .bold()
                    .foregroundColor(Color.custom(._E9E9E9))
                    .padding(.leading, 8.5)
                    .padding(.top, 15)
                    .padding(.bottom, 7)
                
                Spacer()
                
                Button {
                    if isFav == false {
                        isFav = true
                        addToFavAction?()
                    } else {
                        isFav = false
                        removeFromFavAction?()
                    }
                    
                } label: {
                    Image(isFav ? "icon.heart" : "icon.heartBorder")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.custom(._6347F3))
                        .frame(height: 22)
                        .padding(.trailing, 12)
                        .padding(.top, 12)
                        .padding(.bottom, 3)
                }
            } // : HStack
            
            if (itemCard?.imageUrl) != "" {
                WebImage(url: URL(string: itemCard?.imageUrl ?? ""))
                    .resizable()
//                    .scaledToFit()
                    .cornerRadius(8)
                    .padding(.horizontal, 8)
                    .frame(height: 120)
//                    .padding(.bottom, 7)
            } else {
                Image("Cloth_Placeholder")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 22)
                    .padding(.bottom, 7)
                    .opacity(0.5)
                    .foregroundColor(.white)

            }
            
            
            if itemCard?.categoryId == "0" {
                Text("All")
                    .font(.customFont(.RobotoMedium, 12))
                    .foregroundColor(Color.custom(._B4B4B4))
                    .padding(.leading, 8)
            } else if itemCard?.categoryId == "1"  {
                Text("Kids")
                    .font(.customFont(.RobotoMedium, 12))
                    .foregroundColor(Color.custom(._B4B4B4))
                    .padding(.leading, 8)
            } else if itemCard?.categoryId == "2"  {
                Text("Ladies")
                    .font(.customFont(.RobotoMedium, 12))
                    .foregroundColor(Color.custom(._B4B4B4))
                    .padding(.leading, 8)
            } else if itemCard?.categoryId == "3"  {
                Text("Gents")
                    .font(.customFont(.RobotoMedium, 12))
                    .foregroundColor(Color.custom(._B4B4B4))
                    .padding(.leading, 8)
            } else {
                Text("Other")
                    .font(.customFont(.RobotoMedium, 12))
                    .foregroundColor(Color.custom(._B4B4B4))
                    .padding(.leading, 8)
            }

            
            Text(itemCard?.itemTitle ?? "")
                .font(.customFont(.RobotoMedium, 14))
                .padding(.leading, 8)
                .padding(.trailing, 11)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .padding(.top, 1)
                .padding(.bottom, 10)
        } // : VStack
        .background(Color.custom(._FFFFFF).opacity(0.13))
        .cornerRadius(14)
        .frame(height: 234)
        .padding(.bottom, 5)
        .shadow(color: Color.custom(._F9F9F9),radius: 9, x: 0, y: 3)
        .onTapGesture {
            viewAction?()
        }
        
    }
}

#Preview {
    HomeView(hideTabBar: .constant(false))
}
