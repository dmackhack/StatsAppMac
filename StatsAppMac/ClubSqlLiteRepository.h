//
//  ClubSqlLiteRepository.h
//  StatsAppMac
//
//  Created by David Mackenzie on 17/03/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqlLiteRepository.h"
#import "StatsAppMacSession.h"

@class StatsAppMacAppDelegate;

@interface ClubSqlLiteRepository : NSObject {
    SqlLiteRepository* repo_;
    NSFetchedResultsController* resultsController_;
    NSString* cache_;
}

@property (nonatomic, retain) SqlLiteRepository* repo;

-(NSArray*) fetchClubs: (NSString*)searchTerm;

@end
