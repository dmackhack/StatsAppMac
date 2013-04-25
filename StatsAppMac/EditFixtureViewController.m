//
//  EditFixtureViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 15/03/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "EditFixtureViewController.h"


@implementation EditFixtureViewController

@synthesize roundTextField=roundTextField_, datePicker=datePicker_, homeTeamPicker=homeTeamPicker_, awayTeamPicker=awayTeamPicker_, match=match_, roundPickerController=roundPickerController_, popOver=popOver_, roundLabel=roundLabel_, editRoundButton=editRoundButton_, homeTeamLabel=homeTeamLabel_, awayTeamLabel=awayTeamLabel_, dateLabel=dateLabel_, divisionLabel=divisionLabel_, fixtureDetailsView=fixtureDetailsView_;


Club* selectedHomeClub;
Club* selectedAwayClub;
Team* selectedHomeTeam;
Team* selectedAwayTeam;


- (StatsAppMacAppDelegate *) appDelegate
{
    return (StatsAppMacAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (SqlLiteRepository*) repo
{
    return [[self appDelegate] repo];
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
    [roundTextField_ release];
    [datePicker_ release];
    [homeTeamPicker_ release];
    [awayTeamPicker_ release];
    //[roundPicker_ release];
    [match_ release];
    [popOver_ release];
    
    [roundPickerController_ release];
    [roundLabel_ release];
    [editRoundButton_ release];
    [homeTeamLabel_ release];
    [awayTeamLabel_ release];
    [dateLabel_ release];
    [divisionLabel_ release];
    [fixtureDetailsView_ release];
    
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
    
    if (roundPickerController_ == nil)
    {
        roundPickerController_ = [[RoundPickerViewController alloc] initWithMatch:self.match andPicker:nil];
    }
    
    if (homeTeamPicker_ == nil)
    {
        homeTeamPicker_ = [[UIPickerView alloc] init];
        self.homeTeamPicker.delegate = self;
        self.homeTeamPicker.dataSource = self;
        self.homeTeamPicker.showsSelectionIndicator = YES;
    }
    
    if (awayTeamPicker_ == nil)
    {
        awayTeamPicker_ = [[UIPickerView alloc] init];
        self.awayTeamPicker.delegate = self;
        self.awayTeamPicker.dataSource = self;
        self.awayTeamPicker.showsSelectionIndicator = YES;
    }
    
    if (datePicker_ == nil)
    {
        datePicker_ = [[UIDatePicker alloc] init];
    }
    
    UIBarButtonItem* saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.fixtureDetailsView.layer.masksToBounds = NO;
    self.fixtureDetailsView.layer.cornerRadius = 10;
    self.fixtureDetailsView.layer.shadowOffset = CGSizeMake(-15, 20);
    self.fixtureDetailsView.layer.shadowRadius = 5;
    self.fixtureDetailsView.layer.shadowOpacity = 0.5;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    roundPickerController_ = nil;
}

-(NSNumber*) clubIndex:(NSString*) name;
{
    int index = 0;
    for (Club* club in [[[self appDelegate] clubRepo] fetchClubs:nil])
    {
        if ([name isEqualToString:club.name])
        {
            NSLog(@"Found Index for Club %@ at Index %d", name, index);
            break;
        }
        index++;
    }
    return [NSNumber numberWithInt:index];
}

-(NSNumber*) teamIndexForClub:(Club*)club andTeam:(NSString*) name
{
    int index = 0;
    NSSortDescriptor* nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    for (Team* team in [club.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]])
    {
        //NSLog(@"%@:%@", name, team.name);
        if ([name isEqualToString:team.name])
        {
            NSLog(@"Found Index for Team %@ for Club %@ at Index %d", name, club.name, index);
            break;
        }
        index++;
    }
    [nameSort release];
    return [NSNumber numberWithInt:index];
}

- (void) reloadData
{
    self.datePicker.date = self.match.date;
    self.roundTextField.text = self.match.round.number.stringValue;
    
    self.homeTeamLabel.text = self.match.homeTeam.team.club.name;
    self.awayTeamLabel.text = self.match.awayTeam.team.club.name;
    self.roundLabel.text = self.match.self.round.number.stringValue;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE dd MMM yyyy hh:mm aa"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-3540]];
    NSString* dateLabel = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[self.match date]]];
    self.dateLabel.text = dateLabel;
    NSString* divisionLabel;
    if (self.match.round.season.division.name == nil)
    {
        divisionLabel = selectedHomeTeam.name;
    }
    else
    {
        divisionLabel = [NSString stringWithFormat:@"%@ - %@", self.match.round.season.division.name,  selectedHomeTeam.name];
    }
    self.divisionLabel.text = divisionLabel;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if (self.match != nil)
    {
        selectedHomeTeam = self.match.homeTeam.team;
        selectedAwayTeam = self.match.awayTeam.team;
        selectedHomeClub = selectedHomeTeam.club;
        selectedAwayClub = selectedAwayTeam.club;
        NSNumber* homeClubIndex = [self clubIndex:selectedHomeClub.name];
        NSNumber* awayClubIndex = [self clubIndex:selectedAwayClub.name];
        NSNumber* homeTeamIndex = [self teamIndexForClub:selectedHomeClub andTeam:selectedHomeTeam.name];
        NSNumber* awayTeamIndex = [self teamIndexForClub:selectedAwayClub andTeam:selectedAwayTeam.name];        
        
        [self.homeTeamPicker selectRow:[homeClubIndex integerValue] inComponent:0 animated:NO];
        [self.awayTeamPicker selectRow:[awayClubIndex integerValue] inComponent:0 animated:NO];

        [self.homeTeamPicker selectRow:[homeTeamIndex integerValue] inComponent:1 animated:NO];
        [self.awayTeamPicker selectRow:[awayTeamIndex integerValue] inComponent:1 animated:NO];
        
        [self reloadData];
    }
    else
    {
        //selectedHomeClub = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:0];
        //selectedAwayClub = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:0];
        
        [self pickerView:self.homeTeamPicker didSelectRow:0 inComponent:0];
        [self pickerView:self.awayTeamPicker didSelectRow:0 inComponent:0];
        [self pickerView:self.homeTeamPicker didSelectRow:0 inComponent:1];
        [self pickerView:self.awayTeamPicker didSelectRow:0 inComponent:1];
        //[self.homeTeamPicker selectRow:0 inComponent:0 animated:NO];
        //[self.awayTeamPicker selectRow:0 inComponent:0 animated:NO];
        
        //[self.homeTeamPicker selectRow:0 inComponent:1 animated:NO];
        //[self.awayTeamPicker selectRow:0 inComponent:1 animated:NO];
        
    }
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    selectedHomeTeam = nil;
    selectedAwayTeam = nil;
    selectedHomeClub = nil;
    selectedAwayClub = nil;
    match_ = nil;
    [super viewDidDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == self.homeTeamPicker)
    {
        return 2;
    }
    else if (pickerView == self.awayTeamPicker)
    {
        return 2;
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int count = 0;
    if (pickerView == self.homeTeamPicker || pickerView == self.awayTeamPicker)
    {
        if (component == 0)
        {
            if (pickerView == self.homeTeamPicker)
            {
                count = [[[[self appDelegate] clubRepo] fetchClubs:nil] count];
            }
            else if (pickerView == self.awayTeamPicker)
            {
                count = [[[[self appDelegate] clubRepo] fetchClubs:nil] count];
            }
        }
        else if (component == 1)
        {
            Club* club;
            if (pickerView == self.homeTeamPicker)
            {
                //NSInteger selectedRow = [self.homeTeamPicker selectedRowInComponent:0];
                //club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
                //count = [club.teams count];
                if (selectedHomeClub != nil)
                {
                    count = [[selectedHomeClub teams] count];
                }
            }
            else if (pickerView == self.awayTeamPicker)
            {
                //NSInteger selectedRow = [self.awayTeamPicker selectedRowInComponent:0];
                //club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
                //count = [club.teams count];
                if (selectedAwayClub != nil)
                {
                    count = [[selectedAwayClub teams] count];
                }
            }
        }
    }
    
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString* title = @"";
    if (pickerView == self.homeTeamPicker || pickerView == self.awayTeamPicker)
    {
        if (component == 0)
        {
            Club* club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:row];
            title = club.name;
        
        }
        else if (component == 1)
        {
            Club* club;
            NSArray* teams;
            NSSortDescriptor* nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            if (pickerView == self.homeTeamPicker)
            {
                //NSInteger selectedRow = [self.homeTeamPicker selectedRowInComponent:0];
                //club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
                if (selectedHomeClub != nil)
                {
                    teams = [selectedHomeClub.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]];
                }
            }
            else if (pickerView == self.awayTeamPicker)
            {
                //NSInteger selectedRow = [self.awayTeamPicker selectedRowInComponent:0];
                //club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
                if (selectedAwayClub != nil)
                {
                    teams = [selectedAwayClub.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]];
                }
            }
            
            //Team* team = [[club.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]] objectAtIndex:row];
            Team* team = [teams objectAtIndex:row];
            title = team.name;
            [nameSort release];
        }
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.homeTeamPicker || pickerView == self.awayTeamPicker)
    {
        if (component == 0)
        {
            if (pickerView == self.homeTeamPicker)
            {
                selectedHomeClub = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:row];
                [self.homeTeamPicker reloadComponent:1];
                [self pickerView:self.homeTeamPicker didSelectRow:0 inComponent:1];
            }
            else if (pickerView == self.awayTeamPicker)
            {
                selectedAwayClub = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:row];
                [self.awayTeamPicker reloadComponent:1];
                [self pickerView:self.awayTeamPicker didSelectRow:0 inComponent:1];
            }
        }
    
        else if (component == 1)
        {
            NSSortDescriptor* nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            if (pickerView == self.homeTeamPicker)
            {
                if (selectedHomeClub != nil && [selectedHomeClub.teams count] > 0)
                {
                    selectedHomeTeam = [[selectedHomeClub.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]] objectAtIndex:row];
                }
                else
                {
                    selectedHomeTeam = nil;
                }
                NSLog(@"Setting selected home team: %@ - %@", selectedHomeTeam.club.name, selectedHomeTeam.name);
            }
            else if (pickerView == self.awayTeamPicker)
            {
                if (selectedAwayClub != nil && [selectedAwayClub.teams count] > 0)
                {
                    selectedAwayTeam = [[selectedAwayClub.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]] objectAtIndex:row];
                }
                else
                {
                    selectedAwayTeam = nil;
                }
                NSLog(@"Setting selected away team: %@ - %@", selectedAwayTeam.club.name, selectedAwayTeam.name);
            }
            [nameSort release];
        }
    }
}


- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{
    NSLog(@"Selected Home Team: %@ - %@", selectedHomeTeam.club.name, selectedHomeTeam.name);
    NSLog(@"Selected Away Team: %@ - %@", selectedAwayTeam.club.name, selectedAwayTeam.name);
    
    Match* match = self.match;
    if (match == nil)
    {
        match = [NSEntityDescription insertNewObjectForEntityForName:@"Match" inManagedObjectContext:[self repo].managedObjectContext];
        [match createMatchParticipantsWithRepository:[self repo] homeTeam:selectedHomeTeam awayTeam:selectedAwayTeam];
    
        Round* round = [NSEntityDescription insertNewObjectForEntityForName:@"Round" inManagedObjectContext:[self repo].managedObjectContext];
        match.round = round;
        [round addMatchesObject:match];
    }
    NSDate* date = [self.datePicker date];

    if (self.roundPickerController.selectedRound != nil)
    {
        match.round = self.roundPickerController.selectedRound;
    }
    else
    {
        match.round.number = [NSNumber numberWithInt:[[self.roundTextField text] integerValue]];
        match.round.date = date;
    }
    match.date = date;
    
    [[self repo] saveContext];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) editRoundClicked:(id)sender
{
    CGRect pvFrame = CGRectMake(0.0, 0.0, 700, 250);
    UIPickerView* picker = [[UIPickerView alloc] initWithFrame:pvFrame];
    picker.showsSelectionIndicator = YES;
    //RoundPickerViewController* rpvc = [[RoundPickerViewController alloc] initWithMatch:self.match andPicker:picker];
    picker.dataSource = self.roundPickerController;
    picker.delegate = self.roundPickerController;
    self.roundPickerController.match = self.match;
    self.roundPickerController.roundPicker = picker;
    [self.roundPickerController viewWillAppear:YES];
    self.roundPickerController.contentSizeForViewInPopover = CGSizeMake(picker.frame.size.width, picker.frame.size.height);
    
    CGRect frame = CGRectMake(0.0, 0.0, picker.frame.size.width, picker.frame.size.height);
    UIView* popOverView = [[UIView alloc] initWithFrame:frame];
    [popOverView addSubview:picker];
    
    self.roundPickerController.view = popOverView;
    self.popOver = [[UIPopoverController alloc] initWithContentViewController:self.roundPickerController];
    self.popOver.delegate = self;
    
    [self.popOver presentPopoverFromRect:self.editRoundButton.frame inView:self.fixtureDetailsView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    //[rpvc release];
    [popOverView release];
}

- (IBAction) editDateClicked:(id)sender
{
    UIViewController* popoverContentContoller = [[UIViewController alloc] init];
    CGRect frame = CGRectMake(0.0, 0.0, self.datePicker.frame.size.width, self.datePicker.frame.size.height);
    UIView* popOverView = [[UIView alloc] initWithFrame:frame];
    popoverContentContoller.view = popOverView;
    
    [popOverView addSubview:self.datePicker];
    
    popoverContentContoller.contentSizeForViewInPopover = CGSizeMake(self.datePicker.frame.size.width, self.datePicker.frame.size.height);
    
    self.popOver = [[UIPopoverController alloc] initWithContentViewController:popoverContentContoller];
    self.popOver.delegate = self;
    
    [self.popOver presentPopoverFromRect:self.editDateButton.frame inView:self.fixtureDetailsView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    [popOverView release];
    [popoverContentContoller release];
}

- (IBAction) editHomeTeamClicked:(id)sender
{
    
    UIViewController* popoverContentContoller = [[UIViewController alloc] init];
    CGRect frame = CGRectMake(0.0, 0.0, self.homeTeamPicker.frame.size.width, self.homeTeamPicker.frame.size.height);
    UIView* popOverView = [[UIView alloc] initWithFrame:frame];
    popoverContentContoller.view = popOverView;

    [popOverView addSubview:self.homeTeamPicker];
    
    popoverContentContoller.contentSizeForViewInPopover = CGSizeMake(self.homeTeamPicker.frame.size.width, self.homeTeamPicker.frame.size.height);
    
    self.popOver = [[UIPopoverController alloc] initWithContentViewController:popoverContentContoller];
    self.popOver.delegate = self;
    
    [self.popOver presentPopoverFromRect:self.editHomeTeamButton.frame inView:self.fixtureDetailsView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    [popOverView release];
    [popoverContentContoller release];
}

- (IBAction) editAwayTeamClicked:(id)sender
{
    UIViewController* popoverContentContoller = [[UIViewController alloc] init];
    CGRect frame = CGRectMake(0.0, 0.0, self.awayTeamPicker.frame.size.width, self.awayTeamPicker.frame.size.height);
    UIView* popOverView = [[UIView alloc] initWithFrame:frame];
    popoverContentContoller.view = popOverView;
    
    [popOverView addSubview:self.awayTeamPicker];
    
    popoverContentContoller.contentSizeForViewInPopover = CGSizeMake(self.awayTeamPicker.frame.size.width, self.awayTeamPicker.frame.size.height);
    
    self.popOver = [[UIPopoverController alloc] initWithContentViewController:popoverContentContoller];
    self.popOver.delegate = self;
    
    [self.popOver presentPopoverFromRect:self.editAwayTeamButton.frame inView:self.fixtureDetailsView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    [popOverView release];
    [popoverContentContoller release];
    
}



-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if ([[popoverController contentViewController] isKindOfClass:[RoundPickerViewController class]])
    {
        if (self.roundPickerController.selectedRound != nil)
        {
            self.roundLabel.text = [self.roundPickerController.selectedRound.number stringValue];
        }
    }
    else if ([popoverController contentViewController].view.subviews[0] == self.homeTeamPicker)
    {
        NSLog(@"homeTeamPicker");
        if (selectedHomeClub != nil)
        {
            self.homeTeamLabel.text = selectedHomeClub.name;
        }
    }
    else if ([popoverController contentViewController].view.subviews[0] == self.awayTeamPicker)
    {
        NSLog(@"awayTeamPicker");
        if (selectedAwayClub != nil)
        {
            self.awayTeamLabel.text = selectedAwayClub.name;
        }
    }
    else if ([popoverController contentViewController].view.subviews[0] == self.datePicker)
    {
        NSLog(@"datePicker");
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE dd MMM yyyy hh:mm aa"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-3540]];
        NSString* dateLabel = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.datePicker.date]];
        self.dateLabel.text = dateLabel;
    }
    else
    {
        NSLog(@"Unknown poperController");
    }
    
    NSString* divisionLabel = nil;
    if (self.roundPickerController.selectedRound != nil && self.roundPickerController.selectedRound.season.division.name != nil)
    {
        divisionLabel = [NSString stringWithFormat:@"%@ - %@", self.roundPickerController.selectedRound.season.division.name,  selectedHomeTeam.name];
    }
    else
    {
        if (selectedHomeTeam != nil)
        {
            divisionLabel = selectedHomeTeam.name;
        }
        else if (selectedAwayTeam != nil)
        {
            divisionLabel = selectedAwayTeam.name;
        }
    }
    
    if (divisionLabel != nil)
    {
        self.divisionLabel.text = divisionLabel;
    }
}

@end
