//
//  TabBar+Extension.swift
//  Zup
//
//  Created by Victor de Paula on 04/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarController {
    func setTabBarVisible(visible: Bool, animated: Bool) {
        if (tabBarVisible() == visible) { return }
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        
        // animation
        UIView.animate(withDuration: 0.3) {
            self.tabBar.frame.offsetBy(dx:0, dy:offsetY)
            self.view.frame = CGRect(x:0, y:0, width: self.view.frame.width, height: self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }
    }
    
    func tabBarVisible() -> Bool {
        return self.tabBar.frame.origin.y < UIScreen.main.bounds.height
    }
}

