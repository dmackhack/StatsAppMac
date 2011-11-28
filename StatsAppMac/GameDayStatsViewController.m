//
//  GameDayStatsViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 25/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameDayStatsViewController.h"


@implementation GameDayStatsViewController

@synthesize managedObjectContext=managedObjectContext_, players=players_;

- (void)dealloc
{
    [managedObjectContext_ release];
    [players_ release];
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
    
    self.players = [[NSMutableArray alloc] init];
    
    Player* a = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.managedObjectContext];
    a.firstName = @"David";
    a.lastName = @"Mackenzie";
    
    Player* b = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.managedObjectContext];
    b.firstName = @"Michelle";
    b.lastName = @"Keane";
    
    [self.players addObject:a];
    [self.players addObject:b];
    
    NSLog(@"Number of players in load %i", [self.players count]);

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
    NSLog(@"Number of players %i", [self.players count]);
    return [self.players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StatsCell";
    static NSString *CellNib = @"StatsCell";
    
    StatsCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        StatsCell* statsCellViewController = [[StatsCell alloc] init];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:statsCellViewController options:nil];
        cell = (StatsCell *)[nib objectAtIndex:0];
        
        /*NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"StatsCell" owner:nil options:nil];
        
        for (id currentObject in array)
        {
            if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (StatsCell*) currentObject;
                break;
            }
        }*/
        
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        
        
        //StatsCell* statsView = [[StatsCell alloc] initWithNibName:@"StatsCell" bundle:nil];
        
        
        //[cell.contentView addSubview:statsView.view];
        
        //[statsView release];
    }
    
    
    
    // Configure the cell...
    Player* theOne = [self.players objectAtIndex:indexPath.row];
    
    if ([cell isKindOfClass:[StatsCell class]])
    {
        NSLog(@"Found StatsCell: %@", [cell.class description]);
        cell.player = theOne;
        cell.playerName.text = [NSString stringWithFormat:@"%@, %@", theOne.lastName, theOne.firstName];
    }
    else
    { 
        NSLog(@"INVALID cell class: %@", [cell.class description]);
    }
    
    /*StatsCell* statsView;
    for (id currentView in cell.contentView.subviews)
    {
        if ([currentView isKindOfClass:[StatsCell class]])
        {
            statsView = (StatsCell*) currentView;
            break;
        }
    }
    
    if (statsView != nil)
    {
        statsView.player = theOne;
        statsView.playerName.text = [NSString stringWithFormat:@"%@, %@", theOne.lastName, theOne.firstName];
    }
    else
    {
        cell.textLabel.text = @"no player";
    }*/
    //cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", theOne.lastName, theOne.firstName];
    
    
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
