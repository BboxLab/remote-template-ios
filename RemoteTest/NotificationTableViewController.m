//
//  NotificationTableViewController.m
//  BboxRemoteControler
//
//  Created by Pierre-Etienne Cherière on 26/05/2014.
//  Copyright (c) 2014 Bouygues Telecom. All rights reserved.
//

#import "NotificationTableViewController.h"
#import "Constant.h"
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
    
    bbox = [[Bbox alloc] initWithIp:[[NSUserDefaults standardUserDefaults] objectForKey:BBoxIp]];
    
    [bbox.applicationsManager getMyAppIdWithMyAppName:BBoxControler andThenCall:^(BOOL success, NSString *appId, NSError *error) {
        if (success) {
            self.manager = [[NotificationsManager alloc] initWithBboxRestClient:bbox.bboxRestClient andAppId:appId];
            
            [self.manager subscribeToNotification:Application_ApiKey thenCall:^(BOOL success, NSError *error) {
                if (success) {
                    
                    [self.manager UpdateNotification:Media_ApiKey thenCall:^(BOOL success, NSError *error) {
                        if (success) {
                            NSLog(@"Subscribe OK");
                            [self.manager connectWebSocket];
                            [self.manager whenANotificationOccurCall:^(NSDictionary *notification) {
                                NSLog(@"Notifs :%@", [notification description]);
                                NSString * applicationNotification;
                                if ([[notification objectForKey:Body_KEY] count]==4) {
                                    
                                    NSString * service = [[notification objectForKey:Body_KEY] objectForKey:MediaService_KEY];
                                    NSString * state = [[notification objectForKey:Body_KEY] objectForKey:MediaState_KEY];
                                    NSString * title = [[notification objectForKey:Body_KEY] objectForKey:MediaTitle_KEY];
                                    
                                    applicationNotification = [NSString stringWithFormat:@"%@ : %@, title = %@", service, state,title];
                                }
                                else if ([[notification objectForKey:Body_KEY] count]==2) {
                                    NSString * appName = [[notification objectForKey:Body_KEY] objectForKey:PackageName_KEY];
                                    NSString * state = [[notification objectForKey:Body_KEY] objectForKey:State_KEY];
                                    
                                    applicationNotification = [NSString stringWithFormat:@"app: %@, state = %@", appName, state];
                                }
                                [self insertNewObject:applicationNotification];
                            }];
                        } else {
                            NSLog(@"Subscribe KO");
                        }
                    }];
                } else {
                    NSLog(@"Subscribe KO %@", [error localizedDescription]);
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
    
    if (sender) {
        [_objectsNotifs insertObject:sender atIndex:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_Identifier forIndexPath:indexPath];
    
    cell.textLabel.text = _objectsNotifs[indexPath.row];
    
    return cell;
}

@end
