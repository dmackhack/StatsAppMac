//
//  User.m
//  StatsAppMac
//
//  Created by David Mackenzie on 19/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"
#import "ParticipantStatistics.h"


@implementation User
@dynamic username;
@dynamic userId;
@dynamic firstName;
@dynamic lastName;
@dynamic password;
@dynamic participantStatistics;

- (void)addParticipantStatisticsObject:(ParticipantStatistics *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"participantStatistics" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"participantStatistics"] addObject:value];
    [self didChangeValueForKey:@"participantStatistics" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeParticipantStatisticsObject:(ParticipantStatistics *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"participantStatistics" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"participantStatistics"] removeObject:value];
    [self didChangeValueForKey:@"participantStatistics" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addParticipantStatistics:(NSSet *)value {    
    [self willChangeValueForKey:@"participantStatistics" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"participantStatistics"] unionSet:value];
    [self didChangeValueForKey:@"participantStatistics" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeParticipantStatistics:(NSSet *)value {
    [self willChangeValueForKey:@"participantStatistics" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"participantStatistics"] minusSet:value];
    [self didChangeValueForKey:@"participantStatistics" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
