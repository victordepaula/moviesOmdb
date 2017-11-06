//
//  MoviesSavedTableViewCell.swift
//  Zup
//
//  Created by Victor de Paula on 04/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import UIKit

class MoviesSavedTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieSavedView: UIView!
    @IBOutlet weak var nameMovie: UILabel!
    
    func configCell(nameMovie: String, imageBase64 : NSData){
        self.movieSavedView.layer.cardView()
        self.nameMovie.text = nameMovie
        self.movieImageView.image = UIImage(data: (imageBase64 as! NSData) as Data)
    }
}

