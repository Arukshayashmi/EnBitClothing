//
//  UIApplication+Extension.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }
}


extension Date {
    //MARK: - DATE TO STRING FUNCTION
    func convertDateToString(_ outputFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = outputFormat
        return formatter.string(from: self)
    }
}
