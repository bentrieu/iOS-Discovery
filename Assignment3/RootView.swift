//
//  RootView.swift
//  Assignment3
//
//  Created by Ben Trieu on 10/09/2023.
//

import SwiftUI

struct RootView: View {
  
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            if !showSignInView {
                NavigationStack {
                    TempProfileView(usernameText: "", showSignInView: $showSignInView)
                }
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.instance.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack{
                TempAuthenticationView(showSignInView: $showSignInView)
            }
        }
       
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
