//
//  MovieDetailCell.swift
//  Zup
//
//  Created by Victor de Paula on 05/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {
    
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var descriptionDetail: UILabel!
    @IBOutlet weak var descriptionMovie: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
