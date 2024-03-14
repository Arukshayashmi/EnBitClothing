//
//  FavouritesView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//



import SwiftUI

struct FavouritesView: View {
    @StateObject var vm = FavouritesVM()
    @State var page:Int = 1
    @Binding var hideTabBar: Bool
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            GeometryReader { geo in
                VStack {
                    // Navigation section
                    NavigationBarWithBackButton(title: "Favourites")
                    
                    VStack{
                        if !vm.ItemCards.isEmpty {
                            ScrollView(showsIndicators: false) {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)) {
                                    
                                    ForEach(Array(vm.ItemCards.enumerated()), id: \.offset) { index, card in
                                        HomeItemCardView(itemCard: card, isFav: card.isFavourite ?? false, viewAction: {
                                            vm.selectedItemCard = card
                                            vm.isActiveDetailsView = true
                                        }, addToFavAction: {
                                                AddOrRemoveFavorites(itemId:card._id ?? 0, favStatus: 1)
                                        }, removeFromFavAction: {
                                            AddOrRemoveFavorites(itemId: card._id ?? 0, favStatus: 0)
                                        })
                                        .onAppear {
                                            paginationWithFavItemCards(itemCards: card)
                                        }
                                    }
                                }
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
                        } else {
                            //MARK: placeholder
                            VStack {
                                Spacer()
                                Text("No data found")
                                Spacer()
                            }//:VStack
                        }
                    } //: VStack
                    .padding(.top, 10)
                } //: VStack
                .padding(.horizontal, 16)
                .foregroundColor(Color.custom(._FFFFFF))
                
                .onAppear{
                    //API Call for get favourite clothItem cards
                    self.getFavouriteItemCards(page: page)
                    vm.performProfileListData()
                }
            } //: Geometry
        } //: ZStack
        .navigationBarHidden(true)
        .background(
            Group {
                NavigationLink(destination: ItemDetailsView(vm: ItemDetailsVM(clothItem: vm.selectedItemCard)), isActive: $vm.isActiveDetailsView, label: {})
            }
        )
    }
    
    //MARK: - PAGINATION
    func paginationWithFavItemCards(itemCards: Item){
        if itemCards._id == self.vm.ItemCards.last?._id{
            if vm.paginator?.currentPage ?? 0.0 < vm.paginator?.lastPage ?? 0.0{
                let nextPage = (vm.paginator?.currentPage ?? 1) + 1
                self.getFavouriteItemCards(page: Int(nextPage), isPaging: true)
            }
        }
    }
    
    
    //MARK: - GET ITEM CARDS API CALL
    func getFavouriteItemCards(page:Int, perPage:Int = 10, isPaging:Bool = false){
//        self.startLoading()
        vm.processWithAllFavoriteItem(page: page, perPage: perPage, isPaging: isPaging) { success in
            self.stopLoading()
            if success{
                showSuccessLogger(message: "favourite item cards data get success !")
            }else{
                showErrorLogger(message:  "favourite item cards data get Error !")
            }
        }
    }
    
    
    //MARK: - ADD OR REMOVE FAVORITE API CALL.
    func AddOrRemoveFavorites(itemId: Int, favStatus: Int){
        self.startLoading()
        vm.processWithFavoriteItems(itemId: itemId, favStatus: favStatus) { success in
            getFavouriteItemCards(page: 1)
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
    FavouritesView(hideTabBar: .constant(true))
}
