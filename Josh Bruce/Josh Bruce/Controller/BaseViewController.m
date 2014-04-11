//
//  BaseViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 11/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Init our speech synthesizer
	self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    self.speechSynthesizer.delegate = self;
}

- (AVSpeechUtterance *)setUpSpeechWithString:(NSString *)utteranceString
{
	// Init our speech text
	AVSpeechUtterance *speechUtterance = [[AVSpeechUtterance alloc] initWithString:utteranceString];
	speechUtterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
	speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate / 2;
	
	// Return the utterance to the method caller
	return speechUtterance;
}

#pragma mark AVSpeechSynthesizer Delegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance
{
	// Create an NSAttributedString to allow for highlighting the current word that is being spoken.
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
	// Set the status bar to be the white / light colour
    return UIStatusBarStyleLightContent;
}

@end