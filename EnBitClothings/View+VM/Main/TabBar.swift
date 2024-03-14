//
//  TabBar.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//

import SwiftUI

struct TabBarView: View {
    
    @StateObject var vm: TabBarVM
    @State var hideBar = false
    
    var body: some View {
            VStack {
                switch vm.selectedTab {
                case .homeView: 
                    HomeView(hideTabBar: $hideBar)

                case .favourites:
                    FavouritesView(hideTabBar: $hideBar)

                case .cart:
//                    CalendarView(hideTabBar: $hideBar)
                    AnyView(Text("cart"))

                case .more:
                    MoreMenuView(hideTabBar: $hideBar)

                }
            } //:VStack
            .foregroundColor(Color.custom(._FFFFFF))
            .overlay(
                // Custom Tab Bar..
                TabBar()
                    .offset(y: hideBar ? UIScreen.screenHeight : UIScreen.screenHeight * 0.46)
                
            )
            .environmentObject(vm)
            .navigationBarHidden(true)
    }
}


class TabBarVM: ObservableObject {
    @Published var selectedTab: UserTabType = .homeView
    
    init(selectedTab: UserTabType?) {
        self.selectedTab = selectedTab ?? .homeView
    }
}


enum UserTabType {
    case homeView, favourites, cart, more
}


private struct TabBar: View {
    @EnvironmentObject private var vm: TabBarVM
    
    var body: some View {
        
        HStack(spacing: 0) {
            // Tab Button...
            TabBarButton(
                item: .homeView,
                image: "icon.home",
                title: "Home"
            )
            .onTapGesture {
                vm.selectedTab = .homeView
            }
            .padding(.leading, 26)
            Spacer()
            TabBarButton(
                item: .favourites,
                image: "icon.heart",
                title: "Favourites"
            )
            .onTapGesture {
                vm.selectedTab = .favourites
            }
            Spacer()
            TabBarButton(
                item: .cart,
                image: "icon.cart",
                title: "Cart"
            )
            .onTapGesture {
                vm.selectedTab = .cart
            }
            Spacer()
            TabBarButton(
                item: .more,
                image: "icon.more",
                title: "More"
            )
            .onTapGesture {
                vm.selectedTab = .more
            }
            .padding(.trailing, 26)
            
        }
        .padding(.top, 4)
        .padding(.bottom, 38)
        //.padding(.horizontal, 22)
        .frame(width: UIScreen.screenWidth)
        .background(Color.custom(._1B1B24))
    }
}


private struct TabBarButton: View {
    @EnvironmentObject private var vm: TabBarVM
    @State var item: UserTabType
    var image: String
    var title: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame( height: 28)
            Text(title)
                .font(.customFont(.RobotoMedium, 10))
        }//:VStack
        .foregroundColor(vm.selectedTab == item ? .custom(._FFFFFF) : .custom(._FFFFFF).opacity(0.40))
    }
}


struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(vm: TabBarVM(selectedTab: .homeView))
    }
}