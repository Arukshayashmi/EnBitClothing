//
//  AddItemCard.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//

import SwiftUI
import SDWebImageSwiftUI

struct AddItemCard:View {
    
    var cart:Product?
    @State var ItemCount:Int
    let action: ()->()?
    
    var body: some View{
        HStack{
            if cart?.images?.url != "" {
                WebImage(url: URL(string: cart?.images?.url ?? ""))
                    .resizable()
//                    .scaledToFit()
                    .cornerRadius(8)
                    .padding(.horizontal, 8)
                    .frame(height: 100)
                    .padding(.vertical, 8)

            } else {
                Image("Cloth_Placeholder")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100,height: 100)
                    .padding(12)
                    .opacity(0.5)
                    .foregroundColor(.white)
            }
            VStack(alignment:.leading, spacing:0){
                HStack {
                    Text(cart?.name ?? "")
                        .font(.customFont(.RobotoMedium, 14))
                    .lineLimit(1)
                    .padding(.trailing, 39)
                    .frame(maxWidth:.infinity,alignment: .leading)
                    
                    Button {
                        action()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .padding(.trailing,16)

                }
                Text("\(cart?.category?.category ?? "N/A")")
                    .font(.customFont(.RobotoMedium, 12))
                    .foregroundColor(Color.custom(._E9E9E9))
                    .frame(width: 100,height: 20,alignment: .leading)

                HStack {
                    Text("LKR \(formatNumber(number: Double(cart?.price ?? 0)))")
                        .font(.customFont(.RobotoMedium, 16))
                        .padding(.top, 24)
                        .padding(.bottom, 12)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
            } // : Vstack
            
            
        } // : HStack
        .background(Color.custom(._FFFFFF).opacity(0.2))
        .cornerRadius(10)
        .shadow(color: Color.custom(._F9F9F9),radius: 9, x: 0, y: 3)
    }
    
}

//#Preview {
//    
//    AddItemCard(cart: Dummy.ItemData.first, ItemCount: 2) {
//        
//    }
//    
//}

