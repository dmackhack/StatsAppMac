//
//  League.m
//  StatsAppMac
//
//  Created by David Mackenzie on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "League.h"
#import "Division.h"
#import "Sport.h"


@implementation League
@dynamic name;
@dynamic divisions;
@dynamic sport;

- (void)addDivisionsObject:(Division *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"divisions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"divisions"] addObject:value];
    [self didChangeValueForKey:@"divisions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeDivisionsObject:(Division *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"divisions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"divisions"] removeObject:value];
    [self didChangeValueForKey:@"divisions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addDivisions:(NSSet *)value {    
    [self willChangeValueForKey:@"divisions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"divisions"] unionSet:value];
    [self didChangeValueForKey:@"divisions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeDivisions:(NSSet *)value {
    [self willChangeValueForKey:@"divisions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"divisions"] minusSet:value];
    [self didChangeValueForKey:@"divisions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}



@end
