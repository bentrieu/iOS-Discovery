import SwiftUI

struct ErrorView: View {
    var errorMessage: String // Error message to display
    var body: some View {
        
        VStack {
            Text(errorMessage) // Display the error message
                .bold() // Apply bold font style
                .foregroundColor(Color.white) // Set text color to white
                .padding(.all) // Add padding
                .padding(.horizontal) // Add horizontal padding
                .background(Color("black").opacity(0.8)) // Set background color
                .clipShape(RoundedRectangle(cornerRadius: 10)) // Clip the view into a rounded rectangle
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: "hjhj") // Preview with a sample error message
    }
}

