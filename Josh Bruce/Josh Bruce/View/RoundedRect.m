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
		self.opaque = NO;
		self.alpha = 0.5;
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
	
//	[[UIColor whiteColor] setFill];
//	UIRectFill(rect);
	
//	CGRect hole = CGRectIntersection(CGRectMake((self.frame.size.width / 2) - (self.frame.size.width / 3) / 2, 25, self.frame.size.width / 3, 25), rect);
//	[[UIBezierPath bezierPathWithRoundedRect:hole cornerRadius:1.0] addClip];
//	[[UIColor clearColor] setFill];
//	UIRectFill(hole);
}

@end
