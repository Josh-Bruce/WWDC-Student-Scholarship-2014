//
//  InterestsViewController.h
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface InterestsViewController : BaseViewController <UIScrollViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *swipeToContinue;
@property (weak, nonatomic) IBOutlet RoundedRect *tennisView;
@property (weak, nonatomic) IBOutlet UILabel *tennisTextLabel;
@property (weak, nonatomic) IBOutlet RoundedRect *programmingView;
@property (weak, nonatomic) IBOutlet UILabel *programmingTextLabel;
@property (weak, nonatomic) IBOutlet RoundedRect *appleView;
@property (weak, nonatomic) IBOutlet UILabel *appleTextLabel;

@end