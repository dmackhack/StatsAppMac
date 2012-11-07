//
//  Division.m
//  StatsAppMac
//
//  Created by David Mackenzie on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Division.h"
#import "League.h"
#import "Season.h"


@implementation Division
@dynamic rank;
@dynamic name;
@dynamic seasons;
@dynamic league;

- (void)addSeasonsObject:(Season *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"seasons" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"seasons"] addObject:value];
    [self didChangeValueForKey:@"seasons" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeSeasonsObject:(Season *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"seasons" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"seasons"] removeObject:value];
    [self didChangeValueForKey:@"seasons" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addSeasons:(NSSet *)value {    
    [self willChangeValueForKey:@"seasons" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"seasons"] unionSet:value];
    [self didChangeValueForKey:@"seasons" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeSeasons:(NSSet *)value {
    [self willChangeValueForKey:@"seasons" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"seasons"] minusSet:value];
    [self didChangeValueForKey:@"seasons" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}



@end
