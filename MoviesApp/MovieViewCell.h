//
//  MovieViewCell.h
//  MoviesApp
//
//  Created by chad swenson on 5/8/14.
//  Copyright (c) 2014 Chad Swenson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@end
