//
//  Player.m
//  StatsAppMac
//
//  Created by David Mackenzie on 20/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "PlayerClub.h"
#import "PlayerParticipant.h"


@implementation Player
@dynamic number;
@dynamic clubs;
@dynamic playerParticipants;

- (void)addClubsObject:(PlayerClub *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"clubs" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"clubs"] addObject:value];
    [self didChangeValueForKey:@"clubs" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeClubsObject:(PlayerClub *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"clubs" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"clubs"] removeObject:value];
    [self didChangeValueForKey:@"clubs" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addClubs:(NSSet *)value {    
    [self willChangeValueForKey:@"clubs" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"clubs"] unionSet:value];
    [self didChangeValueForKey:@"clubs" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeClubs:(NSSet *)value {
    [self willChangeValueForKey:@"clubs" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"clubs"] minusSet:value];
    [self didChangeValueForKey:@"clubs" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


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
