//
//  SelectTeamViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 5/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectTeamViewController.h"


@implementation SelectTeamViewController

@synthesize availablePlayersTableView=availablePlayersTableView_, selectedTeamTableView=selectedTeamTableView_, checkedAvailablePlayers=checkedAvailablePlayers_, checkedSelectedPlayers=checkedSelectedPlayers_, availablePlayers=availablePlayers_, selectedPlayers=selectedPlayers_;

- (StatsAppMacAppDelegate*) appDelegate
{
    return (StatsAppMacAppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (StatsAppMacSession*) session
{
    return [[self appDelegate] session];
}

- (TeamParticipant*) selectedTeamParticipant
{
    return [[self session] selectedTeamParticipant];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) reloadData
{
    [self.checkedAvailablePlayers removeAllObjects];
    [self.checkedSelectedPlayers removeAllObjects];

    [self.availablePlayers removeAllObjects];
    [self.availablePlayers addObjectsFromArray:[[[self session] selectedClub] currentPlayers]];
    
    [self.selectedPlayers removeAllObjects];
    //[self.selectedPlayers addObjectsFromArray:[[[self selectedTeamParticipant] playerParticipants] allObjects]];
    [self.selectedPlayers addObjectsFromArray:[[self selectedTeamParticipant] playerParticipantsByLastName]];
    
    [[self availablePlayersTableView] reloadData];
    [[self selectedTeamTableView] reloadData];
}

- (void)dealloc
{
    [availablePlayersTableView_ release];
    [selectedTeamTableView_ release];
    [checkedAvailablePlayers_ release];
    [checkedSelectedPlayers_ release];
    [selectedPlayers_ release];
    [availablePlayers_ release];
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
    if (self.checkedAvailablePlayers == nil)
    {
        self.checkedAvailablePlayers = [[NSMutableArray alloc] init];
    }
    if (self.checkedSelectedPlayers == nil)
    {
        self.checkedSelectedPlayers = [[NSMutableArray alloc] init];
    }
    if (self.availablePlayers == nil)
    {
        self.availablePlayers = [[NSMutableArray alloc] init];
    }
    if (self.selectedPlayers == nil)
    {
        self.selectedPlayers = [[NSMutableArray alloc] init];
    }
    
    //UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(next:)];
    //UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(next:)];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Take Stats" style:UIBarButtonItemStylePlain target:self action:@selector(next:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    
    [anotherButton release];
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
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back2" style:UIBarButtonItemStylePlain target:nil action:nil];
    NSLog(@"View contollers: %i",[[self.navigationController viewControllers] count]);
    self.navigationItem.hidesBackButton = NO;
    UIBarButtonItem* backButton = self.navigationItem.backBarButtonItem;
    if (backButton == nil)
    {
        NSLog(@"back is nil");
    }
    else
    {
        NSLog(@"back is NOT nil [%@]", backButton.title);
    }
    
    [self reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // save the players.
    NSLog(@"Clear checked lists");
    [self reloadData];
    
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    if (tableView == self.availablePlayersTableView)
    {
        count = [[self availablePlayers] count];
        NSLog(@"Number of available players: %i", count);
    }
    else
    {
        count = [[self selectedPlayers] count];
        NSLog(@"Number of selected players: %i", count);
    }
    
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    if (tableView == self.availablePlayersTableView)
    {
        static NSString *CellIdentifier = @"AvailablePlayerCell";
        cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if ([self.checkedAvailablePlayers containsObject:indexPath])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (cell == nil) 
        {
            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];      
        }
        Player* player = [[self availablePlayers] objectAtIndex:indexPath.row];
        cell.textLabel.text = [player displayName];
    }
    else
    {
        static NSString *CellIdentifier = @"SelectedPlayerCell";
        cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if ([self.checkedSelectedPlayers containsObject:indexPath])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (cell == nil) 
        {
            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        PlayerParticipant* participant = [[self selectedPlayers] objectAtIndex:indexPath.row];
        cell.textLabel.text = [[participant player] displayName];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (tableView == self.availablePlayersTableView)
    {
        if (cell.accessoryType == UITableViewCellAccessoryNone) 
        {
            [self.checkedAvailablePlayers addObject:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } 
        else 
        {
            [self.checkedAvailablePlayers removeObject:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    if (tableView == self.selectedTeamTableView)
    {
        if (cell.accessoryType == UITableViewCellAccessoryNone) 
        {
            [self.checkedSelectedPlayers addObject:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } 
        else 
        {
            [self.checkedSelectedPlayers removeObject:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == [self availablePlayersTableView])
    {
        return @"Available Players";
    }
    else
    {
        return @"Selected Players";
    }
}

- (IBAction)addPlayersToTeam:(id)sender
{
    NSLog(@"Add the following players: %@ ", [self checkedAvailablePlayers]);
    SqlLiteRepository* repo = [[self appDelegate] repo];   
    for (NSIndexPath* index in [self checkedAvailablePlayers])
    {
        Player* player = [[self availablePlayers] objectAtIndex:index.row];
        NSLog(@"Add the following player: %@ ", [player displayName]);
        
        [[self selectedTeamParticipant] addPlayerToTeamParticipant:player withRepository:repo];
    }
    [repo saveContext];
    [self reloadData];
}

- (IBAction)removePlayersFromTeam:(id)sender
{
    NSLog(@"Remove the following players: %@ ", [self checkedSelectedPlayers]);
    SqlLiteRepository* repo = [[self appDelegate] repo];   
    NSMutableArray* toRemove = [[NSMutableArray alloc] init];
    for (NSIndexPath* index in [self checkedSelectedPlayers])
    {
        PlayerParticipant* participant = [[[[self selectedTeamParticipant] playerParticipants] allObjects] objectAtIndex:index.row];
        [toRemove addObject:participant];
    }
    for (PlayerParticipant* participant in toRemove)
    {
        NSLog(@"Removing the following player: %@ ", [participant.player displayName]);
        [[self selectedTeamParticipant] removePlayerParticipantsObject:participant];
    }
    [toRemove release];
    [repo saveContext];
    [self reloadData];
}

- (IBAction)next:(id)sender
{
    GameDayStatsViewController* statsView = [[GameDayStatsViewController alloc] initWithNibName:@"GameDayStatsViewController" bundle:nil];    
    [self.navigationController pushViewController:statsView animated:YES];
    [statsView release];

}

@end
