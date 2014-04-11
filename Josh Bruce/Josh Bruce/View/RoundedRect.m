//
//  RoundedRect.m
//  Josh Bruce
//
//  Created by Josh Bruce on 05/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "RoundedRect.h"

@import QuartzCore;

@implementation RoundedRect

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		// Initialization code
		self.opaque = NO;
		self.layer.cornerRadius = 10.0;
		self.layer.masksToBounds = YES;
	}
	return self;
}

@end