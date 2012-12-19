//
//  TeamParticipant.m
//  StatsAppMac
//
//  Created by David Mackenzie on 19/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TeamParticipant.h"
#import "PlayerParticipant.h"
#import "Team.h"


@implementation TeamParticipant
@dynamic home;
@dynamic team;
@dynamic playerParticipants;


- (void)addPlayerParticipantsObject:(PlayerParticipant *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"playerParticipants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"playerParticipants"] addObject:value];
    [self didChangeValueForKey:@"playerParticipants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removePlayerParticipantsObject:(PlayerParticipant *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"playerParticipants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"playerParticipants"] removeObject:value];
    [self didChangeValueForKey:@"playerParticipants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addPlayerParticipants:(NSSet *)value {    
    [self willChangeValueForKey:@"playerParticipants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"playerParticipants"] unionSet:value];
    [self didChangeValueForKey:@"playerParticipants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removePlayerParticipants:(NSSet *)value {
    [self willChangeValueForKey:@"playerParticipants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"playerParticipants"] minusSet:value];
    [self didChangeValueForKey:@"playerParticipants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
