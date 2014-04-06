//
//  JoshBruceViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 04/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "JoshBruceViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface JoshBruceViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *welcomeView;
@property (weak, nonatomic) IBOutlet UIView *skillsView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *swipeToContinue;
@property (weak, nonatomic) IBOutlet UILabel *swipeToContinueSkills;
@end

@implementation JoshBruceViewController

#define OVERLAY_POSITION_Y 284

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add a rounded effect to the profile image
    self.profileImageView.layer.cornerRadius = 37.5;
    self.profileImageView.layer.masksToBounds = YES;
	
	// Set the main view to be invisible as well as the swipe to continue view
	self.welcomeView.alpha = 0.0;
	self.swipeToContinue.alpha = 0.0;
    self.skillsView.alpha = 0.0;
    self.swipeToContinueSkills.alpha = 0.0;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[UIView animateWithDuration:1.0 animations:^{
		// First animation is to bring in the main view and fade in
		CGPoint oldPosition = self.welcomeView.layer.position;
		CGPoint newPosition = CGPointMake(oldPosition.x, OVERLAY_POSITION_Y);
		self.welcomeView.layer.position = newPosition;
		self.welcomeView.alpha = 1.0;
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:1.0 animations:^{
			// Second animation is to fade in the swipe label
			self.swipeToContinue.alpha = 1.0;
		}];
	}];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 320) {
        [UIView animateWithDuration:1.0 animations:^{
            // First animation is to bring in the main view and fade in
            CGPoint oldPosition = self.skillsView.layer.position;
            CGPoint newPosition = CGPointMake(oldPosition.x, OVERLAY_POSITION_Y);
            self.skillsView.layer.position = newPosition;
            self.skillsView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 animations:^{
                // Second animation is to fade in the swipe label
                self.swipeToContinueSkills.alpha = 1.0;
            }];
        }];
    }
}

- (IBAction)swipeDownReturnHome:(UISwipeGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end