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


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    
    self.data = @[@"story 1", @"blah blah", @"hello", @"data stuffs", @"tits!"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#warning LONG TOUCH TRIGGERS IT


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        if ([[segue identifier] isEqualToString:@"GestureSegue"]) {
            NSLog(@"segueing");
            UIGraphicsBeginImageContext(CGSizeMake(320,480));
            CGContextRef context = UIGraphicsGetCurrentContext();
            [self.view.layer drawInContext:context];
            UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

            [[segue destinationViewController] setgesturebg:screenShot];
//            GestureViewController *gvc = [[GestureViewController alloc] init];
//            gvc = [segue destinationViewController];
//            gvc.dollarPGestureRecognizer = [[DollarPGestureRecognizer alloc] initWithTarget:gvc
//                                                                                     action:@selector(gestureRecognized:)];
//            [gvc.dollarPGestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
//            [gvc.dollarPGestureRecognizer setDelaysTouchesEnded:NO];
//            
//            [gvc.gesturePadView addGestureRecognizer:gvc.dollarPGestureRecognizer];
            

//            gvc.gesturePadView.backgroundColor = [UIColor redColor];// ]colorWithPatternImage:screenShot];
            

            
        }
}
- (IBAction)actionButtonPressed:(id)sender {
//    [[RWBlurPopover instance] presentViewController:GestureViewController withHeight:300];
    
    UIGraphicsBeginImageContext(CGSizeMake(320,480));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer drawInContext:context];
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    GestureViewController *gvc = [[GestureViewController alloc] init];
    
    gvc.dollarPGestureRecognizer = [[DollarPGestureRecognizer alloc] initWithTarget:gvc
                                                                              action:@selector(gestureRecognized:)];
    [gvc.dollarPGestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
    [gvc.dollarPGestureRecognizer setDelaysTouchesEnded:NO];
    
    [gvc.gesturePadView addGestureRecognizer:gvc.dollarPGestureRecognizer];

    gvc.gesturePadView.backgroundColor = [UIColor colorWithPatternImage:screenShot];

    [self presentViewController:gvc animated:YES completion:^{
        NSLog(@"gvc presented");
    }];
    
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


@end
