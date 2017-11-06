//
//  Extension+Dictionary.swift
//  Guide
//
//  Created by Victor de Paula on 03/11/17.
//  Copyright © 2017 cedro_nds. All rights reserved.
//

import Foundation

extension Dictionary where Value: Equatable {
    func getElementByIndex(i: Int) -> (key:Key,value:Value)  {
           return self[index(startIndex, offsetBy: i)]
    }
}
