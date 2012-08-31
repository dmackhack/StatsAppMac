//
//  TeamSelectionViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 30/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDayStatsViewController.h"


@interface TeamSelectionViewController : UIViewController <UIScrollViewDelegate> {
 
    UIScrollView* scrollView_;
    UIPageControl* pageControl_;
    NSMutableArray* viewControllers_;
    
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
}



@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;
@property (nonatomic, retain) NSMutableArray* viewControllers;

- (IBAction) changePage: (id) sender;

@end
