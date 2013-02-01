//
//  EditPlayerViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 25/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "EditPlayerViewController.h"


@implementation EditPlayerViewController

@synthesize player=player_, firstNameTextView=firstNameTextView_, lastNameTextView=lastNameTextView_, numberTextView=numberTextView_;


- (void)reloadData
{
    if (self.player != nil)
    {
        self.firstNameTextView.text = self.player.firstName;
        self.lastNameTextView.text = self.player.lastName;
        self.numberTextView.text = [NSString stringWithFormat:@"%@", self.player.number];
    }
    else
    {
        self.firstNameTextView.text = @"";
        self.lastNameTextView.text = @"";
        self.numberTextView.text = @"";
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
    [self dismissModalViewControllerAnimated:YES];
}

@end
