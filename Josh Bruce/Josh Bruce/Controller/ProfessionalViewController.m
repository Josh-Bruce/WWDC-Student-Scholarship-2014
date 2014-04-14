//
//  ProfessionalViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "ProfessionalViewController.h"

@interface ProfessionalViewController () 

@end

@implementation ProfessionalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Round the udemy image
    self.udemyImage.layer.cornerRadius = 10.0;
    self.udemyImage.layer.masksToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	
	// Slide in and alpha in the views
	if (self.surftrackView.alpha != ALPHA_FINISH) {
		[UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
            CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.surftrackView.layer.position = newPosition;
			self.surftrackView.alpha = ALPHA_FINISH;
		} completion:^(BOOL finished) {
            [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
				self.swipeToContinue.alpha = ALPHA_FINISH;
			}];
        }];
	}
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	
	// If we are speaking, stop at next word
	if (self.isSpeaking) {
		[self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
	}
}

- (IBAction)speakCurrentViewText:(UIButton *)sender
{
	self.speaking = YES;

	// Depending on the current part of the scroll view, speak if the users wants it
	switch ((int)self.scrollView.contentOffset.x) {
		case 0:
			// Set the utterance string
			self.utteranceString = self.surftrackLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.surftrackLabelText;
			break;
		case 320:
			// Set the utterance string
			self.utteranceString = self.udemyLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.udemyLabelText;
			break;
		case 640:
			// Set the utterance string
			self.utteranceString = self.youtubeLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.youtubeLabelText;
			break;
		case 960:
			// Set the utterance string
			self.utteranceString = self.salesxLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.salesxLabelText;
			break;
	}
}

#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Keep the swipe to continue on the screen and centred
    CGPoint newPosition = CGPointMake(scrollView.contentOffset.x + VIEW_CENTRE_X, self.swipeToContinue.layer.position.y);
    self.swipeToContinue.layer.position = newPosition;
    
    if (scrollView.contentOffset.x == 320 && self.udemyView.alpha != ALPHA_FINISH) {
        // Fade in the location view and set the coordinates of where I live
        [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.udemyView.layer.position = newPosition;
			self.udemyView.alpha = ALPHA_FINISH;
		}];
    } else if (scrollView.contentOffset.x == 640 && self.youtubeView.alpha != ALPHA_FINISH) {
        [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.youtubeView.layer.position = newPosition;
			self.youtubeView.alpha = ALPHA_FINISH;
        }];
    } else if (scrollView.contentOffset.x == 960 && self.salesxView.alpha != ALPHA_FINISH) {
        [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.salesxView.layer.position = newPosition;
			self.salesxView.alpha = ALPHA_FINISH;
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
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Navigation" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Main Menu" otherButtonTitles:@"SurfTrack", @"Udemy", @"YouTube", @"SalesX, Inc", nil];
		[actionSheet showInView:self.view];
	}
}

#pragma mark UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) {
		// Back to the main menu
		[self performSegueWithIdentifier:@"unwindProfessional" sender:self];
	} else {
		// Scroll to the position in the scroll view
		[self.scrollView scrollRectToVisible:CGRectMake(VIEW_WIDTH * (buttonIndex - 1), 0, VIEW_WIDTH, VIEW_HEIGHT) animated:YES];
	}
}

@end