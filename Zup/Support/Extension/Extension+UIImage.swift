//
//  Extension+UIImage.swift
//  Zup
//
//  Created by Victor de Paula on 04/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    // MARK: - UIImage+Resize
    func convertToNSData() -> NSData{
        return (UIImagePNGRepresentation(self ?? UIImage()) as! NSData)
    }
    
    func decodeToImage(encode: NSData) -> UIImage{
        return  UIImage(data: (encode as? NSData) as! Data)!
    }
}

