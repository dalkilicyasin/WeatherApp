//
//  ExtensionUIApplication.swift
//  InstaClone
//
//  Created by Yasin Dalkilic on 26.05.2022.
//

import Foundation
import UIKit

extension UIApplication {
    
    public var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
    public class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
