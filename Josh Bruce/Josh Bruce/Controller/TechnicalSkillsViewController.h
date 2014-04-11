//
//  TechnicalSkillsViewController.h
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface TechnicalSkillsViewController : BaseViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *swipeToContinue;
@property (weak, nonatomic) IBOutlet RoundedRect *objectivecView;
@property (weak, nonatomic) IBOutlet UILabel *objectivecLabelText;
@property (weak, nonatomic) IBOutlet RoundedRect *javaView;
@property (weak, nonatomic) IBOutlet UILabel *javaLabelText;
@property (weak, nonatomic) IBOutlet RoundedRect *webView;
@property (weak, nonatomic) IBOutlet UILabel *webLabelText;
@property (weak, nonatomic) IBOutlet RoundedRect *sqlView;
@property (weak, nonatomic) IBOutlet UILabel *sqlLabelText;

@end