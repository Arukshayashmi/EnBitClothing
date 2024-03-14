//
//  HomeFiltersView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI

struct HomeFiltersView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var vm = HomeFiltersVM()
    @State var isTapClearAll:Bool = false
    var leftNavigationButton:String
    @Binding var selectedMinPrice:String
    @Binding var selectedMaxPrice:String
    
    var body: some View {
        ZStack{
            Color.custom(._1B1A2B)
                .ignoresSafeArea()
            VStack {
                VStack (alignment: .leading, spacing: 0){
                    NavigationBarWithBothButton(title: "Filters", buttonRightImage: Image(systemName: ""), buttonLeftImage: Image(systemName: leftNavigationButton), buttonText: "Clear All") {
                        clearAll()
                    }
                    
                    SliderView(sectionHeader: "Price Range (LKR)", sliderPosition: vm.sliderPositionPrice, selectedMinPrice: $selectedMinPrice, selectedMaxPrice: $selectedMaxPrice, isTapClearAll: $isTapClearAll)
                        .padding(.bottom,8)
                        .padding(.top, 16)
                    
                    Spacer()
                    
                } // : VStack
                CommenButton(buttonTitle: "Filter Results", buttonWidth: 220, isFilled: true) {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.bottom, 58)
                
            } // : VStack
            .padding(.horizontal, 16)
            .foregroundColor(Color.custom(._FFFFFF))
        }
        .navigationBarHidden(true)
    }
    
    private func clearAll(){
        self.isTapClearAll.toggle()
        presentationMode.wrappedValue.dismiss()
    }
    
}

#Preview {
    HomeFiltersView(leftNavigationButton: "xmark", selectedMinPrice: .constant("1"), selectedMaxPrice: .constant("10"))
}

