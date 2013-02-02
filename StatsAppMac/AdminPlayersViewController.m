//
//  AdminPlayersViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 15/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "AdminPlayersViewController.h"


@implementation AdminPlayersViewController

@synthesize leftViewController=leftViewController_, leftTableView=leftTableView_, rightViewController=rightViewContoller_, rightTableView=rightTableView_;


- (StatsAppMacAppDelegate *) appDelegate
{
    return (StatsAppMacAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (StatsAppMacSession*) session
{
    return [[self appDelegate] session];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [leftViewController_ release];
    [leftTableView_ release];
    [rightViewContoller_ release];
    [rightTableView_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ListClubsTableViewConroller* listClubsTableViewController = [[ListClubsTableViewConroller alloc] init];
    
    self.leftViewController = listClubsTableViewController;
    self.leftTableView.delegate = listClubsTableViewController;
    self.leftTableView.dataSource = listClubsTableViewController;
    listClubsTableViewController.tableView = self.leftTableView;
    
    [self.leftTableView reloadData];
    
    [listClubsTableViewController release];
    
    ListPlayersViewController* listPlayersTableViewController = [[ListPlayersViewController alloc] init];
    
    self.rightViewController = listPlayersTableViewController;
    self.rightTableView.delegate = listPlayersTableViewController;
    self.rightTableView.dataSource = listPlayersTableViewController;
    listPlayersTableViewController.tableView = self.rightTableView;
    
    [listPlayersTableViewController release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.rightTableView reloadData];
    [self.leftTableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)addPlayer:(id)sender
{
    EditPlayerViewController *editPlayerViewController = [[EditPlayerViewController alloc] initWithNibName:@"EditPlayerViewController" bundle:nil];
    editPlayerViewController.player = nil;
    [[[[self appDelegate] window] rootViewController] presentModalViewController:editPlayerViewController animated:YES];

    [editPlayerViewController release];
}

@end
