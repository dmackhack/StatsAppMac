//
//  GameDayStatsViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 25/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameDayStatsViewController.h"


@implementation GameDayStatsViewController


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
    
    // fetch players
    int count = 0;
    if ([self selectedPlayerParticipants] != nil)
    {
        count = [[self selectedPlayerParticipants] count];
    }
        
    NSLog(@"Number of players in viewDidLoad %i", count);
    
    
    //CGRect fullScreenRect = [[UIScreen mainScreen] applicationFrame];
    

    //self.scrollView.contentSize = CGSizeMake(fullScreenRect.size.width * 3, fullScreenRect.size.height);
    //self.scrollView.contentSize.height = fullScreenRect.size.height;
    //self.scrollView.contentSize.width = fullScreenRect.size.width * 3;
    
    //self.scrollView = 
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

@end
