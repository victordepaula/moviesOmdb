//
//  TestCollectionViewCell.swift
//  Zup
//
//  Created by Victor de Paula on 02/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import UIKit
import ScalingCarousel

class CardMovieCollectionViewCell: ScalingCarouselCell {
    @IBOutlet weak var imageTest: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
