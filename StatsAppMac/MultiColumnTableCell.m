//
//  MultiColumnTableCell.m
//  StatsAppMac
//
//  Created by David Mackenzie on 11/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MultiColumnTableCell.h"


@implementation MultiColumnTableCell


@synthesize columns=columns_;

- (void) initialize
{
    NSLog(@"Allocating columns array");
    self.columns = [[NSMutableArray alloc] init];
}

- (void) addColumn:(CGFloat)position
{
    NSLog(@"Start addColumn count: %i", [self.columns count]);
    [self.columns addObject:[NSNumber numberWithFloat:position]];
    NSLog(@"End addColumn %i", [self.columns count]);
}


- (void) drawRect:(CGRect)rect
{
    NSLog(@"In draw rect. Number Columns: %i", [self.columns count]);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1);
    CGContextSetLineWidth(ctx, 0.25);
    
    for (int i=0; i<[self.columns count]; i++)
    {
        CGFloat f = [((NSNumber*) [self.columns objectAtIndex:i]) floatValue];
        
        NSLog(@"Float %f", f);
        
        CGContextMoveToPoint(ctx, f, 0);
        CGContextAddLineToPoint(ctx, f, self.bounds.size.height);
    }
    CGContextStrokePath(ctx);
    
    [super drawRect:rect];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"Allocating columns array");
        //self.columns = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [self.columns release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
