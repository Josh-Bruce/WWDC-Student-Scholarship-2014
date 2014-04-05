//
//  RoundedRect.m
//  Josh Bruce
//
//  Created by Josh Bruce on 05/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "RoundedRect.h"
#import <QuartzCore/QuartzCore.h>

@implementation RoundedRect

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code to give a slight corner radius
	self.layer.cornerRadius = 10.0;
	self.layer.masksToBounds = YES;
}

@end
