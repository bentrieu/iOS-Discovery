//
//  viewModiferHelper.swift
//  Assignment3
//
//  Created by Hữu Phước  on 11/09/2023.
//

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
