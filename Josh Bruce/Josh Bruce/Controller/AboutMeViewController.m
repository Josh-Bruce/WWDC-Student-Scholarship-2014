//
//  AboutMeViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "AboutMeViewController.h"
#import "RoundedRect.h"
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

@interface AboutMeViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet RoundedRect *ageView;
@property (weak, nonatomic) IBOutlet RoundedRect *locationView;
@property (weak, nonatomic) IBOutlet UILabel *ageSwipeToContinue;
@property (weak, nonatomic) IBOutlet MKMapView *locationMapView;
@end

@implementation AboutMeViewController

#define VIEW_CENTRE_X 160

#define WELCOME_START_X 160
#define WELCOME_START_Y 62
#define WELCOME_FINISH_X 160
#define WELCOME_FINISH_Y 262

#define ALPHA_START 0.0
#define ALPHA_FINISH 1.0

#define ANIMATION_DURATION 1.0

#define LOCATION_LATITUDE 50.379853
#define LOCATION_LONGITUDE -4.137757

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationMapView.layer.cornerRadius = 10.0;
    self.locationMapView.layer.masksToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	// Slide in and alpha in the views
	if (self.ageView.alpha != ALPHA_FINISH) {
		[UIView animateWithDuration:ANIMATION_DURATION animations:^{
            CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.ageView.layer.position = newPosition;
			self.ageView.alpha = ALPHA_FINISH;
		} completion:^(BOOL finished) {
            [UIView animateWithDuration:ANIMATION_DURATION animations:^{
				self.ageSwipeToContinue.alpha = ALPHA_FINISH;
			}];
        }];
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint newPosition = CGPointMake(scrollView.contentOffset.x + VIEW_CENTRE_X, self.ageSwipeToContinue.layer.position.y);
    self.ageSwipeToContinue.layer.position = newPosition;
    
    if (scrollView.contentOffset.x == 320 && self.locationView.alpha != 1.0) {
        // Fade in the location view and set the coordinates of where I live
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.locationView.layer.position = newPosition;
			self.locationView.alpha = ALPHA_FINISH;
		} completion:^(BOOL finished) {
			MKPointAnnotation *myLocation = [[MKPointAnnotation alloc] init];
			myLocation.coordinate = CLLocationCoordinate2DMake(LOCATION_LATITUDE, LOCATION_LONGITUDE);
			myLocation.title = @"Josh Bruce's Home";
			[self.locationMapView addAnnotation:myLocation];
			[self.locationMapView showAnnotations:@[myLocation] animated:YES];
		}];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end