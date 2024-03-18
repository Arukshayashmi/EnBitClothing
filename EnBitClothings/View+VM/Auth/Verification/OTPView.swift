//
//  OTPView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import SwiftUI
import Combine

struct OTPView: View {
    var slotCount: Int
    @Binding var otpText: String
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(0..<slotCount, id: \.self) { index in
                ZStack {
                    if otpText.count > index {
                        let startIndex = otpText.startIndex
                        let charIndex = otpText.index(startIndex, offsetBy: index)
                        let charToSting = String(otpText[charIndex])
                        Text(charToSting)
                            .foregroundColor(Color.white)
                    } else {
                        
                        Text("")
                    }
                }
                .frame(width: 48, height: 56)
                .background {
                    let status = (isKeyboardShowing && otpText.count == index)
                    ZStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 5).fill(Color.custom(._FFFFFF).opacity(0.13))
                            
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(status ? Color.custom(._FFFFFF).opacity(0.13) : Color.custom(._FFFFFF).opacity(0.13), lineWidth: 0.5)
                        }
                    }
                }
                .frame(maxWidth: 68)
            }
        }
        .background(
            TextField("", text: $otpText.limit(4))
                .opacity(0.001)
                .frame(width: 2, height: 2)
                .focused($isKeyboardShowing)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
        )
        //.contentShape(Rectangle())
        .onTapGesture {
            isKeyboardShowing.toggle()
        }
        .padding(.bottom, 30)
        .padding(.top, 26)
    }
    
}



extension Binding where Value == String {
    func limit(_ length: Int) -> Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length ))
            }
        }
        return self
    }
}
