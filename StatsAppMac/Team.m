//
//  Team.m
//  StatsAppMac
//
//  Created by David Mackenzie on 15/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Team.h"
#import "Club.h"
#import "TeamParticipant.h"


@implementation Team
@dynamic name;
@dynamic club;
@dynamic teamParticipants;


- (void)addTeamParticipantsObject:(TeamParticipant *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"teamParticipants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"teamParticipants"] addObject:value];
    [self didChangeValueForKey:@"teamParticipants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeTeamParticipantsObject:(TeamParticipant *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"teamParticipants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"teamParticipants"] removeObject:value];
    [self didChangeValueForKey:@"teamParticipants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addTeamParticipants:(NSSet *)value {    
    [self willChangeValueForKey:@"teamParticipants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"teamParticipants"] unionSet:value];
    [self didChangeValueForKey:@"teamParticipants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeTeamParticipants:(NSSet *)value {
    [self willChangeValueForKey:@"teamParticipants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"teamParticipants"] minusSet:value];
    [self didChangeValueForKey:@"teamParticipants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
