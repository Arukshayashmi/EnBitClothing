//
//  CustomTFStyle.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import SwiftUI


struct customTFStyle: ViewModifier {
    @Binding var textFiled: String
    
    @State var isShowing: Bool = false
    @State var isValidationRuntime :Bool = true
    var isTyping :Bool
    
//    @Binding var text: String
    var validator: ((String, String?) -> ValidationStatus) = {_,_ in ValidationStatus.success}
    
    func body(content: Content) -> some View {
        content
            .autocorrectionDisabled()
            .autocapitalization(.none)
            .padding(.leading, 16)
            .frame(height: 48)
            .font(.custom("Roboto-Regular", size: 14))
            .foregroundColor(Color.white)
            .background(Color.custom(._FFFFFF).opacity(0.13))
            .cornerRadius(10)
    }
    
}



struct customTFStyle_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
