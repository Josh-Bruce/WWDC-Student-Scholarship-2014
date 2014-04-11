//
//  JoshBruceResumeViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 11/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "JoshBruceResumeViewController.h"

@interface JoshBruceResumeViewController ()

@end

@implementation JoshBruceResumeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get the file path to the PDF resume
    NSString *resumePath = [[NSBundle mainBundle] pathForResource:@"JoshBruce" ofType:@"pdf"];
    // Turn the path into a URL
    NSURL *resumeURL = [NSURL fileURLWithPath:resumePath];
    // Create a URL request
    NSURLRequest *resumeRequest = [NSURLRequest requestWithURL:resumeURL];
    
    // Load the request into the UIWebView
    [self.resumeWebView loadRequest:resumeRequest];
}

@end