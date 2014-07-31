//
//  NotificationTableViewController.m
//  BboxRemoteControler
//
//  Created by Pierre-Etienne Cherière on 26/05/2014.
//  Copyright (c) 2014 Bouygues Telecom. All rights reserved.
//

#import "NotificationTableViewController.h"

@interface NotificationTableViewController ()

@end

@implementation NotificationTableViewController

NSMutableArray * _objectsNotifs;
Bbox * bbox;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    bbox = [[Bbox alloc] initWithIp:[[NSUserDefaults standardUserDefaults] objectForKey:@"bboxIp"]];
    
    [bbox.applicationsManager getMyAppIdWithMyAppName:@"BboxControler" andThenCall:^(BOOL success, NSString *appId, NSError *error) {
        if (success) {
            self.manager = [[NotificationsManager alloc] initWithBboxRestClient:bbox.bboxRestClient andAppId:appId];
            
            [self.manager subscribeToNotification:@"Application" thenCall:^(BOOL success, NSError *error) {
                if (success) {
                    NSLog(@"Subscribe OK");
                    [self.manager connectWebSocket];
                    [self.manager whenANotificationOccurCall:^(NSDictionary *notification) {
                        NSLog(@"Notifs !");
                        NSLog(@"%@", [notification description]);

                            NSString * appName = [[notification objectForKey:@"body"] objectForKey:@"appName"];
                            NSString * state = [[notification objectForKey:@"body"] objectForKey:@"state"];
                            
                            NSString * applicationNotification = [NSString stringWithFormat:@"app: %@, state = %@", appName, state];
                            
                            [self insertNewObject:applicationNotification];

                    }];
                } else {
                    NSLog(@"%@", [error localizedDescription]);
                    NSLog(@"Subscribe KO");
                }
            }];
        } else {
            NSLog(@"getAppID KO");
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objectsNotifs) {
        _objectsNotifs = [[NSMutableArray alloc] init];
    }
    
    
    [_objectsNotifs insertObject:sender atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_objectsNotifs count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = _objectsNotifs[indexPath.row];
    
    return cell;
}

@end
