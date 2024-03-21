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
                NavigationBarWithBackButton(title: vm.clothItem?.name ?? "")
                    .padding(.bottom, 20)
                
                    VStack(alignment:.leading, spacing: 0){                        
                        WebImage(url: URL(string: vm.clothItem?.images?.url ?? ""))
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
                        
                        Text(vm.clothItem?.category?.category ?? "")
                            .font(.customFont(.RobotoMedium, 12))
                            .foregroundColor(Color.custom(._E9E9E9))
                            .padding(.leading, 16)
                            .padding(.top, 5)
                        
                        Text(vm.clothItem?.name ?? "")
                            .font(.customFont(.RobotoMedium, 16))
                            .padding(.horizontal, 16)
                        Text("LKR \(formatNumber(number: Double(vm.clothItem?.price ?? 0)))")
                            .padding(.leading, 16)
                            .padding(.bottom, 13)
                        
                        if iBSUserDefaults.guest == false {
                            HStack {
                                CommenButton(buttonTitle: "Add to cart", buttonWidth: 271, isFilled: true) {
                                    AddToCart(itemId: vm.clothItem?.id ?? "")
                                }
                                .padding(.leading, 16)
                                
                                Button {
                                    if isFav == false {
                                        isFav = true
                                        AddOrRemoveFavorites(itemId: vm.clothItem?.id ?? "", favStatus: 1)
                                    } else {
                                        isFav = false
                                        AddOrRemoveFavorites(itemId: vm.clothItem?.id ?? "", favStatus: 0)
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
                        }
                        
                    } // : VStack Item detail card
//                    .frame(height: 450)
                    .background(Color.custom(._FFFFFF).opacity(0.2))
                    .cornerRadius(14)
                    
                ScrollView(showsIndicators: false) {
                    VStack (alignment:.leading){
                        Text("Description")
                            .font(.customFont(.RobotoMedium, 14))
                            .padding(.bottom, 16)
                        Text(vm.clothItem?.description ?? "")
                            .font(.customFont(.RobotoRegular, 12))
                            .padding(.bottom, 10)
                            .foregroundColor(Color.custom(._E9E9E9))
                    } // : VStack
                    .padding(.top, 16)
                } // : Scroll view
                
            } // : VStack
            .foregroundColor(Color.custom(._FFFFFF))
            .padding(.horizontal, 16)
            .onAppear {
                self.isFav = vm.clothItem?.isFavourite ?? false
            }
            .alert(isPresented: $vm.isShowAlert) {
                Alert(
                    title: Text(vm.alertTitle),
                    message: Text(vm.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        } // : ZStack
        .navigationBarHidden(true)
    }
    
    //MARK: - ADD TO CART API CALL.
    func AddToCart(itemId: String){
        self.startLoading()
        vm.processWithAddToCartItems(itemId: itemId) { success, _ in
            self.stopLoading()
            if success{
                showSuccessLogger(message: "add to cart success !")
            } else {
                showErrorLogger(message:  "add to cart function Error !")
            }
        }
    }
    
    //MARK: - ADD OR REMOVE FAVORITE API CALL.
    func AddOrRemoveFavorites(itemId: String, favStatus: Int){
        self.startLoading()
        vm.processWithFavoriteItems(itemId: itemId, favStatus: favStatus) { success, _ in
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
    ItemDetailsView(vm: ItemDetailsVM(clothItem: Product?.none))
}