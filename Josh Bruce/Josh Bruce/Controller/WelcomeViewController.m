//
//  WelcomeViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "WelcomeViewController.h"
#import "RoundedRect.h"
#import <QuartzCore/QuartzCore.h>

@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet RoundedRect *welcomeView;
@property (weak, nonatomic) IBOutlet UIButton *letsBeginButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@end

@implementation WelcomeViewController

#define WELCOME_START_X 160
#define WELCOME_START_Y 62
#define WELCOME_FINISH_X 160
#define WELCOME_FINISH_Y 262

#define ALPHA_START 0.0
#define ALPHA_FINISH 1.0

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Round the corners of our image
    self.profileImageView.layer.cornerRadius = 10.0;
    self.profileImageView.layer.masksToBounds = YES;
    
    // Animate the welcome view into position when loaded
    [UIView animateWithDuration:1.0 animations:^{
        // Slide the view down and bring alpha to 1
		CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
		self.welcomeView.layer.position = newPosition;
		self.welcomeView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            // Bring the alpha of the button up to 1
            self.letsBeginButton.alpha = 1.0;
        }];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end