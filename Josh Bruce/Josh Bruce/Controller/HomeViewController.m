//
//  HomeViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIView *overlayTutorial;
@property (nonatomic) BOOL hasOverlayAppeared;
@end

@implementation HomeViewController

#define OVERLAY_SLIDEIN_X 160
#define OVERLAY_SLIDEIN_Y 284
#define OVERLAY_SLIDEOUT_X 160
#define OVERLAY_SLIDEOUT_Y -568

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // When we first load, show the overlay to remind the user
    self.hasOverlayAppeared = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Make sure the overlay only happens once...
    if (!self.hasOverlayAppeared) {
        // Fade in the overlay tutorial
        [UIView animateWithDuration:1.0 animations:^{
            CGPoint newPosition = CGPointMake(OVERLAY_SLIDEIN_X, OVERLAY_SLIDEIN_Y);
            self.overlayTutorial.layer.position = newPosition;
            self.hasOverlayAppeared = YES;
        }];
    }
}

- (IBAction)dismissOverlayTutorial:(UIButton *)sender
{
    [UIView animateWithDuration:1.0 animations:^{
		CGPoint newPosition = CGPointMake(OVERLAY_SLIDEOUT_X, OVERLAY_SLIDEOUT_Y);
		self.overlayTutorial.layer.position = newPosition;
    }];
}

- (IBAction)dragUp:(UIPanGestureRecognizer *)sender
{
    NSLog(@"%@", sender);
    CGPoint translation = [sender translationInView:self.view];
    
    sender.view.center = CGPointMake(sender.view.center.x, sender.view.center.y + translation.y);
    
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
}

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    
//    // If the touch was in the placardView, move the placardView to its location
//    if ([touch view] == self.overlayTutorial) {
//        CGPoint location = [touch locationInView:self.view];
//        self.overlayTutorial.center = location;
//        return;
//    }
//}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end