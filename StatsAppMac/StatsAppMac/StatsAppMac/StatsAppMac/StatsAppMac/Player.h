//
//  Player.h
//  StatsAppMac
//
//  Created by David MacKenzie on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * kicks;
@property (nonatomic, retain) NSNumber * marks;
@property (nonatomic, retain) NSNumber * handballs;
@property (nonatomic, retain) NSNumber * tackles;
@property (nonatomic, retain) NSNumber * goals;
@property (nonatomic, retain) NSNumber * behinds;

@end
