//
//  WelcomeViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Round the corners of our image
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
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

@end