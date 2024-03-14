//
//  BaseView.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation
import SwiftUI
import RappleProgressHUD


extension View {
    // Start loading
    func startLoading() {
        RappleActivityIndicatorView.startAnimating()
    }
    
    // Start loading with text
    func startLoadingWithText(label: String) {
        RappleActivityIndicatorView.startAnimatingWithLabel(label)
    }
    
    // Stop loading
    func stopLoading() {
        RappleActivityIndicatorView.stopAnimation()
    }
    
    func startLoadingWithProgress(current: CGFloat, total:CGFloat) {
        RappleActivityIndicatorView.setProgress(current/total)
    }

}


extension View {
    func showErrorLogger(message:String){
        Logger.log(logType: LogType.error, message: message)
    }
    
    func showSuccessLogger(message:String){
        Logger.log(logType: LogType.success, message: message)
    }
    
    func showInfoLogger(message:String){
        Logger.log(logType: LogType.info, message: message)
    }
}


//MARK: - KEYBOARD DISSMISS, ADD 'DONE' BUTTON TO KEYBOARD AND AUTO PAGE SCROLLING WHILE POPUP KEYBOARD

extension View {
    func withBaseViewMod() -> some View {
        modifier(BaseViewModifier())
    }
}

struct BaseViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            Color.clear
                .ignoresSafeArea()
            
            content
        }//:ZStack
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                keyboardTopToolbar()
            }
        }
        .navigationBarHidden(true)
    }
    
    func keyboardTopToolbar() -> some View {
        Button(action: {
            UIApplication.shared.endEditing()
        }, label: {
            Text("Done")
                .font(.system(size: 16))
        })
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

//keyboard dissmiss
extension View {
     func dismissingKeyboard() {
        UIApplication.shared.endEditing()
    }
}


//MARK: - NUMBER FORMATTER FOR PRICE
//number formatter for price
func formatNumber(number: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2

    return formatter.string(from: NSNumber(value: number)) ?? ""
}


//MARK: - CONVERT STRINGS TO CLOSED_RANGE
func convertToClosedRange(_ string1: String, _ string2: String) -> ClosedRange<Float>? {
    if let value1 = Float(string1), let value2 = Float(string2) {
        return ClosedRange(uncheckedBounds: (lower: min(value1, value2), upper: max(value1, value2)))
    }
    return nil
}
