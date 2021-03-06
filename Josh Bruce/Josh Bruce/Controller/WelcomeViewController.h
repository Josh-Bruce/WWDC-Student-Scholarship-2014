//
//  WelcomeViewController.h
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WelcomeViewController : BaseViewController

@property (weak, nonatomic) IBOutlet RoundedRect *welcomeView;
@property (weak, nonatomic) IBOutlet UIButton *letsBeginButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end