//
//  RatingViewController.m
//  MoviesApp
//
//  Created by chad swenson on 5/22/14.
//  Copyright (c) 2014 Chad Swenson. All rights reserved.
//

#import "RatingViewController.h"
#import <POP/POP.h>

@interface RatingViewController ()

@end

@implementation RatingViewController

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
    
   // [self.backImage setImage:self.screenImage];
    [self.blurImage setImage:[self blur:self.screenImage]];
    [self performSelector:@selector(animateButtons) withObject:(self) afterDelay:(0.2)];
    //[self animateButtons];
}
-(void) animateButtons{
    POPSpringAnimation *button1Animation = [POPSpringAnimation animation];
    button1Animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPosition];
    
    button1Animation.toValue = [NSValue valueWithCGPoint:CGPointMake(60, 240)];
    
    button1Animation.springBounciness = 12.0;
    button1Animation.springSpeed = 10.0;
    
    [self.noButton pop_addAnimation:button1Animation forKey:@"pop1"];
    
    POPSpringAnimation *button2Animation = [POPSpringAnimation animation];
    button2Animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPosition];
    
    button2Animation.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 240)];
    
    button2Animation.springBounciness = 14.0;
    button2Animation.springSpeed = 10.0;
    
    [self.okButton pop_addAnimation:button2Animation forKey:@"pop2"];
    
    POPSpringAnimation *button3Animation = [POPSpringAnimation animation];
    button3Animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPosition];
    
    button3Animation.toValue = [NSValue valueWithCGPoint:CGPointMake(260, 240)];
    
    button3Animation.springBounciness = 11.0;
    button3Animation.springSpeed = 10.0;
    
    [self.likeButton pop_addAnimation:button3Animation forKey:@"pop3"];
    
    
}

- (UIImage*) blur:(UIImage*)theImage
{
    // ***********If you need re-orienting (e.g. trying to blur a photo taken from the device camera front facing camera in portrait mode)
    // theImage = [self reOrientIfNeeded:theImage];
    
    // create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    // setting up Gaussian Blur (we could use one of many filters offered by Core Image)
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];//create a UIImage for this function to "return" so that ARC can manage the memory of the blur... ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
    
    // *************** if you need scaling
    // return [[self class] scaleIfNeeded:cgImage];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeButtonHandler:(id)sender {
    
    POPSpringAnimation *button1Animation = [POPSpringAnimation animation];
    button1Animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPosition];
    
    button1Animation.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 740)];
    
    button1Animation.springBounciness = 12.0;
    button1Animation.springSpeed = 10.0;
    
    [self.noButton pop_addAnimation:button1Animation forKey:@"pop1"];
    
    POPSpringAnimation *button2Animation = [POPSpringAnimation animation];
    button2Animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPosition];
    
    button2Animation.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 740)];
    
    button2Animation.springBounciness = 14.0;
    button2Animation.springSpeed = 10.0;
    
    [self.okButton pop_addAnimation:button2Animation forKey:@"pop2"];
    
    POPSpringAnimation *button3Animation = [POPSpringAnimation animation];
    button3Animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPosition];
    
    button3Animation.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 740)];
    
    button3Animation.springBounciness = 11.0;
    button3Animation.springSpeed = 10.0;
    
    [self.likeButton pop_addAnimation:button3Animation forKey:@"pop3"];
    
    [self performSelector:@selector(dismissView) withObject:(self) afterDelay:(0.1)];
    
}
-(void)dismissView{
    [self dismissViewControllerAnimated:YES completion:nil];
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
