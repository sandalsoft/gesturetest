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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gestureProcessingDone:)
                                                 name:@"GestureProcessingDone"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gestureTouchesDone:)
                                                 name:@"DollarPGestureTouchesEnd"
                                               object:nil];
    
    
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
    longPress.minimumPressDuration = 1.5;
    
    [self.view addGestureRecognizer:longPress];
}
- (void) gestureTouchesDone:(NSNotification *)gestureNotification {

    // Process the touchesfrom the gesture view 
    
}


- (void) gestureProcessingDone:(NSNotification *)gestureNotification {
    
    NSDictionary *gestureInfo = [[NSDictionary alloc] initWithDictionary:[gestureNotification userInfo]];
    NSLog(@"gesture name: %@, score: %@", [gestureInfo objectForKey:@"gestureName"], [gestureInfo objectForKey:@"gestureScore"]);
   
    
    [self removeBorder];
    
    
    // Remove the gesutre pad
    for(UIView *subview in [self.view subviews])
        if([subview isKindOfClass:[GesturePadView class]])
            [subview removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)addBorder:(UIColor *)borderColor withTickness:(float)thickness {
    self.view.layer.borderColor = borderColor.CGColor;
    self.view.layer.borderWidth = thickness;
}

- (void)removeBorder {
    self.view.layer.borderColor = nil;
    self.view.layer.borderWidth = 0;
}
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        UIImage *screenShot;
        screenShot = [self takeScreenShot];
        [self addBorder:[UIColor redColor] withTickness:3.0f];
    }
    
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"finger up, start gesuter recog");
        GesturePadView *gestureView =[[[NSBundle mainBundle] loadNibNamed:@"GestureTits" owner:self options:nil] lastObject];
        gestureView.backgroundColor = [UIColor colorWithPatternImage:[self takeScreenShot]];
        [self.view addSubview:gestureView];
        
    }
}
- (UIImage *)takeScreenShot {
    CGRect rect = [self.view bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShot;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        if ([[segue identifier] isEqualToString:@"GestureSegue"]) {

            UIImage *screenShot;
            screenShot = [self takeScreenShot];
        
            [[segue destinationViewController] setBgimage:screenShot];
            
            
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
