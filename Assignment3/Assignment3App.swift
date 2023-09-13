//
//  Assignment3App.swift
//  Assignment3
//
//  Created by Ben Trieu on 09/09/2023.
//

import SwiftUI
import Firebase

@main
struct Assignment3App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
//            RootView()
            SplashScreenView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
