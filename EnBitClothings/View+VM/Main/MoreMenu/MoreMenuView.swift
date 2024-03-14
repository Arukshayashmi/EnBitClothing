//
//  MoreMenuView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//



import SwiftUI

struct MoreMenuView: View {
    
    @StateObject var vm = MoreMenuVM()
    @Binding var hideTabBar: Bool
    
    @State var selectedCategoryId:Int = 0
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack {
                ScrollView {
                    VStack{
                        Text("More")
                            .foregroundColor(Color.custom(._FFFFFF))
                            .padding(.bottom, 15)
                        VStack(spacing: 16){
                            ForEach(vm.moreMenuButtons){item in
                                Button {
                                    vm.destinationAction = true
                                    vm.destination = item.destination
                                } label: {
                                    HStack {
                                        Image(item.buttonImageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 20)
                                            .padding(.horizontal, 19)
                                            .padding(.vertical, 15)
                                            .foregroundColor(Color.custom(._FFFFFF))
                                        Text(item.buttonTitle)
                                            .foregroundColor(Color.custom(._FFFFFF))
                                            .font(.custom("Roboto-Medium", size: 14))
                                            .padding(.vertical, 15)
                                        Spacer()
                                    }// HStack
                                    .frame(height: 48)
                                        .background(Color.custom(._FFFFFF).opacity(0.13))
                                    .cornerRadius(14)
                                }

                            }
                        } //: VStack
                        .padding(.bottom, 48)
                        .padding(.top, 16)
                        Button {
                            logoutAPiCall()
                        } label: {
                            HStack {
                                Image("icon.logout")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 18)
                                    .padding(.horizontal, 19)
                                    .padding(.vertical, 15)
                                    .foregroundColor(Color.custom(._F34770))
                                Text("Logout")
                                    .foregroundColor(Color.custom(._FFFFFF))
                                    .font(.custom("Roboto-Medium", size: 14))
                                    .padding(.vertical, 15)
                                Spacer()
                            }// HStack
                            .frame(height: 48)
                                .background(Color.custom(._FFFFFF).opacity(0.13))
                            .cornerRadius(14)
                            .padding(.bottom, 42)
                                
                        }
                        .padding(.top,180)
                        
                        
                    } // VStack
                    .padding(.horizontal, 16)
                    .overlay(
                        //: Need for auto hiding TabBar
                        GeometryReader{proxy -> Color in
                            
                            let minY = proxy.frame(in: .global).minY
                            let durationOffset: CGFloat = 35
                            
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
                    
                } // Scroll View
            } // VStack
        .foregroundColor(Color.custom(._FFFFFF))
        .alert(isPresented: $vm.isShowAlert) {
            Alert(
                    title: Text(vm.alertTitle),
                    message: Text(vm.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
        }
        .background(
            Group {
                NavigationLink(destination: vm.destination,isActive: $vm.destinationAction, label: {})
            }
        )
        
        } // ZStack
        .navigationBarHidden(true)
    }
    
    func logoutAPiCall(){
        //MARK: - LOGOUT API CALL
//        self.startLoading()
        vm.proceedLogoutAPi { status in
            self.stopLoading()
            print(" ❌ User Logout success ! ❌ ")
        }
        
        //MARK: - CLEAN LOACL USER
        PersistenceController.shared.deleteUserData()
//        SwaggerClientAPI.customHeaders.removeValue(forKey: "x-access-token")
        ViewRouter.shared.currentRoot = .initialScreen
        Authenticated.send(false)
    }
    
}

#Preview {
    MoreMenuView(hideTabBar: .constant(true))
}
