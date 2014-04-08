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
#import <AVFoundation/AVFoundation.h>

@interface AboutMeViewController () <UIScrollViewDelegate, AVSpeechSynthesizerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet RoundedRect *ageView;
@property (weak, nonatomic) IBOutlet RoundedRect *locationView;
@property (weak, nonatomic) IBOutlet RoundedRect *universityView;
@property (weak, nonatomic) IBOutlet RoundedRect *contactView;
@property (weak, nonatomic) IBOutlet UILabel *ageSwipeToContinue;
@property (weak, nonatomic) IBOutlet MKMapView *locationMapView;
@property (weak, nonatomic) IBOutlet UILabel *test;
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
    
    NSString *string = self.test.text;
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:string];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
    utterance.rate = 0.25f;
    
    
    AVSpeechSynthesizer *speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    speechSynthesizer.delegate = self;
    [speechSynthesizer speakUtterance:utterance];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
willSpeakRangeOfSpeechString:(NSRange)characterRange
                utterance:(AVSpeechUtterance *)utterance
{
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:utterance.speechString];
    [mutableAttributedString addAttribute:NSForegroundColorAttributeName
                                    value:[UIColor redColor] range:characterRange];
    self.test.attributedText = mutableAttributedString;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
  didStartSpeechUtterance:(AVSpeechUtterance *)utterance
{
    self.test.attributedText = [[NSAttributedString alloc] initWithString:self.test.text];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
 didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    self.test.attributedText = [[NSAttributedString alloc] initWithString:self.test.text];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Keep the swipe to continue on the screen and centred
    CGPoint newPosition = CGPointMake(scrollView.contentOffset.x + VIEW_CENTRE_X, self.ageSwipeToContinue.layer.position.y);
    self.ageSwipeToContinue.layer.position = newPosition;
    
    if (scrollView.contentOffset.x == 320 && self.locationView.alpha != 1.0) {
        // Fade in the location view and set the coordinates of where I live
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.locationView.layer.position = newPosition;
			self.locationView.alpha = ALPHA_FINISH;
		} completion:^(BOOL finished) {
			// Once we have faded in the view, add location of where I live on the map and zoom to that position
			MKPointAnnotation *myLocation = [[MKPointAnnotation alloc] init];
			myLocation.coordinate = CLLocationCoordinate2DMake(LOCATION_LATITUDE, LOCATION_LONGITUDE);
			myLocation.title = @"Josh Bruce's Home";
			[self.locationMapView addAnnotation:myLocation];
			[self.locationMapView showAnnotations:@[myLocation] animated:YES];
		}];
    } else if (scrollView.contentOffset.x == 640 && self.universityView.alpha != 1.0) {
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.universityView.layer.position = newPosition;
			self.universityView.alpha = ALPHA_FINISH;
        }];
    } else if (scrollView.contentOffset.x == 960 && self.contactView.alpha != 1.0) {
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.contactView.layer.position = newPosition;
			self.contactView.alpha = ALPHA_FINISH;
        }];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end