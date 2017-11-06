//
//  UIColor+Extension.swift
//  Zup
//
//  Created by Victor de Paula on 04/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    func getPurpleGuidecolor() -> UIColor {
        return  UIColor(red: 112/255.0, green: 13/255.0, blue: 48/255.0, alpha: 1.0)
    }
    
    func getColorBlueDefaultGuide() -> UIColor {
        return UIColor(hexString: "164374") ?? .white
    }
    
    func getColorGoldGuide() -> UIColor {
        return UIColor(red:0.77, green:0.72, blue:0.57, alpha:1.0)
    }
    
    func getColorYellowApp() -> UIColor {
        return UIColor(hexString :"FEBC10") ?? .white
    }
    
    func getColorIconBackDefault() -> UIColor {
        return UIColor(hexString: "174073") ?? .white
    }
    
    func getColorIconWhiteDefault() -> UIColor {
        return UIColor(hexString: "F6F6F6") ?? .white
    }
    
    func getColorAddButtonActive() -> UIColor {
        return UIColor(hexString: "6F0D30") ?? .white
    }
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 0.8)
    }
    
    convenience init(netHex: Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
