//
//  FixtureSearchDelegate.m
//  StatsAppMac
//
//  Created by David Mackenzie on 11/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FixtureSearchDelegate.h"


@implementation FixtureSearchDelegate


- (StatsAppMacAppDelegate *) appDelegate
{
    return (StatsAppMacAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (StatsAppMacSession*) session
{
    return [[self appDelegate] session];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void) updateFixture;
{
    [self.tableView reloadData];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    int rows = 0;
    if ([[self session] selectedClub] != nil)
    {
        rows = [[[[self session] selectedClub] combinedClubFixture] count];
    }
    return rows;
}

- (void) addColumnToCell:(MultiColumnTableCell*)cell withStart:(int)start withWidth:(int)width withEnd:(int)end withText:(NSString*)text withHeight:(int)height
{
    UILabel* label = [[[UILabel alloc] initWithFrame:CGRectMake(start, 0, width, height)] autorelease];
    // draws a vertical line at the position specified by this value i.e. the end of the column
    [cell addColumn:end];
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = [NSString stringWithFormat:@"%@", text];
    label.textAlignment = UITextAlignmentLeft;
    label.textColor = [UIColor blueColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    UIViewAutoresizingFlexibleHeight;
    [cell.contentView addSubview:label];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MultiColumnCell";
    
    MultiColumnTableCell *cell = (MultiColumnTableCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MultiColumnTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        [cell initialize];
        
        Match* match = [[[[self session] selectedClub] combinedClubFixture] objectAtIndex:indexPath.row];
        NSArray* participants = [[match participants] allObjects];
        
        NSString* label1 = [[match date] description];
        NSString* label2 = [[[self session] selectedClub] name];
        NSString* label3 = @"N/A";
        
        if ([participants count] == 2)
        {
            TeamParticipant* team1 = [participants objectAtIndex:0];
            TeamParticipant* team2 = [participants objectAtIndex:1];
                
            label2 = [[[team1 team] club] name];
            label3 = [[[team2 team] club] name];
        }
        
        // CGRectMake(x, y, width, height)
        int margin = 10;
        int col1start=0.0;
        int col1width=90;
        int col1end=col1start+col1width+margin;
        [self addColumnToCell:cell withStart:col1start withWidth:col1width withEnd:col1end withText:label1 withHeight:tableView.rowHeight];
        
        int col2start=col1end+margin;
        int col2width=220;
        int col2end=col2start+col2width+margin;
        [self addColumnToCell:cell withStart:col2start withWidth:col2width withEnd:col2end withText:label2 withHeight:tableView.rowHeight];
        
        int col3start=col2end+margin;
        int col3width=220;
        int col3end=col3start+col3width+margin;
        [self addColumnToCell:cell withStart:col3start withWidth:col3width withEnd:col3end withText:label3 withHeight:tableView.rowHeight];
    }
    
    //cell.textLabel.text = [NSString stringWithFormat:@"Fixture Game One for %@", self.selectedClub.name];
    
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
    
    Match* match = [[[[self session] selectedClub] combinedClubFixture] objectAtIndex:indexPath.row];
    [self session].selectedMatch = match;
    
    NSLog(@"selected match date: %@", [[match date] description]);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSLog(@"Section %i", section);
    if (section == 0)
    {
        NSLog(@"Setting section header to FIXTURE");
        return @"FIXTURE";
    }
    else
    {
        NSLog(@"Setting section header to ");
        return @"";
    }
}

@end
