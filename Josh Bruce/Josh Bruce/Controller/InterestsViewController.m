//
//  InterestsViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "InterestsViewController.h"
#import "RoundedRect.h"

@interface InterestsViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet RoundedRect *tennisView;
@property (weak, nonatomic) IBOutlet UILabel *tennisSwipeToContinue;
@property (weak, nonatomic) IBOutlet RoundedRect *programmingView;
@property (weak, nonatomic) IBOutlet UILabel *programmingSwipeToContinue;
@property (weak, nonatomic) IBOutlet RoundedRect *appleView;
@property (weak, nonatomic) IBOutlet UILabel *appleSwipeToContinue;
@end

@implementation InterestsViewController

#define WELCOME_START_X 160
#define WELCOME_START_Y 62
#define WELCOME_FINISH_X 160
#define WELCOME_FINISH_Y 262

#define ALPHA_START 0.0
#define ALPHA_FINISH 1.0

#define ANIMATION_DURATION 1.0

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	// Slide in and alpha in the views
	if (self.tennisView.alpha != ALPHA_FINISH) {
		[UIView animateWithDuration:ANIMATION_DURATION animations:^{
            CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.tennisView.layer.position = newPosition;
			self.tennisView.alpha = ALPHA_FINISH;
		} completion:^(BOOL finished) {
            [UIView animateWithDuration:ANIMATION_DURATION animations:^{
				self.tennisSwipeToContinue.alpha = ALPHA_FINISH;
			}];
        }];
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Slide in and alpha in the views once they have been scrolled to
	if (scrollView.contentOffset.x == 320.00 && self.programmingView.alpha != ALPHA_FINISH) {
		[UIView animateWithDuration:ANIMATION_DURATION animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.programmingView.layer.position = newPosition;
			self.programmingView.alpha = ALPHA_FINISH;
		} completion:^(BOOL finished) {
            [UIView animateWithDuration:ANIMATION_DURATION animations:^{
				self.programmingSwipeToContinue.alpha = ALPHA_FINISH;
			}];
        }];
	} else if (scrollView.contentOffset.x == 640.00 && self.appleView.alpha != ALPHA_FINISH) {
		[UIView animateWithDuration:ANIMATION_DURATION animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.appleView.layer.position = newPosition;
			self.appleView.alpha = ALPHA_FINISH;
		} completion:^(BOOL finished) {
			[UIView animateWithDuration:ANIMATION_DURATION animations:^{
				self.appleSwipeToContinue.alpha = ALPHA_FINISH;
			}];
        }];
	}
}

- (IBAction)swipeUpMainMenu:(UISwipeGestureRecognizer *)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end