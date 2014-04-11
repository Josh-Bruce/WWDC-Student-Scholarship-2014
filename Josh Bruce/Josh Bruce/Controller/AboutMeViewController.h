//
//  AboutMeViewController.h
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AboutMeViewController : BaseViewController <UIScrollViewDelegate>

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDate *birthday;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet RoundedRect *ageView;
@property (weak, nonatomic) IBOutlet UILabel *ageTextLabel;
@property (weak, nonatomic) IBOutlet RoundedRect *locationView;
@property (weak, nonatomic) IBOutlet UILabel *locationTextLabel;
@property (weak, nonatomic) IBOutlet RoundedRect *universityView;
@property (weak, nonatomic) IBOutlet UILabel *universityTextLabel;
@property (weak, nonatomic) IBOutlet RoundedRect *contactView;
@property (weak, nonatomic) IBOutlet UILabel *swipeToContinue;
@property (weak, nonatomic) IBOutlet MKMapView *locationMapView;
@property (weak, nonatomic) IBOutlet UILabel *years;
@property (weak, nonatomic) IBOutlet UILabel *months;
@property (weak, nonatomic) IBOutlet UILabel *days;
@property (weak, nonatomic) IBOutlet UILabel *hours;
@property (weak, nonatomic) IBOutlet UILabel *minutes;
@property (weak, nonatomic) IBOutlet UILabel *seconds;

@end