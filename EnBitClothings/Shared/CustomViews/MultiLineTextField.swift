//
//  MultiLineTextField.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import SwiftUI

struct MultiLineInputTextField: View {
    @Binding var text: String
    var placeHolder:String = "placeholder"
    var sectionHeader:String = "Section Header"
    
    var body: some View {
        VStack(alignment:.leading) {
            Text(sectionHeader)
                .font(.customFont(.RobotoRegular, 14))
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeHolder)                        
                        .foregroundColor(.gray)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 12)
                }
                
                TextView(text: $text)
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                    .background(Color.custom(._FFFFFF).opacity(0.13))
                    .frame(height: 100)
                    .cornerRadius(10)
                    .withBaseViewMod()
            }
        }
        .foregroundColor(Color.custom(._FFFFFF))
        .background(Color.custom(._1B1A2B))
        
    }
}

struct MultiLineInputTextField_Previews: PreviewProvider {
    static var previews: some View {
        MultiLineInputTextField(text: .constant(""))
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.white
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}





















