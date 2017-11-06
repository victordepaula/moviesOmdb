//
//  Extension+String.swift
//  Zup
//
//  Created by Victor de Paula on 06/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func removeSpacesString() {
        if let replacement = regex.stringByReplacingMatches(in: self, options: .withTransparentBounds, range: NSMakeRange(0, (self as NSString).length), withTemplate: "_") {
            self = replacement
        }
    }
}
