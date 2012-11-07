//
//  Match.m
//  StatsAppMac
//
//  Created by David Mackenzie on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Match.h"
#import "Participant.h"
#import "Round.h"


@implementation Match
@dynamic date;
@dynamic round;
@dynamic participants;


- (void)addParticipantsObject:(Participant *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"participants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"participants"] addObject:value];
    [self didChangeValueForKey:@"participants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeParticipantsObject:(Participant *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"participants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"participants"] removeObject:value];
    [self didChangeValueForKey:@"participants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addParticipants:(NSSet *)value {    
    [self willChangeValueForKey:@"participants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"participants"] unionSet:value];
    [self didChangeValueForKey:@"participants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeParticipants:(NSSet *)value {
    [self willChangeValueForKey:@"participants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"participants"] minusSet:value];
    [self didChangeValueForKey:@"participants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
