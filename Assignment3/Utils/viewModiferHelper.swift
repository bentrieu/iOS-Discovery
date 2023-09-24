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


import Foundation
import SwiftUI


// Define a custom ViewModifier
struct CustomButtonAthentication: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Gotham-Bold", size: 16))
            .frame(width: 340, height: 50)
    }
}
struct CustomeButtonEditPictureView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Gotham-Medium", size: 14))
            .frame(width: 50, height: 40)
            .padding(.horizontal)
            .padding(.horizontal)
    }
}

struct AvatarView: ViewModifier {
    var size : CGFloat
    
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width:size, height: size)
            .clipShape(Circle())
    }
}


struct PlayListImageModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .modifier(Img())
            .frame(width: UIScreen.main.bounds.width/1.7,height:UIScreen.main.bounds.width/1.7)
            .clipped()
            .overlay(
                Rectangle()
                    .stroke(.gray, lineWidth: 4)
            )
    }
}

struct CustomNavigationButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: BackButton())
    }
}

struct BlackColor: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("black"))
    }
}

struct Icon: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .modifier(BlackColor())
    }
}

struct Shadow: ViewModifier{
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("black") ,radius: 1)
    }
}

struct Img: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .modifier(Shadow())
    }
}

struct OneLineText: ViewModifier{
    func body(content: Content) -> some View {
        content
            .modifier(BlackColor())
            .lineLimit(1)
    }
}

struct PagePadding: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, UIScreen.main.bounds.width/15)
            .padding(.vertical)
    }
}
