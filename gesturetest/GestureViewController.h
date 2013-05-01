//
//  GestureViewController.h
//  gesturetest
//
//  Created by Eric Nelson on 5/1/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GesturePadView.h"
#import "DollarPGestureRecognizer.h"

@interface GestureViewController : UIViewController

@property (strong, nonatomic) IBOutlet GesturePadView *gesturePadView;
@property (strong, nonatomic) DollarPGestureRecognizer *dollarPGestureRecognizer;

@property (weak, nonatomic) IBOutlet UIButton *myButton;


- (void)setgesturebg:(UIImage *)bgImage;
@end
