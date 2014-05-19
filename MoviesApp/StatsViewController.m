//
//  StatsViewController.m
//  MoviesApp
//
//  Created by chad swenson on 5/8/14.
//  Copyright (c) 2014 Chad Swenson. All rights reserved.
//

#import "StatsViewController.h"
#import "ChartView.h"

@interface StatsViewController ()

@end

@implementation StatsViewController

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
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Stats";
    [self addCharts];
}

- (void)addCharts
{
    UINib *nib = [UINib nibWithNibName:@"ChartView" bundle:nil];
    ChartView *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
     ChartView *view2 = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    CGRect f = view.frame;
    f.origin.x = 0;
    f.origin.y = 0;
    view.frame = f;
    
    CGRect f2 = view2.frame;
    f2.origin.x = 320;
    f2.origin.y = 0;
    view.frame = f2;
    
    self.chartScrollView.contentSize = CGSizeMake(640, 200);
    [self.chartScrollView addSubview:view];
    [self.chartScrollView addSubview:view2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.chartScrollView.frame.size.width;
    int page = floor((self.chartScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.chartsPageControl.currentPage = page;
    
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
