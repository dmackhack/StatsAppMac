//
//  EditPlayerViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 25/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "EditPlayerViewController.h"


@implementation EditPlayerViewController

@synthesize player=player_, userIdTextView=userIdTextView_ ,firstNameTextView=firstNameTextView_, lastNameTextView=lastNameTextView_, numberTextView=numberTextView_, activeTextView=activeTextView_;

- (StatsAppMacAppDelegate *) appDelegate
{
    return (StatsAppMacAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (StatsAppMacSession*) session
{
    return [[self appDelegate] session];
}

- (void)reloadData
{
    if (self.player != nil)
    {
        if (self.player.userId != nil)
        {
            self.userIdTextView.text = [NSString stringWithFormat:@"%@", self.player.userId];
        }
        else
        {
            self.userIdTextView.text = @"";
        }
        
        if (self.player.firstName != nil)
        {
            self.firstNameTextView.text = self.player.firstName;
        }
        else
        {
            self.firstNameTextView.text = @"";
        }
        
        if (self.player.lastName != nil)
        {
            self.lastNameTextView.text = self.player.lastName;
        }
        else
        {
            self.lastNameTextView.text = @"";
        }
        
        if (self.player.number != nil)
        {
            self.numberTextView.text = [NSString stringWithFormat:@"%@", self.player.number];
        }
        else
        {
            self.numberTextView.text = @"";
        }
        Club* club = [[self session] selectedClubForEdit];
        PlayerClub* playerClub = [self.player playerClubForClub:club];
        if (playerClub != nil && playerClub.active != nil)
        {
            NSLog(@"Active: %@", playerClub.active);
            self.activeTextView.text = [NSString stringWithFormat:@"%@", playerClub.active];
        }
        else
        {
            NSLog(@"Active nil");
            self.activeTextView.text = @"";
        }
    }
    else
    {
        self.firstNameTextView.text = @"";
        self.lastNameTextView.text = @"";
        self.numberTextView.text = @"";
        self.activeTextView.text = @"";
    }
    
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
    [player_ release];
    [firstNameTextView_ release];
    [lastNameTextView_ release];
    [numberTextView_ release];
    [activeTextView_ release];
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"ViewWillAppear");
    [super viewWillAppear:animated];
    
    [self reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // save the players.
    //NSLog(@"Clear checked lists");
    //[self reloadData];
    
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{
    // update player object and save
    SqlLiteRepository* repo = [[self appDelegate] repo];
    Club* club = [[self session] selectedClubForEdit];
    if (self.player == nil)
    {
        self.player = [club addNewPlayerWithRepositoryWithRepository:repo];
    }
     
    self.player.userId = [NSNumber numberWithInt:[self.userIdTextView.text intValue]];
    self.player.firstName = self.firstNameTextView.text;
    self.player.lastName = self.lastNameTextView.text;
    self.player.number = [NSNumber numberWithInt:[self.numberTextView.text intValue]];
    PlayerClub* playerClub = [self.player playerClubForClub:club];
    playerClub.active = [NSNumber numberWithInt:[self.activeTextView.text intValue]];
    
    // call saveContext
    [repo saveContext];
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
