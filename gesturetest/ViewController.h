//
//  ViewController.h
//  gesturetest
//
//  Created by Eric Nelson on 4/29/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureRouter.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;

@property (weak, nonatomic) IBOutlet UITableView *dataTableView;

@property (strong, nonatomic) NSArray *data;

@property (strong, nonatomic) GestureRouter *gestureRouter;
@end
