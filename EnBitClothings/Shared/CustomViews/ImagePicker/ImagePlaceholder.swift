//
//  ImagePlaceholder.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import SwiftUI
import SDWebImageSwiftUI
import SDWebImage


struct ImagePlaceholder: View {
    let urlString: String?
    var size = CGSize(width: 100, height: 100)
    var cornerRadius: CGFloat = 8
    var isSendItemView: Bool
    @State var isLoading = false
    
    var body: some View {
        
        if isSendItemView == false {
            //MARK: - SQUARE IMAGE
            WebImage(url: URL(string: urlString ?? ""))
                .placeholder {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 64)
                        .padding(18)
                        .foregroundColor(Color.custom(._272643))
                        .background(Color.custom(._6347F3).frame(width: 100,height: 100).cornerRadius(14))
                        .overlay(progress)
                }
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(width: size.width, height: size.height)
                .cornerRadius(cornerRadius)
        } else {
            //MARK: - SEND ITEM IMAGE
            WebImage(url: URL(string: urlString ?? ""))
                .placeholder {
                    Image("")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(.horizontal, 169)
                        .padding(.vertical, 42)
                        .foregroundColor(Color.custom(._FFFFFF).opacity(0.75))
                        .overlay(progress)
                }
                .resizable()
                .indicator(.activity)
                .aspectRatio(contentMode: .fill)
                .shadow(radius: 0.5)
        }
    }
    
    
    var progress: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            isLoading = false
                        }
                    }//:onApper
            }
        }//:ZStack
    }
    
}





