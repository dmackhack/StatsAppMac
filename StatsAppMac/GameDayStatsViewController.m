//
//  GameDayStatsViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 25/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameDayStatsViewController.h"


@implementation GameDayStatsViewController

@synthesize roundLabel=roundLabel_, dateLabel=dateLabel_, divisionLabel=divisionLabel_, homeTeamLabel=homeTeamLabel_, awayTeamLabel=awayTeamLabel_, statsTableView=statsTableView_, homeGoals=homeGoals_, homeBehinds=homeBehinds_, homeTotalScore=homeTotalScore_, awayGoals=awayGoals_, awayBehinds=awayBehinds_, awayTotalScore=awayTotalScore_;

- (StatsAppMacAppDelegate *) appDelegate
{
    return (StatsAppMacAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (StatsAppMacSession*) session
{
    return [[self appDelegate] session];
}

- (TeamParticipant*) selectedTeamParticipant
{
    return [[self session] selectedTeamParticipant];
}

- (Match*) selectedMatch
{
    return [[self session] selectedMatch];
}

- (NSArray*) selectedPlayerParticipants
{
    if ([self selectedTeamParticipant] != nil)
    {
        return [[self selectedTeamParticipant] playerParticipantsByLastName];
    }
    return nil;
}


- (void)dealloc
{
    [roundLabel_ release];
    [dateLabel_ release];
    [divisionLabel_ release];
    [homeTeamLabel_ release];
    [awayTeamLabel_ release];
    [statsTableView_ release];
    [homeGoals_ release];
    [homeBehinds_ release];
    [homeTotalScore_ release];
    [awayGoals_ release];
    [awayBehinds_ release];
    [awayTotalScore_ release];
    
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
    
    //CGRect fullScreenRect = [[UIScreen mainScreen] applicationFrame];
    

    //self.scrollView.contentSize = CGSizeMake(fullScreenRect.size.width * 3, fullScreenRect.size.height);
    //self.scrollView.contentSize.height = fullScreenRect.size.height;
    //self.scrollView.contentSize.width = fullScreenRect.size.width * 3;
    
    //self.scrollView = 
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIBarButtonItem* editFixutreButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editFixture:)];
    UIBarButtonItem* selectTeamButton = [[UIBarButtonItem alloc] initWithTitle:@"Select Team" style:UIBarButtonItemStylePlain target:self action:@selector(selectTeam:)];
    
    self.navigationItem.rightBarButtonItems = [[NSMutableArray alloc] initWithObjects: selectTeamButton, editFixutreButton, nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    self.navigationItem.title = @"Match Statistics";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) updateScore
{
    TeamParticipant* homeTeam = [[self selectedMatch] homeTeam];
    TeamParticipant* awayTeam = [[self selectedMatch] awayTeam];
    self.homeGoals.text = [[homeTeam teamGoals] stringValue];
    self.homeBehinds.text = [[homeTeam teamBehinds] stringValue];
    self.homeTotalScore.text = [[homeTeam teamScore] stringValue];
    
    self.awayGoals.text = [[awayTeam teamGoals] stringValue];
    self.awayBehinds.text = [[awayTeam teamBehinds] stringValue];
    self.awayTotalScore.text = [[awayTeam teamScore] stringValue];
}

- (void)refreshData
{
    if ([self selectedMatch] != nil)
    {
        TeamParticipant* homeTeam = [[self selectedMatch] homeTeam];
        TeamParticipant* awayTeam = [[self selectedMatch] awayTeam];
        self.roundLabel.text = [NSString stringWithFormat:@"%@",  [[[self selectedMatch] round] number]];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE dd MMM yyyy hh:mm aa"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-3540]];
        NSString* dateLabel = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[[self selectedMatch] date]]];
        self.dateLabel.text = dateLabel;
        if ([self selectedMatch].round.season.division.name == nil)
        {
            self.divisionLabel.text = [[self selectedMatch] homeTeam].team.name;
        }
        else
        {
            self.divisionLabel.text = [NSString stringWithFormat:@"%@ - %@", [self selectedMatch].round.season.division.name,  [[self selectedMatch] homeTeam].team.name];
        }
        self.homeTeamLabel.text = [[[homeTeam team] club] name];
        self.awayTeamLabel.text = [[[awayTeam team] club] name];
        
        [self updateScore];
        
    } 
    
    [self.statsTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // fetch players
    int count = 0;
    if ([self selectedPlayerParticipants] != nil)
    {
        count = [[self selectedPlayerParticipants] count];
    }
    NSLog(@"Number of players in viewWillAppear %i", count);
    
    [self refreshData];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // save the players.
    NSLog(@"Saving players");
    StatsAppMacAppDelegate* delegate = self.appDelegate;
    [[delegate repo] saveContext];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int count = 0;
    if ([self selectedPlayerParticipants] != nil)
    {
        count = [[self selectedPlayerParticipants] count];
    }
    NSLog(@"Number of players in table %i", count);
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StatsCell";
    static NSString *CellNib = @"StatsCell";
    
    StatsCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        StatsCell* statsCellViewController = [[StatsCell alloc] init];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:statsCellViewController options:nil];
        cell = (StatsCell *)[nib objectAtIndex:0];
    }
    
    // Configure the cell...
    PlayerParticipant* playerParticipant = nil;
    if ([self selectedPlayerParticipants] != nil)
    {
        playerParticipant = [[self selectedPlayerParticipants] objectAtIndex:indexPath.row];
    }
    
    if ([cell isKindOfClass:[StatsCell class]])
    {
        cell.playerParticipant = playerParticipant;
        cell.statChangedListener = self;
        [cell reloadData];
    }
    else
    { 
        NSLog(@"INVALID cell class: %@", [cell.class description]);
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self selectedTeamParticipant] != nil)
    {
        return [[[[self selectedTeamParticipant] team] club] name];
    }
    else
    {
        return @"%@";
    }
}

- (IBAction)selectTeam:(id)sender
{
    SelectTeamViewController* selectTeamView = [[SelectTeamViewController alloc] initWithNibName:@"SelectTeamViewController" bundle:nil];
    
    [self.navigationController pushViewController:selectTeamView animated:YES];
    
    //UINavigationController* modalNavBar = [[self appDelegate] modalNavBar];
    //[[[[self appDelegate] window] rootViewController] presentModalViewController:modalNavBar animated:YES];
    //[modalNavBar pushViewController:selectTeamView animated:YES];
    
    [selectTeamView release];
}

- (IBAction)editFixture:(id)sender
{
    EditFixtureViewController* editFixtureView = [[EditFixtureViewController alloc] initWithNibName:@"EditFixtureViewController" bundle:nil];
    editFixtureView.match = [self selectedMatch];
    
    //UINavigationController* modalNavBar = [[self appDelegate] modalNavBar];
    //[[[[self appDelegate] window] rootViewController] presentModalViewController:editFixtureView animated:YES];
    //[self.navigationController presentModalViewController:editFixtureView animated:YES];
    [self.navigationController pushViewController:editFixtureView animated:YES];
    
    [editFixtureView release];
}

- (IBAction)dismiss:(id)sender
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void) onStatChanged
{
    [self updateScore];
}

@end
