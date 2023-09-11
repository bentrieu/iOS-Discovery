//
//  LandingPageView.swift
//  Assignment3
//
//  Created by Hữu Phước  on 11/09/2023.
//

import SwiftUI

struct LandingPageView: View {
    @Environment(\.colorScheme) var colorScheme
   
    var body: some View {
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
                
                
                Button {
                    
                } label: {
                    SignUpButtonView()
                }
                
                
                //MARK: SIGN UP WITH GOOGLE
                
                Button {
                    
                } label: {
                    CustomSignUpButton(image: Image("google-icon"), title: "Continue with Google")
                }
                
                //MARK: SIGN UP WITH FACEBOOK
                Button {
                    
                } label: {
                    CustomSignUpButton(image: Image("facebook-icon"), title: "Continue with Facebook")
                }
                
                //MARK: SIGN UP WITH APPLE
                Button {
                    
                } label: {
                    CustomSignUpButton(image: colorScheme == .dark ? Image(systemName: "apple.logo") : Image("apple-icon"), title: "Continue with Apple")
                }
                
                //MARK: SIGN UP WITH APPLE
                Button {
                    
                } label: {
                    Text("Login")
                        .modifier(CustomButtonAthentication())
                }
                
            }
           
        }
       
        .foregroundColor(Color("black"))
        .preferredColorScheme(colorScheme)
        
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}


struct SignUpButtonView: View {
    var body: some View {
        Text("Sign up free")
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
