//
//  ProjectsViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "ProjectsViewController.h"

@interface ProjectsViewController ()

@end

@implementation ProjectsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Round the property image
    self.propertyImage.layer.cornerRadius = 10.0;
    self.propertyImage.layer.masksToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	// Slide in and alpha in the views
	if (self.referenceitView.alpha != ALPHA_FINISH) {
		[UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
            CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.referenceitView.layer.position = newPosition;
			self.referenceitView.alpha = ALPHA_FINISH;
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
			self.utteranceString = self.referenceitLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.referenceitLabelText;
			break;
		case 320:
			// Set the utterance string
			self.utteranceString = self.propertyLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.propertyLabelText;
			break;
		case 640:
			// Set the utterance string
			self.utteranceString = self.seoLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.seoLabelText;
			break;
		case 960:
			// Set the utterance string
			self.utteranceString = self.eldercareLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.eldercareLabelText;
			break;
	}
}

#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Keep the swipe to continue on the screen and centred
    CGPoint newPosition = CGPointMake(scrollView.contentOffset.x + VIEW_CENTRE_X, self.swipeToContinue.layer.position.y);
    self.swipeToContinue.layer.position = newPosition;
    
    if (scrollView.contentOffset.x == 320 && self.propertyView.alpha != ALPHA_FINISH) {
        // Fade in the location view and set the coordinates of where I live
        [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.propertyView.layer.position = newPosition;
			self.propertyView.alpha = ALPHA_FINISH;
		}];
    } else if (scrollView.contentOffset.x == 640 && self.seoView.alpha != ALPHA_FINISH) {
        [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.seoView.layer.position = newPosition;
			self.seoView.alpha = ALPHA_FINISH;
        }];
	} else if (scrollView.contentOffset.x == 960 && self.eldercareView.alpha != ALPHA_FINISH) {
        [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.eldercareView.layer.position = newPosition;
			self.eldercareView.alpha = ALPHA_FINISH;
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
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Navigation" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Main Menu" otherButtonTitles:@"ReferenceIt", @"Property Management", @"SEO Manager", @"Eldercare Website", nil];
		[actionSheet showInView:self.view];
	}
}

#pragma mark UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) {
		// Back to the main menu
		[self performSegueWithIdentifier:@"unwindProjects" sender:self];
	} else {
		// Scroll to the position in the scroll view
		[self.scrollView scrollRectToVisible:CGRectMake(VIEW_WIDTH * (buttonIndex - 1), 0, VIEW_WIDTH, VIEW_HEIGHT) animated:YES];
	}
}

@end