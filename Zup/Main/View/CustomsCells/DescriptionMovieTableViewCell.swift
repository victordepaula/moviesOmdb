//
//  CellNameTableViewCell.swift
//  Zup
//
//  Created by Victor de Paula on 04/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import UIKit

class DescriptionMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var view: UIView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.layer.cardView()
        // Initialization code
    }
}
