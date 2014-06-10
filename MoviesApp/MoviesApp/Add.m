//
//  Add.m
//  MoviesApp
//
//  Created by Chad Swenson on 4/26/14.
//  Copyright (c) 2014 Chad Swenson. All rights reserved.
//

#import "Add.h"
#import "PosterView.h"
#import <POP/POP.h>
#import "MoviesApp-Swift.h"


#define ARC4RANDOM_MAX      0x100000000
#define NUMMOVIES      20
#define NUMMOVIESONSCREEN      10
#define MIN_VELOCITY      400
#define MOVIE_Y_POS      115
#define MOVIE_X_POS      60
#define ANI_BACK_TIME      0.5

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
        
        PosterView *movie = [[PosterView alloc] initWithFrame:CGRectMake(MOVIE_X_POS, MOVIE_Y_POS, 200, 300)];
        movie.layer.zPosition = NUMMOVIES - i;
        CGRect frame = movie.frame;
        frame.origin.x = 300 - frame.size.width;
        frame.origin.y = 300 - frame.size.height;
        NSString *posterName = [NSString stringWithFormat:@"poster%d.png",i];
        
        [movie.img setImage:[UIImage imageNamed: posterName]];
        
        self.currentMovieIndex = 0;
        
        double val = ((double)arc4random() / ARC4RANDOM_MAX)/10 - 0.05;
        
        [movie.img setTransform:CGAffineTransformMakeRotation(val)];
        [movie.infoView setTransform:CGAffineTransformMakeRotation(val)];
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
- (void)nextMovieSteps:(CGFloat)vel {
    
}
-(void)presentSignUp {
    SignUpViewController *new = (SignUpViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"signUp"];
    //menu is only an example
    new.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    CGRect rect = [keyWindow bounds];
//    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [keyWindow.layer renderInContext:context];
//    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
//    
//    new.screenImage =capturedScreen;
    
    [self presentViewController:new animated:YES completion:nil];
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
        
        self.thumbUpFilled.alpha = (MOVIE_Y_POS - curMovie.frame.origin.y)/(MOVIE_Y_POS-50);
        self.thumbDownFilled.alpha = (curMovie.frame.origin.y - MOVIE_Y_POS)/(self.view.frame.size.height-300);
        self.notSeenFilled.alpha = (MOVIE_X_POS - curMovie.frame.origin.x)/(MOVIE_X_POS+30);
        self.thumbAvgFilled.alpha = (curMovie.frame.origin.x - MOVIE_X_POS)/(self.view.frame.size.width-100);
       
    }
    else if(sender.state == UIGestureRecognizerStateEnded){  //swipe done check if movie should fly
        PosterView *curMovie = self.stackArr[self.currentMovieIndex];
        CGRect frame = curMovie.frame; //NSLog(@"x: %f", frame.origin.y);
        
        //Check if top
        if((frame.origin.y < 40 && [sender velocityInView:sender.view].y < -MIN_VELOCITY) || (frame.origin.y < -100)){
            
            [self addNextMovie]; //go to next movie as "active" movie
            
            CGFloat yPoints = 640.0;
            
            CGFloat velocityY = [sender velocityInView:sender.view].y;
            
            if(velocityY > -MIN_VELOCITY){
                velocityY = -MIN_VELOCITY;
            }
        
            NSTimeInterval duration = yPoints / velocityY;
            CGPoint offScreenCenter = curMovie.center;
            offScreenCenter.y -= yPoints;
            [UIView animateWithDuration:duration animations:^{
                curMovie.center = offScreenCenter;
            }];
            
            //set button color and animate back
            self.thumbUpFilled.alpha = 1;
            [UIView animateWithDuration:ANI_BACK_TIME animations:^{
                self.thumbUpFilled.alpha = 0;
                self.thumbAvgFilled.alpha = 0;
                self.thumbDownFilled.alpha = 0;
                self.notSeenFilled.alpha = 0;
            }];
            
            
        }//if bottom:
        else if((frame.origin.y > 190 && [sender velocityInView:sender.view].y > MIN_VELOCITY) || (frame.origin.y > 300)){
            [self addNextMovie];
            CGFloat yPoints = 640.0;
            CGFloat velocityY = [sender velocityInView:sender.view].y;
            
            if(velocityY < MIN_VELOCITY){  //make sure velocity isnt butt slow
                velocityY = MIN_VELOCITY;
            }
            
            NSTimeInterval duration = yPoints / velocityY;
            CGPoint offScreenCenter = curMovie.center;
            
            offScreenCenter.y += yPoints;
            
            [UIView animateWithDuration:duration animations:^{
                curMovie.center = offScreenCenter;
            }];
            
            self.thumbDownFilled.alpha = 1;
            [UIView animateWithDuration:ANI_BACK_TIME animations:^{
                self.thumbUpFilled.alpha = 0;
                self.thumbAvgFilled.alpha = 0;
                self.thumbDownFilled.alpha = 0;
                self.notSeenFilled.alpha = 0;
            }];
        }//right:
        else if((frame.origin.x > 150 && [sender velocityInView:sender.view].x > MIN_VELOCITY) || (frame.origin.x > 350)){
            
            [self addNextMovie];
            
            CGFloat xPoints = 620.0;
            CGFloat velocityX = [sender velocityInView:sender.view].x;
            
            if(velocityX < MIN_VELOCITY){
                velocityX = MIN_VELOCITY;
            }
         
            NSTimeInterval duration = xPoints / velocityX;
            CGPoint offScreenCenter = curMovie.center;
            offScreenCenter.x += xPoints;
            [UIView animateWithDuration:duration animations:^{
                curMovie.center = offScreenCenter;
            }];
            
            self.thumbAvgFilled.alpha = 1;
            [UIView animateWithDuration:ANI_BACK_TIME animations:^{
                self.thumbUpFilled.alpha = 0;
                self.thumbAvgFilled.alpha = 0;
                self.thumbDownFilled.alpha = 0;
                self.notSeenFilled.alpha = 0;
            }];
        }//left:
        else if((frame.origin.x < 30 && [sender velocityInView:sender.view].x < -MIN_VELOCITY) || (frame.origin.x < -120)){
            [self addNextMovie];
            CGFloat xPoints = 620.0;
            CGFloat velocityX = [sender velocityInView:sender.view].x;
            
            if(velocityX > -MIN_VELOCITY){
                velocityX = -MIN_VELOCITY;
            }
        
            NSTimeInterval duration = xPoints / velocityX;
            CGPoint offScreenCenter = curMovie.center;
            offScreenCenter.x -= xPoints;
            [UIView animateWithDuration:duration animations:^{
                curMovie.center = offScreenCenter;
            }];
            
            self.notSeenFilled.alpha = 1;
            [UIView animateWithDuration:ANI_BACK_TIME animations:^{
                self.thumbUpFilled.alpha = 0;
                self.thumbAvgFilled.alpha = 0;
                self.thumbDownFilled.alpha = 0;
                self.notSeenFilled.alpha = 0;
            }];
        }
        else{
            self.thumbUpFilled.alpha = 0;
            self.thumbAvgFilled.alpha = 0;
            self.thumbDownFilled.alpha = 0;
            self.notSeenFilled.alpha = 0;
            
            POPSpringAnimation *button1Animation = [POPSpringAnimation animation];
            button1Animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPosition];
            
            button1Animation.toValue = [NSValue valueWithCGPoint:CGPointMake(MOVIE_X_POS+100, MOVIE_Y_POS+150)];
            
            button1Animation.springBounciness = 17.0;
            button1Animation.springSpeed = 10.0;
            
            [curMovie.layer pop_addAnimation:button1Animation forKey:@"back"];
            
            /*[UIView animateWithDuration:0.3
                              delay: 0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^{
                             curMovie.frame = CGRectMake(MOVIE_X_POS, MOVIE_Y_POS, curMovie.frame.size.width, curMovie.frame.size.height);

                         }
                         completion:nil];
            [UIView animateWithDuration:1 animations:^{
                self.thumbUpFilled.alpha = 0;
                self.thumbAvgFilled.alpha = 0;
                self.thumbDownFilled.alpha = 0;
                self.notSeenFilled.alpha = 0;
            }];*/
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
    [self setZIndexes];
    [UITabBarItem.appearance setTitleTextAttributes:@{
                                                      UITextAttributeTextColor : [UIColor colorWithRed:40/255 green:55/255 blue:55/255 alpha:1] } forState:UIControlStateNormal];
    
}
-(void)viewDidAppear:(BOOL)animated{
        [self presentSignUp];
}


- (void)setZIndexes{
    self.thumbAvg.layer.zPosition = 10000;
    self.thumbUp.layer.zPosition = 10000;
    self.thumbUpFilled.layer.zPosition = 10000;
    self.thumbAvgFilled.layer.zPosition = 10000;
    self.thumbDown.layer.zPosition = 10000;
    self.thumbDownFilled.layer.zPosition = 10000;
    self.notSeen.layer.zPosition = 10000;
    self.notSeenFilled.layer.zPosition = 10000;
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
