//
//  Add.m
//  MoviesApp
//
//  Created by Chad Swenson on 4/26/14.
//  Copyright (c) 2014 Chad Swenson. All rights reserved.
//

#import "Add.h"
#import "PosterView.h"

#define ARC4RANDOM_MAX      0x100000000
#define NUMMOVIES      20
#define NUMMOVIESONSCREEN      10

@interface Add ()
    @property (strong, nonatomic) NSMutableArray *stackArr;
    @property (nonatomic) CGPoint fingerPos;
    @property (nonatomic) int currentMovieIndex;



@end

@implementation Add{
    
}

- (void)loadMovies{
    
    int i = 0;
    
    for(i = 0; i < NUMMOVIES;i++){
        
        
        PosterView *movie = [[PosterView alloc] initWithFrame:CGRectMake(50, 100, 200, 300)];
        movie.layer.zPosition = NUMMOVIES - i;
        CGRect frame = movie.frame;
        frame.origin.x = 300 - frame.size.width;
        frame.origin.y = 300 - frame.size.height;
        NSString *posterName = [NSString stringWithFormat:@"poster%d.png",i];
        
        [movie.img setImage:[UIImage imageNamed: posterName]];
        
        self.currentMovieIndex = 0;
        
        double val = ((double)arc4random() / ARC4RANDOM_MAX)/10 - 0.05;
        
        [movie.img setTransform:CGAffineTransformMakeRotation(val)];
        [self.stackArr addObject:movie];
        
    }
}
- (void)initMoviesToView{
    
    int i = 0;
    
    for(i = 0; i < NUMMOVIESONSCREEN;i++){
        
        [self.view addSubview:[self.stackArr objectAtIndex:i]];
        
    }
    
}
- (void)addNextMovie{
    if(self.currentMovieIndex < 8){
        [self.view addSubview:[self.stackArr objectAtIndex:self.currentMovieIndex+NUMMOVIESONSCREEN]];
        
    }
    self.currentMovieIndex++;
}
- (IBAction)dragAction:(UIPanGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateBegan){
        self.fingerPos = [sender locationInView:self.view];
    }
    else if(sender.state == UIGestureRecognizerStateChanged){
        
        CGPoint newCoord = [sender locationInView:sender.view];
        
        PosterView *curMovie = self.stackArr[self.currentMovieIndex];
        CGRect frame = curMovie.frame;
        
        [curMovie setFrame:CGRectMake(curMovie.frame.origin.x+newCoord.x-self.fingerPos.x, curMovie.frame.origin.y+newCoord.y-self.fingerPos.y, frame.size.width, frame.size.height)];
        self.fingerPos = [sender locationInView:self.view];
       
    }
    else if(sender.state == UIGestureRecognizerStateEnded){
        PosterView *curMovie = self.stackArr[self.currentMovieIndex];
        CGRect frame = curMovie.frame;
        NSLog(@"x: %f", frame.origin.y);
        if((frame.origin.y < - 50 && [sender velocityInView:sender.view].y < -600) || (frame.origin.y < -100)){
            [self addNextMovie];
            CGFloat yPoints = 640.0;
            
            CGFloat velocityY = [sender velocityInView:sender.view].y;
            NSLog(@"%f", velocityY);
            if(velocityY > -600){
                velocityY = -600;
            }
            //NSLog(@"%f", velocityY);
            NSTimeInterval duration = yPoints / velocityY;
            CGPoint offScreenCenter = curMovie.center;
            offScreenCenter.y -= yPoints;
            [UIView animateWithDuration:duration animations:^{
                curMovie.center = offScreenCenter;
            }];
            
        }
        else if((frame.origin.y > 190 && [sender velocityInView:sender.view].y > 600) || (frame.origin.y > 300)){
            [self addNextMovie];
            CGFloat yPoints = 640.0;
            CGFloat velocityY = [sender velocityInView:sender.view].y;
            if(velocityY < 600){
                velocityY = 600;
            }
            NSLog(@"%f", velocityY);
            NSTimeInterval duration = yPoints / velocityY;
            CGPoint offScreenCenter = curMovie.center;
            offScreenCenter.y += yPoints;
            [UIView animateWithDuration:duration animations:^{
                curMovie.center = offScreenCenter;
            }];
        }
        else if((frame.origin.x > 150 && [sender velocityInView:sender.view].x > 600) || (frame.origin.x > 350)){
            [self addNextMovie];
            CGFloat xPoints = 620.0;
            CGFloat velocityX = [sender velocityInView:sender.view].x;
            if(velocityX < 600){
                velocityX = 600;
            }
            NSLog(@"%f", velocityX);
            NSLog(@"%f", frame.origin.x);
            NSTimeInterval duration = xPoints / velocityX;
            CGPoint offScreenCenter = curMovie.center;
            offScreenCenter.x += xPoints;
            [UIView animateWithDuration:duration animations:^{
                curMovie.center = offScreenCenter;
            }];
        }
        else if((frame.origin.x < -70 && [sender velocityInView:sender.view].x < -600) || (frame.origin.x < -120)){
            [self addNextMovie];
            CGFloat xPoints = 620.0;
            CGFloat velocityX = [sender velocityInView:sender.view].x;
            if(velocityX > -600){
                velocityX = -600;
            }
            NSLog(@"%f", velocityX);
            NSLog(@"%f", frame.origin.x);
            NSTimeInterval duration = xPoints / velocityX;
            CGPoint offScreenCenter = curMovie.center;
            offScreenCenter.x -= xPoints;
            [UIView animateWithDuration:duration animations:^{
                curMovie.center = offScreenCenter;
            }];
        }
        else{
            [UIView animateWithDuration:0.3
                              delay: 0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^{
                             curMovie.frame = CGRectMake(50, 100, curMovie.frame.size.width, curMovie.frame.size.height);

                         }
                         completion:nil];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stackArr = [[NSMutableArray alloc] init];
    [self loadMovies];
    [self initMoviesToView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
