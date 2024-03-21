//
//  ViewRouter.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//


import SwiftUI
import Combine
import CoreData

enum Roots {
    case initialScreen
    case signUp
    case signUpVerify
    case completeProfile
    case signIn
    case userTabs
    case moreMenu
}


public let Authenticated = PassthroughSubject<Bool, Never>()

public func IsAuthenticated() -> Bool {
    return PersistenceController.shared.loadUserData() != nil
}

public func EmailVerifiedAt() -> Bool {
    return PersistenceController.shared.loadUserData()?.emailVerifyAt != nil
}

public func IsProfileCompleted() -> Bool {
    return PersistenceController.shared.loadUserData()?.firstName != nil
}


class ViewRouter: ObservableObject {
    
    @Published var currentRoot: Roots =  .initialScreen
    
    static let shared = ViewRouter()
    
    fileprivate init() {
        
        if IsAuthenticated() {
            if EmailVerifiedAt() {
                if IsProfileCompleted(){
                    currentRoot = .userTabs
                }else{
                    currentRoot = .completeProfile
                }
            } else {
                currentRoot = .signUpVerify
            }
        } else {
            currentRoot = .initialScreen
        }
    }
    
}


struct RootView: View {
    
    @EnvironmentObject var router: ViewRouter
    @State var isAnimated = false
    
    var isNotificationCome:Bool = false
    
    var body: some View {
        
        NavigationView {
            Group {
                containedView(roots: router.currentRoot)
                    .id(UUID().uuidString)
                    .transition(.slide).animation(.linear(duration: 0.2), value: isAnimated)
                    .onAppear() {
                        DispatchQueue.main.async {
                            isAnimated = true
                        }
                    }
            }//:Group
            
        }//:NavigationView
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func containedView(roots: Roots) -> AnyView {
        switch router.currentRoot {
            
        case .initialScreen:
            return AnyView(InitialScreenView())
            
        case .signUp:
            return AnyView(SignUpView())
            
        case .signUpVerify:
            return AnyView(VerificationView(vm: VerificationVM(email: "")))
            
        case .userTabs:
            return AnyView(TabBarView(vm: TabBarVM(selectedTab: .homeView)))
            
        case .moreMenu:
            return AnyView(MoreMenuView(hideTabBar: .constant(true)))

        case .signIn:
            return AnyView(SignInView())
            
        case .completeProfile:
            return AnyView(CompleteProfileView())
        }
    }
}

