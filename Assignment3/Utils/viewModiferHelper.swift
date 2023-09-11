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
