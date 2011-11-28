//
//  StatsCell.m
//  StatsAppMac
//
//  Created by David MacKenzie on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StatsCell.h"

@implementation StatsCell

@synthesize player=player_, playerName=playerName_;

-(void)dealloc
{
    [player_ release];
    [playerName_ release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addKick:(id)sender 
{
    
    int value = [self.player.kicks intValue];
    NSNumber* newValue = [NSNumber numberWithInt:value + 1];
    self.player.kicks = newValue;
    
    NSLog(@"kick event recieved: %i", [newValue intValue]);
}

- (IBAction)addMark:(id)sender 
{
    int value = [self.player.marks intValue];
    self.player.marks = [NSNumber numberWithInt:value + 1];
}

- (IBAction)addHandball:(id)sender 
{
    int value = [self.player.handballs intValue];
    self.player.handballs = [NSNumber numberWithInt:value + 1];
}

- (IBAction)addTackle:(id)sender 
{
    int value = [self.player.tackles intValue];
    self.player.tackles = [NSNumber numberWithInt:value + 1];
}
@end
