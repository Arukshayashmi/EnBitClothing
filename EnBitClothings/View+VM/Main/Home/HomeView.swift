//
//  HomeView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeVM()
    @Binding var hideTabBar: Bool
    
    @State var selectedCategoryId:String = ""
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    
    @State var navigationTitle:String = "Home"
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            GeometryReader { geo in
                VStack {
                    NavigationBarWithRightButton(title: navigationTitle, imageName: "", isImage: true) {}
                    
                    HStack (spacing: 16){
                        
                        //MARK: - SEARCH BAR
                        SearchBar(searchText: $vm.searchText, placeholder: "Start typing here", clearAction: {
                            getItemCards(categoryId: selectedCategoryId == "" ? "" : String(selectedCategoryId), q: vm.searchText)
                        })
                        .onSubmit {
                            getItemCards(categoryId: selectedCategoryId == "" ? "" : String(selectedCategoryId), q: vm.searchText)
                            print("search categoryId: \(selectedCategoryId)")
                            print("search q: \(vm.searchText)")
                        }
                        .submitLabel(.search)
                        
                    }// : HStack
                    
                    VStack(alignment: .leading){
                        Text("Discover Items")
                            .font(.customFont(.RobotoMedium, 16))
                            .padding(.top, 16)
                            .padding(.leading, 9)
                            .foregroundColor(Color.custom(._E2E2E2))
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                CategoryButton(categoryName: "All", categoryId: "", selectedCategoryId: $selectedCategoryId, action: {
                                    selectedCategoryId = ""
                                    print(selectedCategoryId)
                                    getItemCards(categoryId: "", q: vm.searchText)
                                })
                                
                                ForEach(Array($vm.ItemCategories.enumerated()), id: \.offset) { index, $item in
                                    CategoryButton(categoryName: item.category ?? "", categoryId: item.id ?? "", selectedCategoryId: $selectedCategoryId, action: {
                                        selectedCategoryId = item.id ?? ""
                                        print(selectedCategoryId)
                                        getItemCards(categoryId: String(selectedCategoryId), q: vm.searchText)
                                    })
                                }
                            } // : HStack
                            .padding(.bottom, 16)
                        } // : ScrollView
                    }//:VStack
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0){
                            if !vm.ItemCards.isEmpty {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2)) {
                                    
                                    
                                    ForEach(Array(vm.ItemCards.enumerated()), id: \.offset) { index, card in
                                        HomeItemCardView(itemCard: card, isFav: card.isFavourite ?? false, viewAction: {
                                            vm.selectedItemCard = card
                                            vm.isActiveDetailsView = true
                                        }, addToFavAction: {
                                            AddOrRemoveFavorites(itemId:card.id ?? "", favStatus: 1)
                                        }, removeFromFavAction: {
                                            AddOrRemoveFavorites(itemId: card.id ?? "", favStatus: 0)
                                        })
                                    }
                                    
                                    
                                }
                            } else {
                                //MARK: placeholder
                                VStack {
                                    Spacer()
                                    Text("No data found")
                                        .padding(.top, UIScreen.screenHeight * 0.3)
                                    Spacer()
                                }//:VStack
                            }
                        } // : VStack
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
                    } //: Scroll view
                    .refreshable {
                        getCategories()
                        getItemCards()
                    }
                } //: VStack
                .padding(.horizontal, 16)
                .foregroundColor(Color.custom(._FFFFFF))
                .onAppear{
                    self.getCategories()
                    
                    //API Call for get clothItem cards
                    self.getItemCards( categoryId: selectedCategoryId == "" ? "" : String(selectedCategoryId))
                    print(" count \(vm.ItemCards.count)")
                }
                .onChange(of: ViewRouter.shared.currentRoot) { _ in
                    //
                }
            } //: Geometry
        } //: ZStack
        .navigationBarHidden(true)
        .withBaseViewMod()
        
        .background(
            Group {
                NavigationLink(destination: ItemDetailsView(vm: ItemDetailsVM(clothItem: vm.selectedItemCard)), isActive: $vm.isActiveDetailsView, label: {})
            }
        )
    }
    
    
    //MARK: - GET CATEGORIES API CALL
    func getCategories(){
        vm.processWithCategories() { success, _ in
            if success{
                showSuccessLogger(message: "category data get success !")
            }else{
                showErrorLogger(message:  "category data get Error !")
            }
        }
    }
    
    
    
    func getItemCards(categoryId:String = "", q:String = ""){
        //MARK: - GET ITEM CARDS API CALL
        self.startLoading()
        
        if iBSUserDefaults.guest == false {
            vm.processWithItemCards(categoryId: categoryId, q: q) { success, _  in
                self.stopLoading()
                if success{
                    showSuccessLogger(message: "clothItem card data get success !")
                }else{
                    showErrorLogger(message:  "clothItem card data get Error !")
                }
            }
        } else {
            vm.processWithGestUser(categoryId: categoryId, q: q) { success, _  in
                self.stopLoading()
                if success{
                    showSuccessLogger(message: "guest user clothItem card data get success !")
                }else{
                    showErrorLogger(message:  "guest user clothItem card data get Error !")
                }
            }
        }
        
    }
    
    
    //MARK: - ADD OR REMOVE FAVORITE API CALL.
    func AddOrRemoveFavorites(itemId: String, favStatus: Int){
        self.startLoading()
        vm.processWithFavoriteItems(itemId: itemId, favStatus: favStatus) { success, _ in
            if success{
                if favStatus == 1{
                    showSuccessLogger(message: "add to favorites success !")
                } else {
                    showSuccessLogger(message: "remove from favorites success !")
                }
                getItemCards()
            } else {
                showErrorLogger(message:  "favorites function Error !")
            }
        }
    }
    
}


#Preview {
    HomeView(hideTabBar: .constant(true))
}
