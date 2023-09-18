//
//  ThemeEditingView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 18/09/2023.
//

import SwiftUI

struct ThemeEditingView: View {
    @State private var isLightTheme = true
    var body: some View {
        VStack{
            Toggle(isLightTheme ? "Light Theme" : "Dark Theme", isOn: $isLightTheme)
                .padding(.all)
            Spacer()
        }
        
    }
}

struct ThemeEditingView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditingView()
    }
}
