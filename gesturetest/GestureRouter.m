//
//  GestureRouter.m
//  gesturetest
//
//  Created by Eric Nelson on 5/2/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "GestureRouter.h"
#import <QuartzCore/QuartzCore.h>

@implementation GestureRouter



- (id)initWithCallingView:(UIView *)callingView {
    
    if ((self = [super init])) {
        
        self.sendingView = callingView;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(activateGesture:)];
        longPress.minimumPressDuration = 1.0;
        
        [callingView addGestureRecognizer:longPress];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(gestureTouchesDone:)
                                                     name:@"DollarPGestureTouchesEnd"
                                                   object:nil];
        
        
        self.dollarPGestureRecognizer = [[DollarPGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(gestureRecognized:)];
        [self.dollarPGestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
        [self.dollarPGestureRecognizer setDelaysTouchesEnded:NO];

            }
    
    return self;
}

- (void) gestureTouchesDone:(NSNotification *)gestureNotification {
    // Process the touchesfrom the gesture view
    [self.dollarPGestureRecognizer recognize];
    [self.gesturePadView removeFromSuperview];
}


- (void)gestureRecognized:(DollarPGestureRecognizer *)sender {
    [self removeBorder:self.sendingView];
    DollarResult *result = [sender result];
//    NSLog(@"Name: %@\nScore: %.2f", [result name], [result score]);
    NSDictionary *gestureDict = @{@"gestureName":[result name],@"gestureScore":[NSNumber numberWithDouble:[result score]]};
    [[self delegate]  gestureRecognitionComplete:gestureDict];
}

- (void)activateGesture:(UILongPressGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        [self takeScreenShot:self.sendingView];
        [self addBorder:self.sendingView withBorderColor:[UIColor redColor] withTickness:3.0f];

    }
    
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        [self startGestureRouter:self.sendingView];
    }
}

- (void)startGestureRouter:(UIView *)callingView {
//    NSLog(@"in router with my view: %@", callingView);
    
    [self addBorder:callingView withBorderColor:[UIColor redColor] withTickness:3.0f];
    
    self.gesturePadView  = [[[NSBundle mainBundle] loadNibNamed:@"GestureTits" owner:self options:nil] lastObject];
    self.gesturePadView.showStroke = self.showStroke;
     [self.gesturePadView addGestureRecognizer:self.dollarPGestureRecognizer];
    self.gesturePadView.backgroundColor = [UIColor colorWithPatternImage:[self takeScreenShot:callingView]];

    [callingView addSubview:self.gesturePadView];
    
    
}

- (void)addBorder:(UIView *) callingView withBorderColor:(UIColor *)borderColor withTickness:(float)thickness {
    callingView.layer.borderColor = borderColor.CGColor;
    callingView.layer.borderWidth = thickness;
}

- (void)removeBorder:(UIView *) callingView {
    callingView.layer.borderColor = nil;
    callingView.layer.borderWidth = 0;
}



- (UIImage *)takeScreenShot:(UIView *)view {
    CGRect rect = [view bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShot;
}


@end
