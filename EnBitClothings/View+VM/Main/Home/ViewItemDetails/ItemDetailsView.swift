//
//  ItemDetailsView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI
import SDWebImageSwiftUI

struct ItemDetailsView: View {
    @State var isFav:Bool = false
    @StateObject var vm :ItemDetailsVM
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            
            VStack(alignment:.leading){
                NavigationBarWithBackButton(title: vm.clothItem?.itemTitle ?? "")
                    .padding(.bottom, 20)
                
                    VStack(alignment:.leading, spacing: 0){
                        // for multiple image set
//                        ZStack {
//                            TabView(selection : $vm.currentPage){
//                                ForEach(0..<vm.imageNames.count){ i in
//                                    Image(vm.imageNames[i])
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width:343, height: 294)
//                                        .foregroundColor(Color.custom(._FFFFFF).opacity(0.5))
//                                }
//                            }
//                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                            .frame(height: 294)
//                            HStack(spacing:10){
//                                ForEach(vm.imageNames.indices, id: \.self) {index in
//                                    Circle()
//                                        .foregroundColor(Color.custom(._FFFFFF))
//                                        .opacity(index == vm.currentPage ? 1 : 0.3)
//                                        .frame(height: 10)
//                                }
//                            }// : HStack
//                            .padding(.top, 268)
//                            .padding(.bottom, 18)
//                        } // : ZStack
                        
                        WebImage(url: URL(string: vm.clothItem?.imageUrl ?? ""))
                            .placeholder {
                                Image("GiftPlaceHolder")
                                    .resizable()
                                    .frame(height: 294)
                                    .cornerRadius(14)
                                    .foregroundColor(Color.custom(._FFFFFF).opacity(0.5))
                            }
                            .resizable()
//                            .scaledToFit()
                            .frame(height: 294)
                            .cornerRadius(14)
                            .foregroundColor(Color.custom(._FFFFFF).opacity(0.5))
                        
//                        Text(vm.clothItem?.category?.categoryName ?? "")
//                            .font(.customFont(.RobotoMedium, 14))
//                            .foregroundColor(Color.custom(._FFFFFF).opacity(0.5)).padding(.leading, 16)
//                            .padding(.top, 16)
//                            .padding(.bottom, 4)
                        Text(vm.clothItem?.itemTitle ?? "")
                            .font(.customFont(.RobotoMedium, 16))
                            .padding(.horizontal, 16)
                        Text("A$ \(formatNumber(number: vm.clothItem?.price ?? 0))")
                            .padding(.leading, 16)
                            .padding(.bottom, 13)
                        HStack {
                            CommenButton(buttonTitle: "Item This Item", buttonWidth: 271, isFilled: true) {
                                vm.isActiveGenerateItemCardView = true
                            }
                            .padding(.leading, 16)
                            
                            Button {
                                if isFav == false {
                                    isFav = true
                                    AddOrRemoveFavorites(itemId: vm.clothItem?._id ?? 0, favStatus: 1)
                                } else {
                                    isFav = false
                                    AddOrRemoveFavorites(itemId: vm.clothItem?._id ?? 0, favStatus: 0)
                                }
                                
                            } label: {
                                Image(isFav ? "icon.heart" : "icon.heartBorder")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.custom(._6347F3))
                                    .frame(height: 22)
                                    .padding(.trailing, 12)
                                    .padding(.top, 6)
                                    .padding(.bottom, 3)
                            }
                            .padding(.leading, 16)
                        } // : HStack
                        .padding(.bottom, 16)
                    } // : VStack Item detail card
                    .frame(height: 450)
                    .background(Color.custom(._FFFFFF).opacity(0.13))
                    .cornerRadius(14)
                    
                ScrollView(showsIndicators: false) {
                    VStack (alignment:.leading){
                        Text("Description")
                            .font(.customFont(.RobotoMedium, 14))
                            .padding(.bottom, 16)
                        Text(vm.clothItem?._description ?? "")
                            .font(.customFont(.RobotoRegular, 12))
                            .padding(.bottom, 10)
                            .foregroundColor(Color.custom(._B4B4B4))
                    } // : VStack
                    .padding(.top, 16)
                } // : Scroll view
                
            } // : VStack
            .foregroundColor(Color.custom(._FFFFFF))
            .padding(.horizontal, 16)
            .onAppear {
                self.isFav = vm.clothItem?.isFavourite ?? false
            }
        } // : ZStack
        .navigationBarHidden(true)
//        .background(
//            Group {
//                NavigationLink(destination: GenerateGiftCardView(vm: GenerateGiftCardVM(clothItem: vm.clothItem)),isActive: $vm.isActiveGenerateGiftCardView, label: {})
//            }
//        )
    }
    
    //MARK: - ADD OR REMOVE FAVORITE API CALL.
    func AddOrRemoveFavorites(itemId: Int, favStatus: Int){
        self.startLoading()
        vm.processWithFavoriteItems(itemId: itemId, favStatus: favStatus) { success in
            self.stopLoading()
            if success{
                if favStatus == 1{
                    showSuccessLogger(message: "add to favorites success !")
                } else {
                    showSuccessLogger(message: "remove from favorites success !")
                }
            } else {
                showErrorLogger(message:  "favorites function Error !")
            }
        }
    }
    
}

#Preview {
    ItemDetailsView(vm: ItemDetailsVM(clothItem: Item?.none))
}
