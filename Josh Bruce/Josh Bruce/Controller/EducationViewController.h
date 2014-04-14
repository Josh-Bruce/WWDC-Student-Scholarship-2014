//
//  EducationViewController.h
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface EducationViewController : BaseViewController <UIScrollViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet RoundedRect *universityView;
@property (weak, nonatomic) IBOutlet UILabel *universityLabelText;
@property (weak, nonatomic) IBOutlet RoundedRect *designPatternsView;
@property (weak, nonatomic) IBOutlet UIImageView *designPatternsImageView;
@property (weak, nonatomic) IBOutlet UILabel *designPatternsLabelText;
@property (weak, nonatomic) IBOutlet RoundedRect *integratedProjectView;
@property (weak, nonatomic) IBOutlet UILabel *integratedProjectLabelText;
@property (weak, nonatomic) IBOutlet RoundedRect *databaseDevelopmentView;
@property (weak, nonatomic) IBOutlet UILabel *databaseDevelopmentLabelText;
@property (weak, nonatomic) IBOutlet RoundedRect *algorithmDesignView;
@property (weak, nonatomic) IBOutlet UILabel *algorithmDesignLabelText;
@property (weak, nonatomic) IBOutlet UILabel *swipeToContinue;

@end