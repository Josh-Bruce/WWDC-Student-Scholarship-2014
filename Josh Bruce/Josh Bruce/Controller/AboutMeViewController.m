//
//  AboutMeViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController () 

@end

@implementation AboutMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Round the map view
    self.locationMapView.layer.cornerRadius = IMAGEVIEW_CORNER_RADIUS;
    self.locationMapView.layer.masksToBounds = YES;
    
    // Round the contact image
    self.contactImageView.layer.cornerRadius = self.contactImageView.frame.size.width / 2;
    self.contactImageView.layer.masksToBounds = YES;
    
	// Init and start our timing updating
	[self initDateForBirthday];
    [self updateDate];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	// Slide in and alpha in the views
	if (self.ageView.alpha != ALPHA_FINISH) {
		[UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
            CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.ageView.layer.position = newPosition;
			self.ageView.alpha = ALPHA_FINISH;
		} completion:^(BOOL finished) {
            [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
				self.swipeToContinue.alpha = ALPHA_FINISH;
			}];
        }];
	}
	
	self.timer = [NSTimer scheduledTimerWithTimeInterval:ANIMATION_DURATION_LONG target:self selector:@selector(updateDate) userInfo:nil repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	
	// Invalidate the timer once we leave the view
	[self.timer invalidate];
	
	// If we are speaking, stop at next word
	if (self.isSpeaking) {
		[self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
	}
}

- (void)initDateForBirthday
{
	// Date format
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
	
	// My birthday with time of birth
    self.birthday = [[NSDate alloc] init];
    self.birthday = [self.dateFormatter dateFromString:@"02-02-1994 04:15:34"];
}

- (void)updateDate
{
    // Get the current calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Set the unit types that we want
    unsigned int uintFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    // Get the difference between my birthday and now
    NSDateComponents *differenceComponents = [calendar components:uintFlags fromDate:self.birthday toDate:[NSDate date] options:0];
	
    // Set the counting labels
    self.years.text = [NSString stringWithFormat:@"%ld", (long)[differenceComponents year]];
    self.months.text = [NSString stringWithFormat:@"%ld", (long)[differenceComponents month]];
    self.days.text = [NSString stringWithFormat:@"%ld", (long)[differenceComponents day]];
    self.hours.text = [NSString stringWithFormat:@"%ld", (long)[differenceComponents hour]];
    self.minutes.text = [NSString stringWithFormat:@"%ld", (long)[differenceComponents minute]];
    self.seconds.text = [NSString stringWithFormat:@"%ld", (long)[differenceComponents second]];
}

- (IBAction)speakCurrentViewText:(UIButton *)sender
{
	self.speaking = YES;

	// Depending on the current part of the scroll view, speak if the users wants it
	switch ((int)self.scrollView.contentOffset.x) {
		case 0:
			// Set the utterance string
			self.utteranceString = self.ageTextLabel.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.ageTextLabel;
			break;
		case 320:
			// Set the utterance string
			self.utteranceString = self.locationTextLabel.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.locationTextLabel;
			break;
		case 640:
			// Set the utterance string
			self.utteranceString = self.universityTextLabel.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.universityTextLabel;
			break;
	}
}

#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Keep the swipe to continue on the screen and centred
    self.swipeToContinue.layer.position = CGPointMake(scrollView.contentOffset.x + VIEW_CENTRE_X, self.swipeToContinue.layer.position.y);
    
    if (scrollView.contentOffset.x == VIEW_WIDTH * 1 && self.locationView.alpha != ALPHA_FINISH) {
        // Fade in the location view and set the coordinates of where I live
        [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			self.locationView.layer.position = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.locationView.alpha = ALPHA_FINISH;
		} completion:^(BOOL finished) {
			// Once we have faded in the view, add location of where I live on the map and zoom to that position
			MKPointAnnotation *myLocation = [[MKPointAnnotation alloc] init];
			myLocation.coordinate = CLLocationCoordinate2DMake(LOCATION_LATITUDE, LOCATION_LONGITUDE);
			myLocation.title = @"Josh Bruce's Home";
			[self.locationMapView addAnnotation:myLocation];
			[self.locationMapView showAnnotations:@[myLocation] animated:YES];
		}];
    } else if (scrollView.contentOffset.x == VIEW_WIDTH * 2 && self.universityView.alpha != ALPHA_FINISH) {
        [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			self.universityView.layer.position = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.universityView.alpha = ALPHA_FINISH;
        }];
    } else if (scrollView.contentOffset.x == VIEW_WIDTH * 3 && self.contactView.alpha != ALPHA_FINISH) {
        [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			self.contactView.layer.position = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.contactView.alpha = ALPHA_FINISH;
        }];
    }
	
	// If the AVSynthesizer is still speaking and we scroll, stop on the next word
    if (self.isSpeaking) {
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    }
}

- (IBAction)showActionMenu:(UILongPressGestureRecognizer *)sender
{
	// Check if the state is beginning and then show the action sheet
	if (sender.state == UIGestureRecognizerStateBegan) {
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Navigation" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Main Menu" otherButtonTitles:@"Getting Older", @"Living in the UK", @"University", @"Contact", nil];
		[actionSheet showInView:self.view];
	}
}

#pragma mark UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) {
		// Back to the main menu
		[self performSegueWithIdentifier:@"unwindAboutMe" sender:self];
	} else {
		// Scroll to the position in the scroll view
		[self.scrollView scrollRectToVisible:CGRectMake(VIEW_WIDTH * (buttonIndex - 1), 0, VIEW_WIDTH, VIEW_HEIGHT) animated:YES];
	}
}

- (IBAction)unwindFromResume:(UIStoryboardSegue *)segue
{
    // Allows for storyboard unwind segue from the UIWebView
}

@end