//
//  MenuViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (NSMutableArray *)menuArray
{
	if (!_menuArray) _menuArray = [[NSMutableArray alloc] init];
	
	return _menuArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Add a rounded effect to the profile image
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.layer.masksToBounds = YES;
	
	// Add our menu items
	[self.menuArray addObject:@"About Me"];
	[self.menuArray addObject:@"Projects"];
	[self.menuArray addObject:@"Education"];
	[self.menuArray addObject:@"Professional"];
	[self.menuArray addObject:@"Technical Skills"];
	[self.menuArray addObject:@"Interests"];
	[self.menuArray addObject:@"Tutorial Overlay"];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	// Deselect the previous row
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Only show the tutorial overlay the once and then the user can access this again using the question mark
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"joshbruce_overlay_tutorial"]) {
        // Animate the overlay tutorial on screen
		[UIView animateWithDuration:0.5 animations:^{
			self.tutorialView.alpha = 1.0;
		} completion:^(BOOL finished) {
			[UIView animateWithDuration:1.0 animations:^{
				self.tutorialScrollView.layer.position = CGPointMake(160, 284);
			} completion:^(BOOL finished) {
				[UIView animateWithDuration:0.5 animations:^{
					self.tutorialPageControl.alpha = 1.0;
					self.dismissButton.alpha = 1.0;
				}];
			}];
		}];
        
        // Save a value to the defaults for the key joshbruce_overlay_tutorial
        [[NSUserDefaults standardUserDefaults] setValue:@"Shown" forKey:@"joshbruce_overlay_tutorial"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.menuArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([self.menuArray[indexPath.row] isEqualToString:@"About Me"]) {
		[self performSegueWithIdentifier:@"aboutMe" sender:self];
	} else if ([self.menuArray[indexPath.row] isEqualToString:@"Projects"]) {
		[self performSegueWithIdentifier:@"projects" sender:self];
	} else if ([self.menuArray[indexPath.row] isEqualToString:@"Education"]) {
		[self performSegueWithIdentifier:@"education" sender:self];
	} else if ([self.menuArray[indexPath.row] isEqualToString:@"Professional"]) {
		[self performSegueWithIdentifier:@"professional" sender:self];
	} else if ([self.menuArray[indexPath.row] isEqualToString:@"Technical Skills"]) {
		[self performSegueWithIdentifier:@"technicalSkills" sender:self];
	} else if ([self.menuArray[indexPath.row] isEqualToString:@"Interests"]) {
		[self performSegueWithIdentifier:@"interests" sender:self];
	} else if ([self.menuArray[indexPath.row] isEqualToString:@"Tutorial Overlay"]) {
        // Deselect the previous row
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
        [self displayOverlay];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if ([self.menuArray[indexPath.row] isEqualToString:@"Tutorial Overlay"]) {
        // Deselect the previous row
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
        [self displayOverlay];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menu item" forIndexPath:indexPath];
	
	NSString *cellText = self.menuArray[indexPath.row];
	cell.textLabel.text = cellText;
	
	if ([cellText isEqualToString:@"About Me"]) {
		cell.imageView.image = [UIImage imageNamed:@"about_me"];
	} else if ([cellText isEqualToString:@"Projects"]) {
		cell.imageView.image = [UIImage imageNamed:@"projects"];
	} else if ([cellText isEqualToString:@"Education"]) {
		cell.imageView.image = [UIImage imageNamed:@"education"];
	} else if ([cellText isEqualToString:@"Professional"]) {
		cell.imageView.image = [UIImage imageNamed:@"professional"];
	} else if ([cellText isEqualToString:@"Technical Skills"]) {
		cell.imageView.image = [UIImage imageNamed:@"technical_skills"];
	} else if ([cellText isEqualToString:@"Interests"]) {
		cell.imageView.image = [UIImage imageNamed:@"interests"];
	} else if ([cellText isEqualToString:@"Tutorial Overlay"]) {
        cell.imageView.image = [UIImage imageNamed:@"question"];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
	
	// Add a whited out background view when a row is selected
	UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(255/255) green:(255/255) blue:(255/255) alpha:0.1];
    cell.selectedBackgroundView = selectionColor;
	
	return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Calculate which page we are currently on for the page control
	CGFloat pageWidth = self.tutorialScrollView.frame.size.width;
    float fractionalPage = self.tutorialScrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.tutorialPageControl.currentPage = page;
}

- (void)displayOverlay
{
    // Display the overlay tutorial again via user input
    [UIView animateWithDuration:0.5 animations:^{
        self.tutorialView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            self.tutorialScrollView.layer.position = CGPointMake(160, 284);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.tutorialPageControl.alpha = 1.0;
                self.dismissButton.alpha = 1.0;
            }];
        }];
    }];
}

- (IBAction)dismissOverlay:(UIButton *)sender
{
    // Dismiss our actions before anything else
    self.tutorialPageControl.alpha = 0.0;
    self.dismissButton.alpha = 0.0;
    
    // Dismiss our overlay tutorial from user input
    [UIView animateWithDuration:1.0 animations:^{
        self.tutorialScrollView.layer.position = CGPointMake(160, 852);
    } completion:^(BOOL finished) {
        // Reset the position back to the beginning for when the user clicks to view it again.
        [self.tutorialScrollView scrollRectToVisible:CGRectMake(0, 0, 320, 568) animated:NO];
        [UIView animateWithDuration:0.5 animations:^{
            self.tutorialView.alpha = 0.0;
        }];
    }];
}

- (IBAction)unwindFromSwipeUpGesture:(UIStoryboardSegue *)segue
{
	// Allows for presented views to unwind from the storyboard with the gesture
}

@end