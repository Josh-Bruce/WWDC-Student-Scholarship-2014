//
//  EducationViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "EducationViewController.h"

@interface EducationViewController ()

@end

@implementation EducationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	// Slide in and alpha in the views
	if (self.universityView.alpha != ALPHA_FINISH) {
		[UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			self.universityView.layer.position = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.universityView.alpha = ALPHA_FINISH;
		} completion:^(BOOL finished) {
            [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
				self.swipeToContinue.alpha = ALPHA_FINISH;
			}];
        }];
	}
}

- (IBAction)speakCurrentViewText:(UIButton *)sender
{
	self.speaking = YES;

	// Depending on the current part of the scroll view, speak if the users wants it
	switch ((int)self.scrollView.contentOffset.x) {
		case 0:
			// Set the utterance string
			self.utteranceString = self.universityLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.universityLabelText;
			break;
		case 320:
			// Set the utterance string
			self.utteranceString = self.designPatternsLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.designPatternsLabelText;
			break;
		case 640:
			// Set the utterance string
			self.utteranceString = self.integratedProjectLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.integratedProjectLabelText;
			break;
		case 960:
			// Set the utterance string
			self.utteranceString = self.databaseDevelopmentLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.databaseDevelopmentLabelText;
			break;
		case 1280:
			// Set the utterance string
			self.utteranceString = self.algorithmDesignLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.algorithmDesignLabelText;
			break;
	}
}

#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Keep the swipe to continue on the screen and centred
    self.swipeToContinue.layer.position = CGPointMake(scrollView.contentOffset.x + VIEW_CENTRE_X, self.swipeToContinue.layer.position.y);
    
    if (scrollView.contentOffset.x == VIEW_WIDTH * 1 && self.designPatternsView.alpha != ALPHA_FINISH) {
        // Fade in the location view and set the coordinates of where I live
        [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			self.designPatternsView.layer.position = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.designPatternsView.alpha = ALPHA_FINISH;
		}];
    } else if (scrollView.contentOffset.x == VIEW_WIDTH * 2 && self.integratedProjectView.alpha != ALPHA_FINISH) {
        [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			self.integratedProjectView.layer.position = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.integratedProjectView.alpha = ALPHA_FINISH;
        }];
    } else if (scrollView.contentOffset.x == VIEW_WIDTH * 3 && self.databaseDevelopmentView.alpha != ALPHA_FINISH) {
        [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			self.databaseDevelopmentView.layer.position = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.databaseDevelopmentView.alpha = ALPHA_FINISH;
        }];
    } else if (scrollView.contentOffset.x == VIEW_WIDTH * 4 && self.algorithmDesignView.alpha != ALPHA_FINISH) {
        [UIView animateWithDuration:ANIMATION_DURATION_LONG animations:^{
			self.algorithmDesignView.layer.position = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.algorithmDesignView.alpha = ALPHA_FINISH;
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
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Navigation" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Main Menu" otherButtonTitles:@"University", @"Design Patterns", @"Integrated Projects", @"Database Development", @"Algorithm Design", nil];
		[actionSheet showInView:self.view];
	}
}

#pragma mark UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) {
		// Back to the main menu
		[self performSegueWithIdentifier:@"unwindEducation" sender:self];
	} else {
		// Scroll to the position in the scroll view
		[self.scrollView scrollRectToVisible:CGRectMake(VIEW_WIDTH * (buttonIndex - 1), 0, VIEW_WIDTH, VIEW_HEIGHT) animated:YES];
	}
}

@end