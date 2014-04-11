//
//  BaseViewController.h
//  Josh Bruce
//
//  Created by Josh Bruce on 11/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedRect.h"

@import QuartzCore;
@import MapKit;
@import AVFoundation;

@interface BaseViewController : UIViewController <AVSpeechSynthesizerDelegate>

#define VIEW_HEIGHT self.view.layer.frame.size.height
#define VIEW_WIDTH self.view.layer.frame.size.width
#define VIEW_CENTRE_X VIEW_WIDTH / 2
#define VIEW_CENTRE_Y VIEW_HEIGHT / 2

#define WELCOME_START_X 160
#define WELCOME_START_Y 62
#define WELCOME_FINISH_X 160
#define WELCOME_FINISH_Y 262

#define ALPHA_START 0.0
#define ALPHA_FINISH 1.0

#define ANIMATION_DURATION_SHORT 0.5
#define ANIMATION_DURATION_LONG 1.0

#define LOCATION_LATITUDE 50.379853
#define LOCATION_LONGITUDE -4.137757

@property (strong, nonatomic) AVSpeechSynthesizer *speechSynthesizer;
@property (weak, nonatomic) NSString *utteranceString;
@property (weak, nonatomic) UILabel *labelText;

- (AVSpeechUtterance *)setUpSpeechWithString:(NSString *)utteranceString;

@end