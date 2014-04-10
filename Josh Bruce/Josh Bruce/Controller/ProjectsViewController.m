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

#define VIEW_HEIGHT self.view.layer.frame.size.height
#define VIEW_WIDTH self.view.layer.frame.size.width
#define VIEW_CENTRE_X VIEW_WIDTH / 2

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
    
    // Round the property image
    self.propertyImage.layer.cornerRadius = 10.0;
    self.propertyImage.layer.masksToBounds = YES;
	
	// Init our speech synthesizer
	self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    self.speechSynthesizer.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	// Slide in and alpha in the views
	if (self.referenceitView.alpha != ALPHA_FINISH) {
		[UIView animateWithDuration:ANIMATION_DURATION animations:^{
            CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.referenceitView.layer.position = newPosition;
			self.referenceitView.alpha = ALPHA_FINISH;
		} completion:^(BOOL finished) {
            [UIView animateWithDuration:ANIMATION_DURATION animations:^{
				self.swipeToContinue.alpha = ALPHA_FINISH;
			}];
        }];
	}
}

- (AVSpeechUtterance *)setUpSpeechWithString:(NSString *)utteranceString
{
	// Init our speech text
	AVSpeechUtterance *speechUtterance = [[AVSpeechUtterance alloc] initWithString:utteranceString];
	speechUtterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
	speechUtterance.rate = 0.25f;
	
	return speechUtterance;
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
	}
}

#pragma mark AVSpeechSynthesizer Delegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance
{
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:utterance.speechString];
    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:characterRange];
    self.labelText.attributedText = mutableAttributedString;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance
{
    self.labelText.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    self.labelText.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    self.speaking = NO;
}

#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Keep the swipe to continue on the screen and centred
    CGPoint newPosition = CGPointMake(scrollView.contentOffset.x + VIEW_CENTRE_X, self.swipeToContinue.layer.position.y);
    self.swipeToContinue.layer.position = newPosition;
    
    if (scrollView.contentOffset.x == 320 && self.propertyView.alpha != ALPHA_FINISH) {
        // Fade in the location view and set the coordinates of where I live
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.propertyView.layer.position = newPosition;
			self.propertyView.alpha = ALPHA_FINISH;
		}];
    } else if (scrollView.contentOffset.x == 640 && self.seoView.alpha != ALPHA_FINISH) {
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.seoView.layer.position = newPosition;
			self.seoView.alpha = ALPHA_FINISH;
        }];
	}
    
    // If the AVSynthesizer is still speaking and we scroll, stop on the next word
    if (self.isSpeaking) {
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end