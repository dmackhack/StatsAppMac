//
//  Season.m
//  StatsAppMac
//
//  Created by David Mackenzie on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Season.h"
#import "Division.h"
#import "Round.h"


@implementation Season
@dynamic year;
@dynamic division;
@dynamic rounds;


- (void)addRoundsObject:(Round *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"rounds" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"rounds"] addObject:value];
    [self didChangeValueForKey:@"rounds" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeRoundsObject:(Round *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"rounds" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"rounds"] removeObject:value];
    [self didChangeValueForKey:@"rounds" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addRounds:(NSSet *)value {    
    [self willChangeValueForKey:@"rounds" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"rounds"] unionSet:value];
    [self didChangeValueForKey:@"rounds" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeRounds:(NSSet *)value {
    [self willChangeValueForKey:@"rounds" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"rounds"] minusSet:value];
    [self didChangeValueForKey:@"rounds" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
