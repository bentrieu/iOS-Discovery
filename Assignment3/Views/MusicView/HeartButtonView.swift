//
//  HeartButtonView.swift
//  Assignment3
//
//  Created by DuyNguyen on 11/09/2023.
//

import SwiftUI

struct HeartButtonView: View {
    @Binding var active: Bool
    var startAnimation: Bool
    var animationScale : CGFloat{
        active ? 1.3 : 0.7
    }
    
    var body: some View {
        Image(systemName: active ? "heart.fill" : "heart")
            .resizable()
            .scaledToFit()
            .foregroundColor(active ? .accentColor : Color("black"))
            .frame(height: 30)
            .scaleEffect(startAnimation ? animationScale : 1)
            .animation(.easeInOut(duration: 0.2), value: startAnimation)
        
        
    }
}


struct HeartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HeartButtonView(active: .constant(false), startAnimation: false)
    }
}
