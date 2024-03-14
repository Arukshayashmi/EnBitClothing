//
//  EnBitClothingsApp.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import SwiftUI

@main
struct EnBitClothingsApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(ViewRouter.shared)
        }
    }
}
