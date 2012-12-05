//
//  MultiColumnHeader.m
//  StatsAppMac
//
//  Created by David Mackenzie on 4/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MultiColumnHeader.h"


@implementation MultiColumnHeader

@synthesize columnSizes=columnSizes_, columnValues=columnValues_;

int margin=10;

- (void) addColumn:(int) end withText:(NSString*) text
{
    [self.columnSizes addObject:[NSNumber numberWithInt:end]];
    [self.columnValues addObject:text];
    
}


- (void) initialize
{
    self.backgroundColor = [UIColor whiteColor];
    self.columnSizes = [[NSMutableArray alloc] init];
    self.columnValues = [[NSMutableArray alloc] init];
}

- (void) drawRect:(CGRect)rect
{
    NSLog(@"In draw rect. Number Columns: %i", [self.columnSizes count]);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1);
    CGContextSetLineWidth(ctx, 0.25);
    
    for (int i=0; i<[self.columnSizes count]; i++)
    {
        CGFloat f = [((NSNumber*) [self.columnSizes objectAtIndex:i]) floatValue];
        
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
    }
    return self;
}

- (void)dealloc
{
    [columnSizes_ release];
    [columnValues_ release];
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
