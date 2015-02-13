//
//  FindBboxTableViewController.m
//  BboxRemoteControler
//
//  Created by Pierre-Etienne Cherière on 20/05/2014.
//  Copyright (c) 2014 Bouygues Telecom. All rights reserved.
//

#import "FindBboxTableViewController.h"
#import "Constant.h"
@interface FindBboxTableViewController ()

@end

@implementation FindBboxTableViewController

NSMutableArray *_objects;
long selectedRow = -1;

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
    
    //actual select Box
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [self insertNewObject:[userDefaults objectForKey:BBoxIp]];
    
    self.bboxManager = [BboxManager alloc];
    
    [self.bboxManager startLookingForBboxThenCall:^(Bbox *bbox) {
        Boolean exist = false;
        self.bbox = bbox;
        for (NSString * ip in _objects) {
            if ([ip isEqualToString:bbox.ip]) {
                exist = true;
            }
        }
        if (!exist) {
            [self insertNewObject:bbox.ip];
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
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    
    [_objects insertObject:sender atIndex:0];
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
    return _objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_Identifier forIndexPath:indexPath];
    
    cell.textLabel.text = _objects[indexPath.row];
    
    if (indexPath.row == selectedRow) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)  tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    selectedRow = indexPath.row;
    NSString *ip = _objects[indexPath.row];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ip forKey:BBoxIp];
    [userDefaults synchronize];
    
    [self.tableView reloadData];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString *ip = _objects[indexPath.row];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ip forKey:BBoxIp];
    [userDefaults synchronize];
    
}


@end
