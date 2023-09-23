//
//  SettingManager.swift
//  Assignment3
//
//  Created by Hữu Phước  on 23/09/2023.
//

import Foundation

class SettingManager: ObservableObject{
    static var shared = SettingManager()
    
    @Published var errorPopUp = false
    
    init(){}
}
