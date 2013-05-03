//
//  ViewController.m
//  gesturetest
//
//  Created by Eric Nelson on 4/29/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "ViewController.h"
#import "GestureViewController.h"
#import <RWBlurPopover/RWBlurPopover.h>
#import "DollarDefaultGestures.h"
#import <QuartzCore/QuartzCore.h>
#import "GesturePadView.h"
#import "GestureRouter.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    self.data = @[@"story 1", @"blah blah", @"hello", @"data stuffs", @"tits!"];
    self.gestureRouter = [[GestureRouter alloc] initWithCallingView:self.view];
}

- (void) gestureProcessingDone:(NSNotification *)gestureNotification {
    
    NSDictionary *gestureInfo = [[NSDictionary alloc] initWithDictionary:[gestureNotification userInfo]];
    NSLog(@"gesture NAME: %@, score: %@", [gestureInfo objectForKey:@"gestureName"], [gestureInfo objectForKey:@"gestureScore"]);
   
    // Remove the gesutre pad
    for(UIView *subview in [self.view subviews])
        if([subview isKindOfClass:[GesturePadView class]])
            [subview removeFromSuperview];
}

#pragma mark TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    cell.textLabel.text = [self.data objectAtIndex:[indexPath row]];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
