//
//  Slider.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-14.
//


import SwiftUI

struct SliderView: View {
    var sectionHeader:String = "sectionHeader"
    @State var sliderPosition: ClosedRange<Float>
    @State var bounds: ClosedRange<Int> = 0...2000
    @Binding var selectedMinPrice:String
    @Binding var selectedMaxPrice:String
    @Binding var isTapClearAll:Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Text(sectionHeader)
                .font(.customFont(.RobotoRegular, 14))
                .padding(.top, 12)
                .padding(.horizontal, 16)

            RangedSliderView(value: $sliderPosition, bounds: bounds)
            .padding(.horizontal, 46)
            .padding(.top, 35)
            .onChange(of: sliderPosition) { value in
                selectedMinPrice = String(value.lowerBound)
                selectedMaxPrice = String(value.upperBound)
            }
            .onChange(of: isTapClearAll, perform: { newValue in
                sliderPosition = 10...1000
            })
            .onAppear{
                sliderPosition = convertToClosedRange(selectedMinPrice, selectedMaxPrice) ?? 10...1000
            }
        } // : VStack
        .padding(.bottom, 12)
        .frame(height: 110)
        .background(Color.custom(._FFFFFF).opacity(0.13))
        .cornerRadius(10)
        
    }
}



