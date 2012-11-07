//
//  Division.h
//  StatsAppMac
//
//  Created by David Mackenzie on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class League, Season;

@interface Division : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* seasons;
@property (nonatomic, retain) League * league;

@end
