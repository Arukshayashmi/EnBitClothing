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
    
    @State var selectedCategoryId:Int = 0
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    
    @State var navigationTitle:String = "Home"
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            GeometryReader { geo in
                VStack {
                    NavigationBarWithRightButton(title: navigationTitle, imageName: "", isImage: true) {
                        //
                    }
                    
                    HStack (spacing: 16){
                        
                        //MARK: - SEARCH BAR
                        SearchBar(searchText: $vm.searchText, placeholder: "Start typing here", clearAction: {
                            getItemCards(minPrice: vm.minPrice, maxPrice: vm.maxPrice, categoryId: selectedCategoryId == 0 ? "" : String(selectedCategoryId), q: vm.searchText, page:1)
                        })
                        .onSubmit {
                            getItemCards(minPrice: vm.minPrice, maxPrice: vm.maxPrice, categoryId: selectedCategoryId == 0 ? "" : String(selectedCategoryId), q: vm.searchText, page:1)
                            print("search categoryId: \(selectedCategoryId)")
                            print("search q: \(vm.searchText)")
                        }
                        .submitLabel(.search)
                        
                        Button {
                            vm.isActiveFilterView = true
                        } label: {
                            Image("icon.filter")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 22)
                                .foregroundColor(Color.custom(._FFFFFF))
                                .padding(13)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .strokeBorder(Color.custom(._FFFFFF).opacity(0.29))
                                        .background(Color.custom(._FFFFFF).opacity(0.22))
                                        .frame(height: 48)
                                )
                                .cornerRadius(12)
                        }
                        
                    }// : HStack
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0){
                            
                            VStack(alignment: .leading){
                                Text("Discover Items")
                                    .font(.customFont(.RobotoMedium, 16))
                                    .padding(.top, 16)
                                    .padding(.leading, 9)
                                    .foregroundColor(Color.custom(._E2E2E2))
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack{
                                        CategoryButton(categoryName: "All", categoryId: 0, selectedCategoryId: $selectedCategoryId, action: {
                                            selectedCategoryId = 0
                                            print(selectedCategoryId)
                                            getItemCards(minPrice: vm.minPrice, maxPrice: vm.maxPrice, categoryId: "", q: vm.searchText, page:1)
                                        })
                                        
                                        ForEach(Array($vm.ItemCategories.enumerated()), id: \.offset) { index, $item in
                                            CategoryButton(categoryName: item.categoryName ?? "", categoryId: item._id ?? 0, selectedCategoryId: $selectedCategoryId, action: {
                                                selectedCategoryId = item._id ?? 0
                                                print(selectedCategoryId)
                                                getItemCards(minPrice: vm.minPrice, maxPrice: vm.maxPrice, categoryId: String(selectedCategoryId), q: vm.searchText, page:1)
                                            })
                                        }
                                    } // : HStack
                                    .padding(.bottom, 16)
                                } // : ScrollView
                            }//:HStack
                            
                            
                            if !vm.ItemCards.isEmpty {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2)) {
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
                                            paginationWithItemCards(itemCards: card)
                                        }
                                    }
                                }
                            } else {
                                //MARK: placeholder
                                VStack {
                                    Spacer()
                                    Text("No data found")
                                        .padding(.top, 120)
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
//                    .refreshable {
//                        getItemCardCategories()
//                        getItemCards(page: 1, isPaging: false)
//                    }
                } //: VStack
                .padding(.horizontal, 16)
                .foregroundColor(Color.custom(._FFFFFF))
                .onAppear{
                    
                    self.getItemCardCategories()
                    
                    //API Call for get clothItem cards
                    self.getItemCards(minPrice: vm.minPrice, maxPrice: vm.maxPrice, categoryId: selectedCategoryId == 0 ? "" : String(selectedCategoryId), page: 1)
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
//                NavigationLink(destination: FavouritesView(), isActive: $vm.favouritesAction, label: {})

                NavigationLink(destination: ItemDetailsView(vm: ItemDetailsVM(clothItem: vm.selectedItemCard)), isActive: $vm.isActiveDetailsView, label: {})
                NavigationLink(destination: HomeFiltersView(leftNavigationButton:changeNavigationButton(), selectedMinPrice: $vm.minPrice, selectedMaxPrice: $vm.maxPrice), isActive: $vm.isActiveFilterView, label: {})
            }
        )
    }
    
    //MARK: - PAGINATION
    func paginationWithItemCards(itemCards: Item){
        if itemCards._id == self.vm.ItemCards.last?._id{
            if vm.paginator?.currentPage ?? 0.0 < vm.paginator?.lastPage ?? 0.0{
                let nextPage = (vm.paginator?.currentPage ?? 1) + 1
                self.getItemCards(page: Int(nextPage), isPaging: true)
            }
        }
    }
    
    
    //MARK: - GET CATEGORIES
    func getItemCardCategories(){
        vm.performCategoryData()
    }
    
    
    
    func getItemCards(minPrice:String = "", maxPrice:String = "", categoryId:String = "", q:String = "", page:Int, perPage:Int = 10, isPaging:Bool = false){
        //MARK: - GET ITEM CARDS API CALL
        if navigationTitle == "Home" {
//            self.startLoading()
            vm.processWithItemCards(minPrice: minPrice, maxPrice: maxPrice, categoryId: categoryId, q: q, page: page, perPage: perPage, isPaging: isPaging) { success in
                self.stopLoading()
                if success{
                    showSuccessLogger(message: "clothItem card data get success !")
                }else{
                    showErrorLogger(message:  "clothItem card data get Error !")
                }
            }
        }
    }
    
    
    //MARK: - ADD OR REMOVE FAVORITE API CALL.
    func AddOrRemoveFavorites(itemId: Int, favStatus: Int){
//        self.startLoading()
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
    
    
    func changeNavigationButton() -> String{
        if navigationTitle == "Home"{
            return "xmark"
        } else {
            return "chevron.left"
        }
    }
    
}


#Preview {
    HomeView(hideTabBar: .constant(true))
}
