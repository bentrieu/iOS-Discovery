//
//  AuthenticationView.swift
//  Assignment3
//
//  Created by Ben Trieu on 09/09/2023.
//

import SwiftUI

struct TempAuthenticationView: View {
    
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
