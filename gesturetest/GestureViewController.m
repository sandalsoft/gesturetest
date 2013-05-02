//
//  GestureViewController.m
//  gesturetest
//
//  Created by Eric Nelson on 5/1/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "GestureViewController.h"
#import "DollarPGestureRecognizer.h"
#import "DollarDefaultGestures.h"
#import "GesturePadView.h"

@interface GestureViewController ()

@end

@implementation GestureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.dollarPGestureRecognizer = [[DollarPGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(gestureRecognized:)];
    [self.dollarPGestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
    [self.dollarPGestureRecognizer setDelaysTouchesEnded:NO];
    
    [self.gesturePadView addGestureRecognizer:self.dollarPGestureRecognizer];

    self.gesturePadView.backgroundColor = [UIColor colorWithPatternImage:self.bgimage];

//    [self.view addSubview:self.gesturePadView];
}

- (void)gestureRecognized:(DollarPGestureRecognizer *)sender {
    DollarResult *result = [sender result];
    
    NSDictionary *gestureDict = @{@"gestureName":[result name],@"gestureScore":[NSNumber numberWithDouble:[result score]]};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GestureProcessingDone" object:nil userInfo:gestureDict];

//    NSLog(@"Name: %@\nScore: %.2f", [result name], [result score]);
//    NSLog(@"%@",[NSString stringWithFormat:@"Result: %@ (Score: %.2f)", [result name], [result score]]);

        if ([self respondsToSelector:@selector(presentingViewController)]){
        [self dismissViewControllerAnimated:NO
                                 completion:^{
                                     //
                                 }];
    }
}
- (IBAction)myButtonPressed:(id)sender {
        [self.dollarPGestureRecognizer recognize];
    
}


- (void)setgesturebg:(UIImage *)bgImage {
    self.gesturePadView.backgroundColor = [UIColor colorWithPatternImage:bgImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
