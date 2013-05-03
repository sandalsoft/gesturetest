//
//  ViewController.m
//  gesturetest
//
//  Created by Eric Nelson on 4/29/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "ViewController.h"
#import "GestureRouter.h"
#import <Social/Social.h>
#import <MessageUI/MFMailComposeViewController.h>

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
    self.gestureRouter.showStroke = YES;    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gestureAction:)
                                                 name:@"GestureProcessingDone"
                                               object:nil];

}

- (void)gestureAction:(NSNotification *)notification {

    NSDictionary *gestureInfo = [notification userInfo];
    NSString *gestureName = [gestureInfo objectForKey:@"gestureName"];
    if ([gestureName isEqualToString:@"T"]) {
        [self sendTweet];
    }
    else if ([gestureName isEqualToString:@"line"]) {
        [self sendMail];
    }
}

- (void)sendMail {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Serious, this fucking works!"];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"julie.jawor@gmail.com", nil];
        [mailer setToRecipients:toRecipients];
        
        NSString *emailBody = @"";
        [mailer setMessageBody:emailBody isHTML:NO];
        [self presentModalViewController:mailer animated:YES];
        
    }

}

- (void)sendTweet {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Initial Tweet Text!"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }}

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
