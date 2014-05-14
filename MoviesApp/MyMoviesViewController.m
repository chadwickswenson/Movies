//
//  MyMoviesViewController.m
//  MoviesApp
//
//  Created by chad swenson on 5/8/14.
//  Copyright (c) 2014 Chad Swenson. All rights reserved.
//

#import "MyMoviesViewController.h"
#import "MovieViewCell.h"

@interface MyMoviesViewController (){
     NSArray *moviePosters;
}

@end

@implementation MyMoviesViewController

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
    self.navigationItem.title = @"My Movies";
    moviePosters = [NSArray arrayWithObjects:@"poster0",@"poster1",@"poster2",@"poster3",@"poster3",@"poster4",@"poster6",@"poster7",@"poster8",@"poster10",@"poster3",@"poster10",@"poster3",@"poster10",@"poster3",@"poster10",@"poster3",@"poster10",@"poster3",@"poster10",@"poster3", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return moviePosters.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"MovieCell";
    
    MovieViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.posterImageView.image = [UIImage imageNamed:[moviePosters objectAtIndex:indexPath.row]];
    
    cell.titleLabel.text = @"Lord of the Rings: The Fellowship of the Ring";
    
    return cell;
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
