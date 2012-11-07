//
//  Season.h
//  StatsAppMac
//
//  Created by David Mackenzie on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Division, Round;

@interface Season : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) Division * division;
@property (nonatomic, retain) NSSet* rounds;

@end
