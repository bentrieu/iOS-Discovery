//
//  AuthenticationView.swift
//  Assignment3
//
//  Created by Ben Trieu on 09/09/2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        guard let topVC = UIApplication.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken: String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken: String = gidSignInResult.user.accessToken.tokenString

        try await AuthenticationManager.instance.signInWithGoogle(idToken: idToken, accessToken: accessToken)
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
            Spacer()
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
