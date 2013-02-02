//
//  StatsAppMacNotificationCentre.m
//  StatsAppMac
//
//  Created by David Mackenzie on 2/02/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "StatsAppMacNotificationCentre.h"



@implementation StatsAppMacNotificationCentre

@synthesize selectedClubForEditChangedListeners=selectedClubForEditChangedListeners_;


- (id)init
{
    NSLog(@"init 1");
    self = [super init];
    if (self)
    {
        NSLog(@"init 2");
        selectedClubForEditChangedListeners_ = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void) addSelectClubForEditChangeListener:(id<SelectedClubForEditChangedListener>) listener
{
    NSLog(@"Adding change listener 1");
    if (self.selectedClubForEditChangedListeners != nil)
    {
        NSLog(@"Adding change listener 2");
        [self.selectedClubForEditChangedListeners addObject:listener];
    }
}

- (void) removeSelectClubForEditChangeListener:(id<SelectedClubForEditChangedListener>) listener
{
    if (self.selectedClubForEditChangedListeners != nil)
    {
        [self.selectedClubForEditChangedListeners removeObject:listener];
    }
}


- (void)onChange
{
    NSLog(@"onChange 1");
    if (self.selectedClubForEditChangedListeners != nil)
    {
        NSLog(@"onChange 2");
        for (id <SelectedClubForEditChangedListener> listener in self.selectedClubForEditChangedListeners)
        {
            NSLog(@"onChange 3");
            [listener onChange];
        }
    }
}


- (void) dealloc
{
    [selectedClubForEditChangedListeners_ release];
    [super dealloc];
}

@end
