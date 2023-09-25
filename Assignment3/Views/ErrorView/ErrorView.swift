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

struct ErrorView: View {
    var errorMessage: String // Error message to display
    var body: some View {
        
        VStack {
            Text(errorMessage) // Display the error message
                .font(Font.custom("Gotham-Bold", size: 12)) // Apply bold font style
                .foregroundColor(Color.black) // Set text color to white
                .multilineTextAlignment(.center)
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

