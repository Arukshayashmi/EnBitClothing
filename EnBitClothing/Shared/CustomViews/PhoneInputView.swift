//
//  PhoneInputView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import UIKit
import SwiftUI
import KDCountryPicker


struct PhoneInput: View {
    var title: String = "Phone Number"
    @Binding var code: String
    @Binding var number: String
    @State var showingModalView = false
    @State var selectedCountryModel: CountryModel =  CountryModel(isoCode: "AU", digitCode: "61")
    
    public  var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.custom("Roboto-Regular", size: 14))
                    .foregroundColor(Color.custom(._FFFFFF))
                    .padding(.bottom, 3)
                    .padding(.top, 16)
                
                HStack(alignment: .center, spacing: 10) {
                    HStack(alignment: .center, spacing: 8) {
                        if selectedCountryModel.country != nil {
                            HStack{
                                if code == "" {
                                    Text("\(selectedCountryModel.dialingCode ?? "N/A" )")
                                }
                                Text(code)
                            }
                        }
                        Spacer(minLength: 0)
                        Button {
                            showingModalView.toggle()
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color.custom(._FFFFFF))
                        }
                        .padding(.trailing, 13)
                    }//:HStack
                    .frame(width: 90, height: 40)
                    .modifier(customTFStyle(textFiled: $code, isTyping: Validators().isTypingText(value: code).isSuccess))
                    
                    TextField("", text: $number)
                        .placeholder(when: number.isEmpty) {
                            Text("Enter your phone number here")
                                .font(.custom("Roboto-Regular", size: 14))
                                .foregroundColor(Color.custom(._FFFFFF).opacity(0.5))
                        }
                        .font(.custom("Roboto-Regular", size: 14))
                        .modifier(customTFStyle(textFiled: $number, isTyping: Validators().isTypingText(value: number).isSuccess))
                        .keyboardType(.phonePad)
                }//:HStack
            }//:VStack
            
            //sheet View
            Text("")
                .sheet(isPresented: $showingModalView) {
                    VStack{
                        cancleHeader
                            .foregroundColor(Color.blue)
                        CountriesView(selectedCountryModel: selectedCountryModel,getSelectedModel:{ selectedCountry in
                            self.showingModalView.toggle()
                            selectedCountryModel = selectedCountry
                            code = selectedCountry.dialingCode ?? ""
                            print(code)
                        })
                        .foregroundColor(Color.black)
                    }
                }
        }//:ZStack
        .edgesIgnoringSafeArea(.all)
    }
    
    var cancleHeader: some View {
        HStack{
            Spacer()
            Button("Close") {
                self.showingModalView = false
            }
        }//:HStack
        .padding(.horizontal,20)
        .padding(.vertical,10)
    }
}

struct PhoneInput_Previews: PreviewProvider {
    static var previews: some View {
//        PhoneInput(code: .constant("+94"), number: .constant("711234567"))
        CompleteProfileView()
    }
}

