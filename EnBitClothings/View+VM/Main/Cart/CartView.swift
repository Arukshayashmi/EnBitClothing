//
//  CartView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI
import Combine

struct CartView: View {
    @State var sheetVisible:CGFloat = UIScreen.screenHeight * 1.1
    @StateObject var vm = CartVM()
    @Binding var hideTabBar: Bool
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            ZStack {
                VStack {
                    NavigationBarWithBackButton(title: "Cart")
                    ScrollView(showsIndicators: false) {
                            VStack(spacing: 10) {
                                if !vm.cartItems.isEmpty{
                                ForEach(vm.cartItems, id: \._id){item in
                                    AddItemCard(cart: item, ItemCount: vm.cartItemCount) {
                                        // Cart remove action
                                        vm.selectedCartItem = item
                                    }
                                }
                            }
                                else {
                                    Text("No data found.")
                                        .font(.customFont(.RobotoMedium, 14))
                                }

                            if !vm.cartItems.isEmpty {
                                CommenButton(buttonTitle: "Pay", buttonWidth: 219, isFilled:true) {
                                    withAnimation(.easeIn(duration: 0.3)){
                                        sheetVisible = UIScreen.screenHeight * 0.63
                                    }
                                }
//                                .padding(.top, UIScreen.screenHeight * 0.4)
                                .padding(.top,16)
                                .padding(.bottom,32)
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
                    vm.performCartData()
                }
                
            } //: ZStack
            .overlay{
                sheetVisible == UIScreen.screenHeight * 0.5 ? Color.custom(._00000040).ignoresSafeArea() : Color.clear.ignoresSafeArea()
                ZStack {
                    PaymentSheet(cardNumber: $vm.cardNumber, expirationDate: $vm.expirationDate, cvv: $vm.cvv, isCheckedSaveCard: vm.isCheckedSaveCard, sheetHeight: 900, actionClose: {
                        withAnimation(.easeIn(duration: 0.3)){
                            sheetVisible = UIScreen.screenHeight * 1.1
                        }
                    }, actionPay: {
                        navigateToPayment()
                    })
                    .padding(.bottom, 24)
                .offset(y: sheetVisible)
                } // : ZStack
            }
            
        } // : ZStack
        .navigationBarHidden(true)
        
    }
    func navigateToPayment(){
        if !vm.checkTextFields(){
            vm.isPaymentViewActive = true
        }
    }
    
}

#Preview {
    CartView(hideTabBar: .constant(true))
}
