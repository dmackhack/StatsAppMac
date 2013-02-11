//
//  StatsCell.m
//  StatsAppMac
//
//  Created by David MacKenzie on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StatsCell.h"

@implementation StatsCell

@synthesize playerParticipant=playerParticipant_, playerName=playerName_, kicksLabel=kicksLabel_, marksLabel=marksLabel_, handballsLabel=handballsLabel_, tacklesLabel=tacklesLabel_;

- (StatsAppMacAppDelegate*) appDelegate
{
    return (StatsAppMacAppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (SqlLiteRepository*) repo
{
    return (SqlLiteRepository*)[[self appDelegate] repo];
}


- (FootyPlayerStatistics*) playerStatistics
{
    if ([[self playerParticipant] participantStatistics] == nil)
    {
        [[self playerParticipant] createFootyPlayerStatisticsToParticipantWithRepository:self.repo];
    }
    return (FootyPlayerStatistics*)[[self playerParticipant] participantStatistics];
}

-(void)dealloc
{
    [playerParticipant_ release];
    [playerName_ release];
    [kicksLabel_ release];
    [marksLabel_ release];
    [handballsLabel_ release];
    [tacklesLabel_ release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)addKick:(id)sender 
{
    int value = [self.playerStatistics.kicks intValue];
    self.playerStatistics.kicks = [NSNumber numberWithInt:value + 1];
    [self reloadData];
    NSLog(@"kick event recieved for %@: %i", self.playerParticipant.player.firstName, [self.playerStatistics.kicks intValue]);
}

- (IBAction)addMark:(id)sender 
{
    int value = [self.playerStatistics.marks intValue];
    self.playerStatistics.marks = [NSNumber numberWithInt:value + 1];
    [self reloadData];
    NSLog(@"mark event recieved for %@: %i", self.playerParticipant.player.firstName, [self.playerStatistics.marks intValue]);
}

- (IBAction)addHandball:(id)sender 
{
    int value = [self.playerStatistics.handballs intValue];
    self.playerStatistics.handballs = [NSNumber numberWithInt:value + 1];
    [self reloadData];
    NSLog(@"handball event recieved for %@: %i", self.playerParticipant.player.firstName, [self.playerStatistics.handballs intValue]);
}

- (IBAction)addTackle:(id)sender 
{
    int value = [self.playerStatistics.tackles intValue];
    self.playerStatistics.tackles = [NSNumber numberWithInt:value + 1];
    [self reloadData];
    NSLog(@"tackle event recieved for %@: %i", self.playerParticipant.player.firstName, [self.playerStatistics.tackles intValue]);
}

- (void) styleLabels
{
    self.kicksLabel.backgroundColor = [UIColor clearColor];
    self.kicksLabel.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.kicksLabel.layer.borderWidth = 1.0;
    
    self.handballsLabel.backgroundColor = [UIColor clearColor];
    self.handballsLabel.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.handballsLabel.layer.borderWidth = 1.0;
    
    self.tacklesLabel.backgroundColor = [UIColor clearColor];
    self.tacklesLabel.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.tacklesLabel.layer.borderWidth = 1.0;
    
    self.marksLabel.backgroundColor = [UIColor clearColor];
    self.marksLabel.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.marksLabel.layer.borderWidth = 1.0;
}

- (void) reloadData
{
    [self styleLabels];
    
    
    self.playerName.text = [NSString stringWithFormat:@"%@", [self.playerParticipant.player displayName]];
    self.kicksLabel.text = [self.playerStatistics.kicks stringValue];
    self.marksLabel.text = [self.playerStatistics.marks stringValue];
    self.handballsLabel.text = [self.playerStatistics.handballs stringValue];
    self.tacklesLabel.text = [self.playerStatistics.tackles stringValue];
}


@end
