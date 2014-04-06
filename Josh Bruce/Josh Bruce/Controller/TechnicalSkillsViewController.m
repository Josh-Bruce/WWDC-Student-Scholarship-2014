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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)swipeUpMainMenu:(UISwipeGestureRecognizer *)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end