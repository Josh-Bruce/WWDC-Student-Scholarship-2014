//
//  JoshBruceViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 04/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "JoshBruceViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface JoshBruceViewController ()
@property (weak, nonatomic) IBOutlet UIView *welcomeView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@end

@implementation JoshBruceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add a slight corner radius to the welcome view
    self.welcomeView.layer.cornerRadius = 10.0;
    self.welcomeView.layer.masksToBounds = YES;
    
    // Add a rounded effect to the profile image
    self.profileImageView.layer.cornerRadius = 37.5;
    self.profileImageView.layer.masksToBounds = YES;
}

- (IBAction)swipeToContinue:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swiped");
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end