//
//  GameDayStatsViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 25/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameDayStatsViewController.h"


@implementation GameDayStatsViewController

@synthesize cache=cache_;

- (void)dealloc
{
    [resultsController_ release];
    [cache_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (NSFetchedResultsController *) resultsController
{
    if (resultsController_ != nil)
    {
        return resultsController_;
    }
    
    StatsAppMacAppDelegate* appDelegate = self.appDelegate;
    SqlLiteRepository* repo = [appDelegate repo];
    
    NSManagedObjectContext* context = [repo managedObjectContext];
    NSFetchRequest* fetchPlayers = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* playerEntityDescription = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:context];
    [fetchPlayers setEntity:playerEntityDescription];
    
    // no predicate required. we are fetching everything
    
    //NSLog(@"Captured: %i", [self captured]);
    //NSLog(@"Cache: %@", [self cache]);
    
    //NSPredicate* fugitivesPredicate = [NSPredicate predicateWithFormat:@"captured == %i", captured_];
    //[fetchFugitives setPredicate:fugitivesPredicate];                                             
    
    NSSortDescriptor* playersSD = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
    [fetchPlayers setSortDescriptors:[NSArray arrayWithObject:playersSD]];
    
    resultsController_ = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchPlayers managedObjectContext:context sectionNameKeyPath:nil cacheName:[self cache]];
    
    resultsController_.delegate = self;
    
    NSError* error;
    BOOL success = [resultsController_ performFetch:&error];
    
    if (!success)
    {
        NSLog(@"Error fetching results");
    }
    [fetchPlayers release];
    return resultsController_;
    
}


- (StatsAppMacAppDelegate *) appDelegate
{
    return (StatsAppMacAppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // fetch players
    NSUInteger count = [[self.resultsController fetchedObjects] count];
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
    NSUInteger count = [[self.resultsController fetchedObjects] count];
    NSLog(@"Number of players in viewWillAppear %i", count);
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
    [delegate saveContext];
    
    
    //NSError *error = nil;
    //[self.managedObjectContext save:&error];
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
    NSLog(@"Number of players in table %i", [[self.resultsController fetchedObjects] count]);
    return [[self.resultsController fetchedObjects] count];
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
    if ([cell isKindOfClass:[StatsCell class]])
    {
        cell.player = [self.resultsController objectAtIndexPath:indexPath];
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
