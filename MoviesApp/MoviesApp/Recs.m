//
//  Recs.m
//  MoviesApp
//
//  Created by Chad Swenson on 4/26/14.
//  Copyright (c) 2014 Chad Swenson. All rights reserved.
//

#import "Recs.h"
#import "RecView.h"
#import <QuartzCore/QuartzCore.h>
#import "RecSettingsViewController.h"

@interface Recs ()

@end

@implementation Recs

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading th2e view.
    self.navigationItem.title = @"What to Watch";
    
    UINib *nib = [UINib nibWithNibName:@"RecView" bundle:nil];
    RecView *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    RecView *view2 = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    
    CGRect f = view2.frame;
    f.origin.x = 320;
    f.origin.y = -25;
    view2.frame = f;
    CGRect f2 = view.frame;
    f2.origin.y = -25;
    f2.origin.x = -1;
    view.frame = f2;
    
    [view2.movieBgImageView setImage:[UIImage imageNamed: @"large-poster.jpg"]];
    /*CGSize scrollableSize = CGSizeMake(320, 628);
    [self.recPages setContentSize:scrollableSize];*/
    
    [self.recPages addSubview:view];
    [self.recPages addSubview:view2];
    
    self.recPages.contentSize = CGSizeMake(640, 455);
    //self.recPages.contentSize = CGSizeMake(self.recPages.contentSize.width,self.recPages.frame.size.height);
    

    
    
    
   /* CGRect f = self.recPages.frame;
    f.origin.y = 100; // new x
    self.recPages.frame = f;*/
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"settingsTransitions"])
    {
        
        
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        CGRect rect = [keyWindow bounds];
        UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [keyWindow.layer renderInContext:context];
        UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
        
        RecSettingsViewController *vc = [segue destinationViewController];
        
        vc.bgImage = capturedScreen;
        
        
        UIGraphicsEndImageContext();
        
        
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.recPages.frame.size.width;
    int page = floor((self.recPages.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
