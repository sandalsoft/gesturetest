//
//  ViewController.m
//  gesturetest
//
//  Created by Eric Nelson on 4/29/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "ViewController.h"
#import "GestureRouter.h"
#import <Twitter/Twitter.h>

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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gestureAction:)
                                                 name:@"GestureProcessingDone"
                                               object:nil];

}

- (void)gestureAction:(NSNotification *)notification {
    NSLog(@"shit");
    NSDictionary *gestureInfo = [notification userInfo];
    NSString *gestureName = [gestureInfo objectForKey:@"gestureName"];
    if ([gestureName isEqualToString:@"T"]) {
        [self sendTweet];
    }


}

- (void)sendTweet {
    //Create the tweet sheet
    TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
    
    //Customize the tweet sheet here
    //Add a tweet message
    [tweetSheet setInitialText:@"HOLY SHIT THIS WORKS!!"];
    
    
    //Set a blocking handler for the tweet sheet
    tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult result){
        [self dismissModalViewControllerAnimated:YES];
    };
    
    //Show the tweet sheet!
    [self presentModalViewController:tweetSheet animated:YES];
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
