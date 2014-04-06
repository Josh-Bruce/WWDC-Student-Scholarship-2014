//
//  MenuViewController.m
//  Josh Bruce
//
//  Created by Josh Bruce on 06/04/2014.
//  Copyright (c) 2014 Josh Bruce. All rights reserved.
//

#import "MenuViewController.h"
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
		[self performSegueWithIdentifier:@"about me" sender:self];
	} else if ([self.menuArray[indexPath.row] isEqualToString:@"Projects"]) {
		[self performSegueWithIdentifier:@"test" sender:self];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	/*
	 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
	 {
	 // Create an instance of our custom ticket cell
	 TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ticket cell" forIndexPath:indexPath];
	 
	 // Get the ticket at index
	 NSDictionary *ticket = self.ticketsForUser[indexPath.row];
	 
	 // Populate the cell with data
	 cell.ticketTitleLabel.text = [ticket valueForKeyPath:@"title"];
	 cell.ticketTypeLabel.text = [ticket valueForKeyPath:@"category.ticket_category"];
	 cell.ticketPriorityLabel.text = [NSString stringWithFormat:@"Priority: %@", [ticket valueForKeyPath:@"priority"]];
	 cell.ticketDescriptionTextView.text = [ticket valueForKeyPath:@"description"];
	 
	 return cell;
	 }*/
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menu item" forIndexPath:indexPath];
	
	cell.textLabel.text = self.menuArray[indexPath.row];
	
	UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(255/255) green:(255/255) blue:(255/255) alpha:0.1];
    cell.selectedBackgroundView = selectionColor;
	
	return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end