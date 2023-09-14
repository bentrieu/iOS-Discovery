//
//  AuthenticationView.swift
//  Assignment3
//
//  Created by Ben Trieu on 09/09/2023.
//

import SwiftUI
//remove googlesignin later when build a custom button
import GoogleSignIn
import GoogleSignInSwift
import FacebookLogin
import FacebookCore
import Firebase

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.instance.signInWithGoogle(tokens: tokens)
    }
}

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
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                Task {
                    do {
                        try await AuthenticationManager.instance.signIn(credential: credential)
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

struct TempAuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            NavigationLink {
                TemporarySignUpView(showSignInView: $showSignInView)
            } label: {
                Text("Sign up with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            }
            FacebookLoginButton()
                .frame(height: 40)
            Spacer()
        }
        .onAppear {
            if let token = AccessToken.current, !token.isExpired {
                print(token)
                showSignInView = false
            }
        }
        .padding()
        .navigationTitle("Sign up")
    }
}

struct TempAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TempAuthenticationView(showSignInView: .constant(false))
        }
    }
}
