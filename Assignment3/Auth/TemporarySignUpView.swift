////
////  TemporarySignInView.swift
////  Assignment3
////
////  Created by Ben Trieu on 09/09/2023.
////
//
//import SwiftUI
//
//struct TemporarySignUpView: View {
//    
//    @StateObject private var viewModel = SignUpEmailViewModel()
//    @Binding var showSignInView: Bool
//    
//    var body: some View {
//        VStack {
//            TextField("Email...", text: $viewModel.email)
//                .padding()
//                .background(Color.gray.opacity(0.4))
//                .cornerRadius(10)
//            
//            SecureField("Password...", text: $viewModel.password)
//                .padding()
//                .background(Color.gray.opacity(0.4))
//                .cornerRadius(10)
//            
//            Button {
//                Task {
//                    do {
//                        try await viewModel.signUp()
//                        showSignInView = false
//                        return
//                    } catch {
//                        print("\(error)")
//                    }
//                    
//                    do {
//                        try await viewModel.signIn()
//                        showSignInView = false
//                        return
//                    } catch {
//                        print("\(error)")
//                    }
//                }
//            } label: {
//                Text("Sign Up")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(height: 55)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            Spacer()
//        }
//        .padding()
//        .navigationTitle("Sign up with email")
//    }
//}
//
//struct TemporarySignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            TemporarySignUpView(showSignInView: .constant(false))
//        }
//    }
//}
