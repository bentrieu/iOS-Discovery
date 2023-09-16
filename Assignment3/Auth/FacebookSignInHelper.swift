//
//  FacebookSignInHelper.swift
//  Assignment3
//
//  Created by Ben Trieu on 16/09/2023.
//

import Foundation
import SwiftUI
import FacebookLogin
import FacebookCore
import Firebase

struct FacebookLoginButton: UIViewRepresentable {
    func makeUIView(context: Context) -> FBLoginButton {
        let loginButton = FBLoginButton()
        
        // Set the delegate to handle login results
        loginButton.delegate = context.coordinator
        
        return loginButton
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: Context) {
        // You can further configure the FBLoginButton or handle updates here
    }
    
    // Coordinator to handle delegate methods
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, LoginButtonDelegate {
        var parent: FacebookLoginButton
        
        init(_ parent: FacebookLoginButton) {
            self.parent = parent
        }
        
        // Implement delegate methods to handle login events
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if let error = error {
                // Handle login error
                print("Login error: \(error.localizedDescription)")
            } else if let result = result, !result.isCancelled {
                // Handle successful login
                Task {
                    do {
                        try await AuthenticationManager.instance.signInWithFacebook(token: AccessToken.current!.tokenString)
                        print("Logged in with Facebook")
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            // Handle logout event
            print("Logged out from Facebook")
        }
    }
}