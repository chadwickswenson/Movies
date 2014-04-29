//
//  PosterView.m
//  MoviesApp
//
//  Created by Chad Swenson on 4/27/14.
//  Copyright (c) 2014 Chad Swenson. All rights reserved.
//

#import "PosterView.h"

@implementation PosterView{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        self.title = [[UILabel alloc] init];
        self.year = [[UILabel alloc] init];
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, self.bounds.size.width-2, self.bounds.size.height-2)];
        
        [self addSubview:self.img];
        [self addSubview:self.year];
        [self addSubview:self.title];
        self.layer.masksToBounds = NO;
       // self.layer.cornerRadius = 8;
        /*self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.3;*/

        self.img.layer.shouldRasterize = YES;
        //self.img.layer.rasterizationScale = 1;
        self.img.layer.edgeAntialiasingMask = kCALayerLeftEdge | kCALayerRightEdge | kCALayerBottomEdge | kCALayerTopEdge;
        self.img.clipsToBounds = NO;
        self.img.layer.masksToBounds = NO;
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
