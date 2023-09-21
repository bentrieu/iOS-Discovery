//
//  BlurView.swift
//  Assignment3
//
//  Created by Vu Gia An on 22/09/2023.
//


import Foundation
import SwiftUI

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> some UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

