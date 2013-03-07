//
//  StatsCell.m
//  StatsAppMac
//
//  Created by David MacKenzie on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StatsCell.h"

@implementation StatsCell

@synthesize playerParticipant=playerParticipant_, playerName=playerName_, kicksLabel=kicksLabel_, marksLabel=marksLabel_, handballsLabel=handballsLabel_, tacklesLabel=tacklesLabel_, goalsLabel=goalsLabel_, behindsLabel=behindsLabel_, totalScoreLabel=totalScoreLabel_, statChangedListener=statChangedListener_;


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
    [goalsLabel_ release];
    [behindsLabel_ release];
    [totalScoreLabel_ release];
    
    [statChangedListener_ release];
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

- (IBAction)addBehind:(id)sender 
{
    int value = [self.playerStatistics.behinds intValue];
    self.playerStatistics.behinds = [NSNumber numberWithInt:value + 1];
    [self reloadData];
    NSLog(@"behind event recieved for %@: %i", self.playerParticipant.player.firstName, [self.playerStatistics.behinds intValue]);
}

- (IBAction)addGoal:(id)sender 
{
    int value = [self.playerStatistics.goals intValue];
    self.playerStatistics.goals = [NSNumber numberWithInt:value + 1];
    [self reloadData];
    NSLog(@"goal event recieved for %@: %i", self.playerParticipant.player.firstName, [self.playerStatistics.goals intValue]);
}

- (void) styleLabel:(UILabel*)label
{
    label.backgroundColor = [UIColor clearColor];
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
    label.layer.borderWidth = 1.0;
}

- (void) styleLabels
{
    [self styleLabel:self.kicksLabel];
    [self styleLabel:self.handballsLabel];
    [self styleLabel:self.tacklesLabel];
    [self styleLabel:self.marksLabel];
    [self styleLabel:self.goalsLabel];
    [self styleLabel:self.behindsLabel];
    [self styleLabel:self.totalScoreLabel];
}



- (void) reloadData
{
    [self styleLabels];
    
    
    self.playerName.text = [NSString stringWithFormat:@"%@", [self.playerParticipant.player displayName]];
    self.kicksLabel.text = [self.playerStatistics.kicks stringValue];
    self.marksLabel.text = [self.playerStatistics.marks stringValue];
    self.handballsLabel.text = [self.playerStatistics.handballs stringValue];
    self.tacklesLabel.text = [self.playerStatistics.tackles stringValue];
    self.goalsLabel.text = [[[self playerStatistics] goals] stringValue];
    self.behindsLabel.text = [[[self playerStatistics] behinds] stringValue];
    self.totalScoreLabel.text = [[[self playerStatistics] totalScore] stringValue];
    
    [self onStatChangedPerformed];
}


- (void) onStatChangedPerformed
{
    if (self.statChangedListener != nil)
    {
        [self.statChangedListener onStatChanged];        
    }
}


@end
