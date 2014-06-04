//
//  MovieCell.swift
//  MoviesApp
//
//  Created by chad swenson on 6/3/14.
//  Copyright (c) 2014 Chad Swenson. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UICollectionViewCell{
    @IBOutlet var posterImageView : UIImageView
    
    @IBOutlet var infoView : UIView
    
    init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
}