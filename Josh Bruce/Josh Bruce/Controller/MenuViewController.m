//
//  MenuViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "MenuViewController.h"
#import "AboutMeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *menuArray;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
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
    // Do any additional setup after loading the view.
	
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
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	// Deselect the previous row
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
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
	}
	
	UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(255/255) green:(255/255) blue:(255/255) alpha:0.1];
    cell.selectedBackgroundView = selectionColor;
	
	return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	// Get the indexPath of the selected row
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	
	// If we have an index path, prepare a segue
	if (indexPath) {
		// Check against our segue identifiers
		if ([segue.identifier isEqualToString:@"aboutMe"]) {
			if ([segue.destinationViewController isKindOfClass:[AboutMeViewController class]]) {
				AboutMeViewController *dvc = (AboutMeViewController *)segue.destinationViewController;
				dvc.itemToView = @"location";
			}
		}
	}
}

- (IBAction)unwindFromSwipeUpGesture:(UIStoryboardSegue *)segue
{
	// Allows for presented views to unwind from the storyboard with the gesture
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end