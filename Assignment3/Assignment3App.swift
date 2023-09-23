//
//  Assignment3App.swift
//  Assignment3
//
//  Created by Ben Trieu on 09/09/2023.
//

import SwiftUI
import Firebase
import FacebookCore

@main
struct Assignment3App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) var scenePhase
    @StateObject var musicManager = MusicManager.instance
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .onChange(of: scenePhase) { newValue in
                    if newValue == .inactive{
                        musicManager.stopTimer()
                        musicManager.player?.pause()
                        musicManager.isPlaying = false
                    }
                }
                
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        FirebaseApp.configure()
        
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        let handled: Bool = ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        return handled
    }
}
