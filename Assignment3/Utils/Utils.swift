//
//  Utils.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 13/09/2023.
//

import Foundation

import UIKit

enum DeviceType {
    case iPhone
    case iPad
    case unknown
}

func getDeviceType() -> DeviceType {
    let userInterfaceIdiom = UIDevice.current.userInterfaceIdiom
    
    switch userInterfaceIdiom {
    case .phone:
        return .iPhone
    case .pad:
        return .iPad
    default:
        return .unknown
    }
}

extension UIApplication {
    
    @MainActor
    class func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
