//
//  ProfessionalViewController.h
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ProfessionalViewController : BaseViewController <UIScrollViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet RoundedRect *surftrackView;
@property (weak, nonatomic) IBOutlet UILabel *surftrackLabelText;
@property (weak, nonatomic) IBOutlet RoundedRect *udemyView;
@property (weak, nonatomic) IBOutlet UILabel *udemyLabelText;
@property (weak, nonatomic) IBOutlet UIImageView *udemyImage;
@property (weak, nonatomic) IBOutlet RoundedRect *youtubeView;
@property (weak, nonatomic) IBOutlet UILabel *youtubeLabelText;
@property (weak, nonatomic) IBOutlet RoundedRect *salesxView;
@property (weak, nonatomic) IBOutlet UILabel *salesxLabelText;
@property (weak, nonatomic) IBOutlet UILabel *swipeToContinue;

@end