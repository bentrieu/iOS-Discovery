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

//struct FacebookLoginButton: UIViewRepresentable {
//    
//    @Binding var showSignInView: Bool
//    
//    func makeUIView(context: Context) -> FBLoginButton {
//        let loginButton = FBLoginButton()
//
//        // Set the delegate to handle login results
//        loginButton.permissions = ["public_profile","email"]
//        loginButton.setTitleColor(.blue, for: .normal)
//        loginButton.delegate = context.coordinator
//
//        return loginButton
//    }
//
//    func updateUIView(_ uiView: FBLoginButton, context: Context) {
//        // You can further configure the FBLoginButton or handle updates here
//    }
//
//    // Coordinator to handle delegate methods
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, LoginButtonDelegate {
//        var parent: FacebookLoginButton
//
//        init(_ parent: FacebookLoginButton) {
//            self.parent = parent
//        }
//
//        // Implement delegate methods to handle login events
//        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//            if let error = error {
//                // Handle login error
//                print("Login error: \(error.localizedDescription)")
//            } else if let result = result, !result.isCancelled {
//                // Handle successful login
//                Task {
//                    do {
//                        let authDataResult = try await AuthenticationManager.instance.signInWithFacebook(token: AccessToken.current!.tokenString)
//                        let user = DBUser(auth: authDataResult)
//                        try await UserManager.instance.createNewUser(user: user)
//                        print("Logged in with Facebook")
//                        parent.showSignInView = false
//                    } catch {
//                        print(error)
//                    }
//                }
//            }
//        }
//
//        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//            // Handle logout event
//            Task {
//                do {
//                    try AuthenticationManager.instance.signOut()
//                    print("Logged out from Facebook")
//                } catch {
//                    print(error)
//                }
//            }
//        }
//    }
//}

final class FacebookSignInHelper: ObservableObject {
    private let loginManager = LoginManager()
    
    func loginFacebook() async throws -> FacebookLoginResult {
        return await withCheckedContinuation { continuation in
            loginManager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
                if let error = error {
                    continuation.resume(returning: .error(error))
                } else if let result = result, !result.isCancelled {
                    Task {
                        do {
                            let authDataResult = try await AuthenticationManager.instance.signInWithFacebook(token: AccessToken.current!.tokenString)
                            let user = DBUser(auth: authDataResult)
                            try await UserManager.instance.createNewUser(user: user)
                            print("Logged in with Facebook")
                            continuation.resume(returning: .success(authDataResult)) // Success
                        } catch {
                            print(error)
                            continuation.resume(returning: .error(error)) // Error
                        }
                    }
                } else {
                    continuation.resume(returning: .cancelled) // Cancelled
                }
            }
        }
    }

    enum FacebookLoginResult {
        case success(AuthDataResultModel)
        case error(Error)
        case cancelled
    }
}
