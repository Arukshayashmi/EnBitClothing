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
                    
                case .addItem:
                    AddItemView()

                case .cart:
                    CartView(hideTabBar: $hideBar)

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
    case homeView, favourites, addItem, cart, more
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
                title: "Favourite"
            )
            .onTapGesture {
                vm.selectedTab = .favourites
            }
            Spacer()
            TabBarButton(
                item: .addItem,
                image: "icon.plus",
                title: "",
                isAddItem: true
            )
            .onTapGesture {
                vm.selectedTab = .addItem
            }
            Spacer()
            TabBarButton(
                item: .cart,
                image: "icon.cart",
                title: "My Cart"
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
        .background(Color.custom(._333333))
    }
}


private struct TabBarButton: View {
    @EnvironmentObject private var vm: TabBarVM
    @State var item: UserTabType
    var image: String
    var title: String
    var isAddItem: Bool = false
    
    var body: some View {
        if isAddItem == false {
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame( height: 28)
                Text(title)
                    .font(.customFont(.RobotoMedium, 10))
            }//:VStack
            .foregroundColor(vm.selectedTab == item ? .custom(._FFFFFF) : .custom(._FFFFFF).opacity(0.3))
        } else {
            Image(image)
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame( height: 28)
                .foregroundColor(vm.selectedTab == item ? .custom(._FFFFFF) : .custom(._FFFFFF).opacity(0.5))
                .background(Color.custom(._6347F3).frame(width: 50,height: 50).cornerRadius(14))
                .padding(.bottom, 10)
        }
    }
}


struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(vm: TabBarVM(selectedTab: .homeView))
    }
}
