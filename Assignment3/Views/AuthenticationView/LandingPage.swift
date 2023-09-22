//
//  LandingPageView.swift
//  Assignment3
//
//  Created by Hữu Phước  on 11/09/2023.
//

import SwiftUI

struct LandingPageView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel = AuthenticationViewModel()
   
    var body: some View {
        NavigationStack {
            ZStack{
                //MARK: DEFINE BACK GROUND COLOR
                Color("white")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20){
                    Spacer()
                    
                    Image(colorScheme == .dark ? "icon-white" : "icon-black")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    VStack(spacing: 0){
                        Text("Milions of songs.")
                        Text("Free on Spotify.")
                    }
                    .font(Font.custom("Gotham-Bold", size: 32))
                    .tracking(-3)
                    
                    
                    //MARK: Sign UP Free
                    NavigationLink {
                        SignUpView()
                            .navigationTitle("Create account")
                            .foregroundColor(Color("black"))
                            .modifier(CustomNavigationButton())
                    } label: {
                        ButtonWithBackGroundGreenView(title: "Sign up free")
                    }

                    
                    //MARK: SIGN UP WITH GOOGLE
                    
                    Button {
                        Task {
                            do {
                                try await viewModel.signInGoogle()
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        CustomSignUpButton(image: Image("google-icon"), title: "Continue with Google")
                    }
                    
                    //MARK: SIGN UP WITH FACEBOOK
                    Button {
                        Task {
                            do {
                                try await viewModel.signInFacebook()
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        CustomSignUpButton(image: Image("facebook-icon"), title: "Continue with Facebook")
                    }
                    
//                    //MARK: SIGN UP WITH APPLE
//                    Button {
//
//                    } label: {
//                        CustomSignUpButton(image: colorScheme == .dark ? Image(systemName: "apple.logo") : Image("apple-icon"), title: "Continue with Apple")
//                    }
//
//                    //MARK: SIGN UP WITH APPLE
                    
                    NavigationLink {
                        LoginView()
                            .navigationTitle("Login")
                            .foregroundColor(Color("black"))
                            .modifier(CustomNavigationButton())
                    } label: {
                        Text("Login")
                            .modifier(CustomButtonAthentication())
  
                    }
                    
                    Spacer()
                }
            }
           
            .foregroundColor(Color("black"))
        .preferredColorScheme(colorScheme)
        }
        
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}


struct ButtonWithBackGroundGreenView: View {
    var title : String
    var body: some View {
        Text(title)
            .modifier(CustomButtonAthentication())
            .background(Color("green"))
            .clipShape(Capsule())
    }
}

struct CustomSignUpButton: View {
    var image : Image
    var title : String
    var body: some View {
        Text(title)
            .modifier(CustomButtonAthentication())
            .background{
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("black"))
            }
            .overlay{
                HStack{
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .padding(.leading)
                    Spacer()
                }
            }
    }
}

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
           Image(systemName: "chevron.left")
                .foregroundColor(Color("black"))
        }
    }
}

