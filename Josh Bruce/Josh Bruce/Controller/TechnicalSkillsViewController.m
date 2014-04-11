//
//  TechnicalSkillsViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "TechnicalSkillsViewController.h"

@interface TechnicalSkillsViewController ()

@end

@implementation TechnicalSkillsViewController

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
	
	// Init our speech synthesizer
	self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    self.speechSynthesizer.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	// Slide in and alpha in the views
	if (self.objectivecView.alpha != ALPHA_FINISH) {
		[UIView animateWithDuration:ANIMATION_DURATION animations:^{
            CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.objectivecView.layer.position = newPosition;
			self.objectivecView.alpha = ALPHA_FINISH;
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
	// Depending on the current part of the scroll view, speak if the users wants it
	switch ((int)self.scrollView.contentOffset.x) {
		case 0:
			// Set the utterance string
			self.utteranceString = self.objectivecLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.objectivecLabelText;
			break;
		case 320:
			// Set the utterance string
			self.utteranceString = self.javaLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.javaLabelText;
			break;
		case 640:
			// Set the utterance string
			self.utteranceString = self.webLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.webLabelText;
			break;
        case 960:
            // Set the utterance string
			self.utteranceString = self.sqlLabelText.text;
			// Speak
			[self.speechSynthesizer speakUtterance:[self setUpSpeechWithString:self.utteranceString]];
			self.labelText = self.sqlLabelText;
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
}

#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Keep the swipe to continue on the screen and centred
    CGPoint newPosition = CGPointMake(scrollView.contentOffset.x + VIEW_CENTRE_X, self.swipeToContinue.layer.position.y);
    self.swipeToContinue.layer.position = newPosition;
    
    if (scrollView.contentOffset.x == 320 && self.javaView.alpha != ALPHA_FINISH) {
        // Fade in the location view and set the coordinates of where I live
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.javaView.layer.position = newPosition;
			self.javaView.alpha = ALPHA_FINISH;
		}];
    } else if (scrollView.contentOffset.x == 640 && self.webView.alpha != ALPHA_FINISH) {
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.webView.layer.position = newPosition;
			self.webView.alpha = ALPHA_FINISH;
        }];
    } else if (scrollView.contentOffset.x == 960 && self.sqlView.alpha != ALPHA_FINISH) {
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
			CGPoint newPosition = CGPointMake(WELCOME_FINISH_X, WELCOME_FINISH_Y);
			self.sqlView.layer.position = newPosition;
			self.sqlView.alpha = ALPHA_FINISH;
        }];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end