//
//  CartView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//

import SwiftUI

struct CartView: View {
    @State var sheetVisible:Bool = false
    @StateObject var vm = CartVM()
    @Binding var hideTabBar: Bool
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @State var defaultCardIndex:Int = 100
    
    @State var navigationTitle:String = "Cart"
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack {
                NavigationBarWithRightButton(title: navigationTitle, imageName: "", isImage: true) {}
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        if !vm.cartItems.isEmpty{
                            ForEach(Array(vm.cartItems.enumerated()), id: \.offset) { index, item in
                                Button {
                                    defaultCardIndex = index
                                    if defaultCardIndex == index{
                                        vm.selectedCartItem = item
                                        print(vm.selectedCartItem?.id ?? "")
                                    }
                                    
                                } label: {
                                    HStack{
                                        Image(systemName: defaultCardIndex == index ? "checkmark.circle" : "circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 24)
                                        
                                        AddItemCard(cart: item.productDetails , ItemCount: vm.cartItemCount) {
                                            // Cart remove action
                                            vm.selectedCartItem = item
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            Spacer()
                            Text("No data found.")
                                .padding(.top, UIScreen.screenHeight * 0.3)
                            Spacer()
                        }
                        
                        if !vm.cartItems.isEmpty {
                            CommenButton(buttonTitle: "Pay", buttonWidth: 219, isFilled:true) {
                                withAnimation(.easeIn(duration: 0.3)){
                                    sheetVisible = true
                                }
                            }
                            .padding(.top,16)
                            .padding(.bottom,32)
                            .sheet(isPresented: $sheetVisible) {
                                CustomCardSelectView(action: {
                                    // api call
                                })
                                .background(Color.custom(._1B1A2B))
                                .presentationDetents([.medium, .large])
                            }
                        }
                        
                    } // : VStack
                    .padding(.top, 16)
                    .overlay(
                        //: Need for auto hiding TabBar
                        GeometryReader{proxy -> Color in
                            
                            let minY = proxy.frame(in: .global).minY
                            let durationOffset: CGFloat = 30
                            
                            DispatchQueue.main.async {
                                if minY < offset {
                                    if offset < 0 && -minY > (lastOffset + durationOffset) {
                                        withAnimation(.easeOut(duration: 1.5)){
                                            hideTabBar = true
                                        }
                                        lastOffset = -offset
                                    }
                                } else if minY > offset && -minY < (lastOffset - durationOffset) {
                                    withAnimation(.easeIn(duration: 1)){
                                        hideTabBar = false
                                    }
                                    lastOffset = -offset
                                }
                                self.offset = minY
                            }
                            return Color.clear
                        }
                    )
                    
                } //: Scroll View
            } //: VStack
            .padding(.horizontal, 16)
            .foregroundColor(Color.custom(._FFFFFF))
            .background(
                Group(content: {
                    NavigationLink(destination: PaymentMethodsView(),isActive: $vm.isPaymentViewActive, label: {})
                })
            )
            .onAppear{
                getAllCartItems()
            }
            
        } // : ZStack
        .navigationBarHidden(true)
        
    }
    func getAllCartItems(){
        //MARK: - GET ITEM CARDS API CALL
            self.startLoading()
            vm.processWithCart() { success, _  in
                self.stopLoading()
                if success{
                    showSuccessLogger(message: "cart data get success !")
                }else{
                    showErrorLogger(message:  "cart data get Error !")
                }
            }
    }
    
}

#Preview {
    CartView(hideTabBar: .constant(true))
}

// MARK: - CUSTOM TOPICS SELECTION
private struct CustomCardSelectView: View {
    @State var defaultCardIndex:Int = 100
    @State var savedCardNumbers:[String] = []
    @State var defaultCardNumber:String = ""
    let action: ()->()?
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Recommended Method(s)")
                .font(.customFont(.RobotoMedium, 14))
                .padding(.bottom, 14)
                .padding(.trailing, UIScreen.screenWidth * 0.47)
            
            ScrollView(showsIndicators: false) {
                ForEach(Array(savedCardNumbers.enumerated()), id: \.offset) { index, card in
                    Button {
                        defaultCardIndex = index
                        if defaultCardIndex == index{
                            defaultCardNumber = savedCardNumbers[index]
                            print(defaultCardNumber)
                        }
                        
                    } label: {
                        HStack{
                            Image(systemName: defaultCardIndex == index ? "checkmark.circle" : "circle")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                            SavedCardView(creditCardNumber: savedCardNumbers[index])
                        }
                        .padding(.bottom, 16)
                        .padding(.leading, 8)
                    }
                    
                }//:ForEach
                Spacer()
            }
            Spacer()
            CommenButton(buttonTitle: "Pay now", buttonWidth: 219, isFilled: true) {
                action()
            }
            .padding(.top, 32)
        }//:VStack
        .background(Color.clear)
        .padding(.top, 16)
        .padding()
        .onAppear {
            let cards = PersistenceController.shared.loadCardData() ?? []
            
            for card in cards {
                savedCardNumbers.append(card.cardNumber ?? "")
            }
        }
        
        
    }
}
