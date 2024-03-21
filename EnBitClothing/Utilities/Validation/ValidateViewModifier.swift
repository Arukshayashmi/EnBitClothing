//
//  File.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import SwiftUI

struct ValidateCheck: ViewModifier {
    
    var text: String
    var text2: String?
    var validation : (String, String?) -> ValidationStatus
    
    @State var active = false
    @State var latestValidation: ValidationStatus = .standard
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
                .onTapGesture {
                    active = true
                }
        }
    }
}


struct ValidateCheckPw: ViewModifier {
    
    var text: String
    var text2: String?
    var validation : (String, String?) -> ValidationStatus
    
    var active: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if active {
                switch validation(text, text2) {
                case .success:
                    
                    AnyView(EmptyView())
                    
                case .failure:
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 0.8)
                            .frame(height: 48)
                    }
                case .standard:
                    
                    AnyView(EmptyView())
                }
            }
        }
    }
}


struct ValidateOTP: ViewModifier {
    
    var valid: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            HStack( spacing: 0) {
                ForEach(0..<4) { _ in
                    if #available(iOS 15.0, *) {
                        ZStack {
                            Text("")
                        }
                        .frame(width: 56, height: 64)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(valid ? Color.clear : Color.red, lineWidth: 0.5)
                                .frame(width: 56, height: 64)
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            .padding(.bottom, 20)
            .padding(.top, 10)
        }
    }
}


extension View {
    func validateCheck(with text: String,  text2: String? = nil, validation: @escaping (String, String?) ->  ValidationStatus) -> some View {
        self.modifier(ValidateCheck(text: text, text2: text2, validation: validation))
    }
    func validateCheckPw(with text: String,  text2: String? = nil, validation: @escaping (String, String?) ->  ValidationStatus, active: Bool) -> some View {
        self.modifier(ValidateCheckPw(text: text, text2: text2, validation: validation, active: active))
    }
    
    func validateCheckOTP(valid: Bool) -> some View {
        modifier(ValidateOTP(valid: valid))
    }
}

enum ValidationStatus {
    case standard
    case success
    case failure(message: String)
    
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
}
