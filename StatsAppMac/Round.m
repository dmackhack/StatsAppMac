//
//  Round.m
//  StatsAppMac
//
//  Created by David Mackenzie on 17/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Round.h"
#import "Match.h"
#import "Season.h"


@implementation Round
@dynamic date;
@dynamic number;
@dynamic season;
@dynamic matches;


- (void)addMatchesObject:(Match *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"matches" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"matches"] addObject:value];
    [self didChangeValueForKey:@"matches" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeMatchesObject:(Match *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"matches" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"matches"] removeObject:value];
    [self didChangeValueForKey:@"matches" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addMatches:(NSSet *)value {    
    [self willChangeValueForKey:@"matches" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"matches"] unionSet:value];
    [self didChangeValueForKey:@"matches" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeMatches:(NSSet *)value {
    [self willChangeValueForKey:@"matches" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"matches"] minusSet:value];
    [self didChangeValueForKey:@"matches" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
