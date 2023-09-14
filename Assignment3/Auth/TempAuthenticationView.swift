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

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.instance.signInWithGoogle(tokens: tokens)
    }
}

struct FacebookLoginButton: UIViewRepresentable {
    func updateUIView(_ uiView: FBSDKLoginKit.FBLoginButton, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> FBLoginButton {
        return FBLoginButton()
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
