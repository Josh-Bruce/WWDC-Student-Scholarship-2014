//
//  InterestsViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "InterestsViewController.h"

@interface InterestsViewController ()

@end

@implementation InterestsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	// Slide in and alpha in the views
	if (self.tennisView.alpha != ALPHA_FINISH) {
		[UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
            CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.tennisView.layer.position = newPosition;
			self.tennisView.alpha = ALPHA_FINISH;
		} completion:^(BOOL finished) {
            [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
				self.swipeToContinue.alpha = ALPHA_FINISH;
			}];
        }];
	}
}

- (IBAction)speakCurrentViewText:(UIButton *)sender
{
    // Depending on the current part of the scroll view, speak if the users wants it
	switch ((int)self.scrollView.contentOffset.x) {
		case 0:
			// Set the utterance string
			self.utteranceString = self.tennisTextLabel.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.tennisTextLabel;
			break;
		case 320:
			// Set the utterance string
			self.utteranceString = self.programmingTextLabel.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.programmingTextLabel;
			break;
		case 640:
			// Set the utterance string
			self.utteranceString = self.appleTextLabel.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.appleTextLabel;
			break;
	}
}

#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Keep the swipe to continue on the screen and centred
    CGPoint newPosition = CGPointMake(scrollView.contentOffset.x + VIEW_CENTRE_X, self.swipeToContinue.layer.position.y);
    self.swipeToContinue.layer.position = newPosition;
	
	// Slide in and alpha in the views once they have been scrolled to
	if (scrollView.contentOffset.x == 320.00 && self.programmingView.alpha != ALPHA_FINISH) {
		[UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.programmingView.layer.position = newPosition;
			self.programmingView.alpha = ALPHA_FINISH;
		}];
	} else if (scrollView.contentOffset.x == 640.00 && self.appleView.alpha != ALPHA_FINISH) {
		[UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.appleView.layer.position = newPosition;
			self.appleView.alpha = ALPHA_FINISH;
		}];
	}
}

- (IBAction)showActionMenu:(UILongPressGestureRecognizer *)sender
{
	// Check if the state is beginning and then show the action sheet
	if (sender.state == UIGestureRecognizerStateBegan) {
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Navigation" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Main Menu" otherButtonTitles:@"Tennis", @"Programming", @"Apple", nil];
		[actionSheet showInView:self.view];
	}
}

#pragma mark UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) {
		// Back to the main menu
		[self performSegueWithIdentifier:@"unwindInterests" sender:self];
	} else {
		// Scroll to the position in the scroll view
		[self.scrollView scrollRectToVisible:CGRectMake(VIEW_WIDTH * (buttonIndex - 1), 0, VIEW_WIDTH, VIEW_HEIGHT) animated:YES];
	}
}

@end