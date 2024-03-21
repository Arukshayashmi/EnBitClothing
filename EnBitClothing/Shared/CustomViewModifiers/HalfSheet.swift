//
//  HalfSheet.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import SwiftUI

struct HalfSheet<content: View>: ViewModifier {
    @Binding var isPresented: Bool
    let content: () -> content

    func body(content: Content) -> some View {
        ZStack {
            content
               
            if isPresented {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPresented = false
                    }

                VStack {
                    Spacer()
                    self.content()
                }
                .transition(.move(edge: .bottom))
                .animation(.easeIn(duration: 0.4))
            }
        }//:ZStack
    }
}

extension View {
    func halfSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.modifier(HalfSheet(isPresented: isPresented, content: content))
    }
}
