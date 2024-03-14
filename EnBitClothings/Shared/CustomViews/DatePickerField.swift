//
//  DatePickerField.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import Foundation
import SwiftUI

struct DatePickerField: View {
    
    @Binding var dateOfBirth: Date
    @State var showCalander: Bool = false
    @State var textDate = ""
    @State var titleText = ""
    @Binding var textFieldName: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(titleText)
                .font(.customFont(.RobotoRegular, 14))
                .foregroundColor(Color.custom(._FFFFFF))
                .padding(.bottom, 6)
            HStack(spacing:0) {
                //TextField("", text: $textDate)
                TextField("",text: $textDate,prompt: Text((textFieldName))
                    .font(.customFont(.RobotoRegular, 14))
                    .foregroundColor(Color.custom(._FFFFFF))
                )
                    .disabled(true)
//                    .placeholder(when: textDate.isEmpty) {
//                        Text("YYYY/MM/DD")
//                            .font(.customFont(.RobotoRegular, 14))
//                            .foregroundColor(Color.custom(._FFFFFF).opacity(0.5))
//                    }
                Spacer()
                Image("icon.calendarMonth")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.custom(._FFFFFF))
                    .frame(height: 24)
                    .overlay{
                        DatePicker("", selection: $dateOfBirth, in: ...Date(), displayedComponents: [.date])
                            .blendMode(.destinationOver)
                            .onChange(of: dateOfBirth, perform: { value in
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "dd-MM-yyyy"
                                textDate = dateFormatter.string(from: value)
                            })
                            .onTapGesture(count: 99, perform: {
                                // overrides tap gesture to fix ios 17.2 bug
                            })
                            .font(.customFont(.RobotoRegular, 14))

                    }
            } //: HStack
            .padding()
            .autocorrectionDisabled()
            .autocapitalization(.none)
            .frame(height: 48)
            .foregroundColor(Color.custom(._FFFFFF))
            .background(Color.custom(._FFFFFF).opacity(0.13))
            .cornerRadius(10)
            
        } //: VStack
    }
}
