//
//  BaseTableViewController.swift
//  Zup
//
//  Created by Victor de Paula on 05/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import UIKit

class BaseTableViewController : UITableView {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
