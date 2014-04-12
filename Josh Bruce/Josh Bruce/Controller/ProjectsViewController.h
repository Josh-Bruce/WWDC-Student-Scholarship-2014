//
//  ProjectsViewController.h
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ProjectsViewController : BaseViewController <UIScrollViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet RoundedRect *referenceitView;
@property (weak, nonatomic) IBOutlet UILabel *referenceitLabelText;
@property (weak, nonatomic) IBOutlet RoundedRect *propertyView;
@property (weak, nonatomic) IBOutlet UILabel *propertyLabelText;
@property (weak, nonatomic) IBOutlet RoundedRect *seoView;
@property (weak, nonatomic) IBOutlet UIImageView *propertyImage;
@property (weak, nonatomic) IBOutlet UILabel *seoLabelText;
@property (weak, nonatomic) IBOutlet RoundedRect *eldercareView;
@property (weak, nonatomic) IBOutlet UILabel *eldercareLabelText;
@property (weak, nonatomic) IBOutlet UILabel *swipeToContinue;
@property (nonatomic, getter = isSpeaking) BOOL speaking;

@end