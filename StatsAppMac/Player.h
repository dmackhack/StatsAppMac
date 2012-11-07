//
//  Player.h
//  StatsAppMac
//
//  Created by David Mackenzie on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"

@class PlayerParticipant;

@interface Player : User {
@private
}
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * tackles;
@property (nonatomic, retain) NSNumber * kicks;
@property (nonatomic, retain) NSNumber * behinds;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * goals;
@property (nonatomic, retain) NSNumber * handballs;
@property (nonatomic, retain) NSNumber * marks;
@property (nonatomic, retain) NSSet* clubs;
@property (nonatomic, retain) NSSet* playerParticipants;

@end
