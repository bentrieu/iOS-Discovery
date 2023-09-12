//
//  Modifier.swift
//  Assignment3
//
//  Created by DuyNguyen on 11/09/2023.
//

import Foundation
import SwiftUI

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

struct OneLineText: ViewModifier{
    func body(content: Content) -> some View {
        content
            .modifier(BlackColor())
            .lineLimit(1)
    }
}

