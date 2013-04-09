//
//  FixtureSqlLiteRepository.h
//  StatsAppMac
//
//  Created by David Mackenzie on 9/04/13.
//
//

#import <Foundation/Foundation.h>
#import "SqlLiteRepository.h"
#import "StatsAppMacSession.h"

@class StatsAppMacAppDelegate;

@interface FixtureSqlLiteRepository : NSObject {
    SqlLiteRepository* repo_;
    NSFetchedResultsController* resultsController_;
    NSString* cache_;
}

@property (nonatomic, retain) SqlLiteRepository* repo;

- (NSArray*) fetchLeaguesByName:(NSString*)name;

@end
