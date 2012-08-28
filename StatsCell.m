//
//  StatsCell.m
//  StatsAppMac
//
//  Created by David MacKenzie on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StatsCell.h"

@implementation StatsCell

@synthesize player=player_, playerName=playerName_, kicksLabel=kicksLabel_, marksLabel=marksLabel_, handballsLabel=handballsLabel_, tacklesLabel=tacklesLabel_;



-(void)dealloc
{
    [player_ release];
    [playerName_ release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)addKick:(id)sender 
{
    int value = [self.player.kicks intValue];
    self.player.kicks = [NSNumber numberWithInt:value + 1];
    [self reloadData];
    NSLog(@"kick event recieved for %@: %i", self.player.firstName, [self.player.kicks intValue]);
}

- (IBAction)addMark:(id)sender 
{
    int value = [self.player.marks intValue];
    self.player.marks = [NSNumber numberWithInt:value + 1];
    [self reloadData];
    NSLog(@"mark event recieved for %@: %i", self.player.firstName, [self.player.marks intValue]);
}

- (IBAction)addHandball:(id)sender 
{
    int value = [self.player.handballs intValue];
    self.player.handballs = [NSNumber numberWithInt:value + 1];
    [self reloadData];
    NSLog(@"handball event recieved for %@: %i", self.player.firstName, [self.player.handballs intValue]);
}

- (IBAction)addTackle:(id)sender 
{
    int value = [self.player.tackles intValue];
    self.player.tackles = [NSNumber numberWithInt:value + 1];
    [self reloadData];
    NSLog(@"tackle event recieved for %@: %i", self.player.firstName, [self.player.tackles intValue]);
}

- (void) reloadData
{
    self.playerName.text = [NSString stringWithFormat:@"%@, %@", self.player.lastName, self.player.firstName];
    self.kicksLabel.text = [self.player.kicks stringValue];
    self.marksLabel.text = [self.player.marks stringValue];
    self.handballsLabel.text = [self.player.handballs stringValue];
    self.tacklesLabel.text = [self.player.tackles stringValue];
}


@end
