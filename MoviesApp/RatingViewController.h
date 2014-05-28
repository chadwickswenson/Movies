//
//  RatingViewController.h
//  MoviesApp
//
//  Created by chad swenson on 5/22/14.
//  Copyright (c) 2014 Chad Swenson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIImageView *blurImage;
@property (weak, nonatomic) IBOutlet UIImage *screenImage;
@end
