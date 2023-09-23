/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Le Minh Quan, Dinh Huu Gia Phuoc, Vu Gia An, Trieu Hoang Khang, Nguyen Tran Khang Duy
  ID: s3877969, s3878270, s3926888, s3878466, s3836280
  Created  date: 10/9/2023
  Last modified: 23/9/2023
  Acknowledgement:
https://rmit.instructure.com/courses/121597/pages/w9-whats-happening-this-week?module_item_id=5219569
https://rmit.instructure.com/courses/121597/pages/w10-whats-happening-this-week?module_item_id=5219571
*/


import SwiftUI
import FacebookCore

struct LandingPageView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel = AuthenticationViewModel()
    
    @Binding var showSignInView: Bool
   
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
                        Text("Free on Muwusic.")
                    }
                    .font(Font.custom("Gotham-Bold", size: 32))
                    .tracking(-3)
                    
                    
                    //MARK: Sign UP Free
                    NavigationLink {
                        SignUpView(showSignInView: $showSignInView)
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
                                showSignInView = false
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
                                showSignInView = false
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        CustomSignUpButton(image: Image("facebook-icon"), title: "Continue with Facebook")
                    }
                    
                    NavigationLink {
                        LoginView(showSignInView: $showSignInView)
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
        .onAppear {
            if let token = AccessToken.current, !token.isExpired {
                showSignInView = false
            }
        }
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView(showSignInView: .constant(false))
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

