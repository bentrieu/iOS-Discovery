import SwiftUI

struct SplashScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var showSignInView: Bool = false

    var body: some View {
        if isActive{
            if !showSignInView {
                MainView()
            } else {
                LandingPageView(showSignInView: $showSignInView)
            }
        }else{
            ZStack {
                Color("white")
                VStack{
                    Image("icon-green")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation {
                        self.size = 0.9
                        self.opacity = 1
                    }
                }
            }
            .onAppear{
                let authUser = try? AuthenticationManager.instance.getAuthenticatedUser()
                self.showSignInView = authUser == nil
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
          
    }
}
