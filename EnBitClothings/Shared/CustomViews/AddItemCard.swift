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
            if cart?.images?.first?.url != "" {
                WebImage(url: URL(string: cart?.images?.first?.url ?? ""))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100,height: 100)
                    .padding(12)

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
                    .foregroundColor(Color.custom(._B4B4B4))
                    .frame(width: 100,height: 20,alignment: .leading)

                HStack {
                    Text("LKR\(cart?.price ?? 0).00")
                        .font(.customFont(.RobotoMedium, 16))
                        .padding(.top, 24)
                        .padding(.bottom, 12)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
            } // : Vstack
            
            
        } // : HStack
        .background(Color.custom(._FFFFFF).opacity(0.13))
        .cornerRadius(10)
        .border(Color.black)
    }
    
}

//#Preview {
//    
//    AddItemCard(cart: Dummy.ItemData.first, ItemCount: 2) {
//        
//    }
//    
//}

