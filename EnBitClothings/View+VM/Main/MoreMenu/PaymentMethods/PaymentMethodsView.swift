//
//  PaymentMethodsView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI

struct PaymentMethodsView: View {
    @StateObject var vm = PaymentMethodsVM()
    @State var defaultCardIndex:Int = 100
    @State var sheetVisible:CGFloat = UIScreen.screenHeight * 1.1
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            ZStack {
                ScrollView (showsIndicators: false){
                    VStack{
                        NavigationBarWithBackButton(title: "Payments")
                            .padding(.bottom, 16)
                            .padding(.horizontal, 16)
                        VStack(alignment:.leading, spacing: 0){
                            Text("Recommended Method(s)")
                                .font(.customFont(.RobotoMedium, 14))
                                .padding(.bottom, 14)
                                .padding(.trailing, UIScreen.screenWidth * 0.47)
                            ForEach(0..<vm.savedCardNumbers.count){index in
                                Button {
                                    defaultCardIndex = index
                                    if defaultCardIndex == index{
                                        vm.defaultCardNumber = vm.savedCardNumbers[index]
                                        print(vm.defaultCardNumber)
                                    }
                                    
                                } label: {
                                    HStack{
                                        Image(systemName: defaultCardIndex == index ? "checkmark.circle" : "circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 24)
                                        SavedCardView(creditCardNumber: vm.savedCardNumbers[index])
                                    }
                                    .padding(.bottom, 16)
                                    .padding(.leading, 8)
                                }

                            }
                            
                            Text("Add Card(s)")
                                .font(.customFont(.RobotoMedium, 14))
                                .padding(.top, 16)
                                .padding(.bottom, 18)
                            Button {
                                withAnimation(.easeIn(duration: 0.3)){
                                    sheetVisible = UIScreen.screenHeight * 0.35
                                }
                            } label: {
                                HStack(spacing: 0){
                                    Text("Credit/Debit Card")
                                        .font(.customFont(.RobotoRegular, 14))
                                        .padding(.vertical, 12)
                                        .padding(.leading, 12)
                                    Spacer()
                                    HStack(spacing: 8){
                                        Image("Visa")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 20)
                                        Image("AmericanExpress")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 20)
                                        Image("MasterCard")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 20)
                                    } // : HStack
                                    .padding(.trailing, 32)
                                    .padding(.vertical, 12)
                                } // : HStack
                                .background(Color.custom(._FFFFFF).opacity(0.13))
                                .cornerRadius(10)
                            }
                        } // : VStack
                        .padding(.horizontal, 16)
                        CommenButton(buttonTitle: "Add Card", buttonWidth: 219, isFilled: true) {
                            checkCardSelected()
                        }
                        .padding(.top, 32)
                        
                        
                    } // : VStack
                   // .padding(.hor)
                    .foregroundColor(Color.custom(._FFFFFF))
                } // : ScrollView
            } // : ZStack
            .overlay{
                sheetVisible == 350 ? Color.custom(._00000040).ignoresSafeArea() : Color.clear.ignoresSafeArea()
            }
            ZStack {
                PaymentSheet(cardNumber: $vm.cardNumber, expirationDate: $vm.expirationDate, cvv: $vm.cvv, sheetHeight: 350, actionClose: {
                withAnimation(.easeIn(duration: 0.5)){
                    sheetVisible = 850
                }
            }, actionAdd: {
                // todo
            })
            .padding(.bottom, 24)
            .offset(y: sheetVisible)}
            
        } // : ZStack
        .navigationBarHidden(true)
    }
    private func checkCardSelected(){
        withAnimation(.easeIn(duration: 0.3)){
            sheetVisible = UIScreen.screenHeight * 0.35
        }
    }
    
}

struct PaymentMethodsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodsView()
    }
}
