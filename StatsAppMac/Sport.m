//
//  Sport.m
//  StatsAppMac
//
//  Created by David Mackenzie on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Sport.h"
#import "League.h"


@implementation Sport
@dynamic name;
@dynamic leagues;

- (void)addLeaguesObject:(League *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"leagues" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"leagues"] addObject:value];
    [self didChangeValueForKey:@"leagues" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeLeaguesObject:(League *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"leagues" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"leagues"] removeObject:value];
    [self didChangeValueForKey:@"leagues" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addLeagues:(NSSet *)value {    
    [self willChangeValueForKey:@"leagues" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"leagues"] unionSet:value];
    [self didChangeValueForKey:@"leagues" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeLeagues:(NSSet *)value {
    [self willChangeValueForKey:@"leagues" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"leagues"] minusSet:value];
    [self didChangeValueForKey:@"leagues" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
