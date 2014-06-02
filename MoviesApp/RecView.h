//
//  RecView.h
//  MoviesApp
//
//  Created by chad swenson on 5/13/14.
//  Copyright (c) 2014 Chad Swenson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *movieBgImageView;
@property (weak, nonatomic) IBOutlet UIButton *seenButton;
@property (weak, nonatomic) IBOutlet UIButton *notInterestedButton;
@property (weak, nonatomic) IBOutlet UIView *titleBgView;
@property (weak, nonatomic) IBOutlet UIImageView *titleBgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *buttonBgImageView;

@end
