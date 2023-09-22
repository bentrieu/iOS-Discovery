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

struct TempAuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    @StateObject private var loginManager = FacebookSignInHelper()
    
    var body: some View {
        VStack {
            
            //MARK: SIGN UP EMAIL
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
            //MARK: SIGN UP EMAIL
            
            //MARK: SIGN IN GOOGLE
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                        showSignInView = false
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            //MARK: SIGN IN GOOGLE
            
            //MARK: SIGN IN FACEBOOK
            Button {
                Task {
                    do {
                        let result = try await viewModel.signInFacebook()
                        if case .success = result {
                            showSignInView = false
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Sign up with Facebook")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            //MARK: SIGN IN FACEBOOK
            
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
