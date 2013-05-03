//
//  GestureRouter.h
//  gesturetest
//
//  Created by Eric Nelson on 5/2/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DollarPGestureRecognizer.h"
#import "DollarDefaultGestures.h"
#import "GesturePadView.h"

#define GestureRecognizedNotif @"com.sandalsoft.SSGestureAction.GestureRecognized"


@interface GestureRouter : NSObject

@property (strong, nonatomic) IBOutlet GesturePadView *gesturePadView;
@property (strong, nonatomic) DollarPGestureRecognizer *dollarPGestureRecognizer;
@property (strong, nonatomic) UIView *sendingView;



- (id)initWithCallingView:(UIView *)callingView ;
- (void)startGestureRouter:(UIView *)callingView;

@end


