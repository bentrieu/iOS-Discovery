import SwiftUI



struct ContentView: View {
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            // Your content here
            
            if isLoading {
             
            }
        }
        .onAppear {
            // Simulate loading for a few seconds (remove this in your actual code)
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
