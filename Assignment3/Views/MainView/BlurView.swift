//
//  BlurView.swift
//  Assignment3
//
//  Created by Hữu Phước  on 23/09/2023.
//

import SwiftUI

struct BlurView: UIViewRepresentable{
    func makeUIView(context: Context) -> some UIVisualEffectView {
        let view =  UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
