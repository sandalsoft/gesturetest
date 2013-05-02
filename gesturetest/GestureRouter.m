//
//  GestureRouter.m
//  gesturetest
//
//  Created by Eric Nelson on 5/2/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "GestureRouter.h"

@implementation GestureRouter

- (id)init {
    
    if ((self = [super init])) {
        self.dollarPGestureRecognizer = [[DollarPGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(gestureRecognized:)];
        [self.dollarPGestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
        [self.dollarPGestureRecognizer setDelaysTouchesEnded:NO];
        [self.gesturePadView addGestureRecognizer:self.dollarPGestureRecognizer];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(gestureTouchesDone:)
                                                     name:@"DollarPGestureTouchesEnd"
                                                   object:nil];
        
    }
    
    return self;
}

- (void) gestureTouchesDone:(NSNotification *)gestureNotification {
    
    // Process the touchesfrom the gesture view
    [self.dollarPGestureRecognizer recognize];
}


- (void)gestureRecognized:(DollarPGestureRecognizer *)sender {
    
    DollarResult *result = [sender result];
    NSDictionary *gestureDict = @{@"gestureName":[result name],@"gestureScore":[NSNumber numberWithDouble:[result score]]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GestureProcessingDone" object:nil userInfo:gestureDict];
}

@end
