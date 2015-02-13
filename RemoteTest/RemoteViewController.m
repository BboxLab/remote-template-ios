//
//  RemoteViewController.m
//  BboxRemoteControler
//
//  Created by Pierre-Etienne Cherière on 14/05/2014.
//  Copyright (c) 2014 Bouygues Telecom. All rights reserved.
//

#import "RemoteViewController.h"
#import "Constant.h"
@interface RemoteViewController ()

@property   NSMutableDictionary* dico;
@property   RemoteManager* manager;

@end

@implementation RemoteViewController

@synthesize bboxManager;
@synthesize bbox;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.manager = self.bbox.remoteManager;
    self.dico = [[NSMutableDictionary alloc] init];
    [self.dico setValue:[Button_name objectAtIndex:0] forKey:self.one.currentTitle];//1
    [self.dico setValue:[Button_name objectAtIndex:1] forKey:self.two.currentTitle];//2
    [self.dico setValue:[Button_name objectAtIndex:2] forKey:self.three.currentTitle];//3
    [self.dico setValue:[Button_name objectAtIndex:3] forKey:self.four.currentTitle];//4
    [self.dico setValue:[Button_name objectAtIndex:4] forKey:self.five.currentTitle];//5
    [self.dico setValue:[Button_name objectAtIndex:5]forKey:self.six.currentTitle];//6
    [self.dico setValue:[Button_name objectAtIndex:6] forKey:self.seven.currentTitle];//7
    [self.dico setValue:[Button_name objectAtIndex:7] forKey:self.eight.currentTitle];//8
    [self.dico setValue:[Button_name objectAtIndex:8] forKey:self.nine.currentTitle];//9
    [self.dico setValue:[Button_name objectAtIndex:9] forKey:self.zero.currentTitle];//0
    [self.dico setValue:[Button_name objectAtIndex:10] forKey:self.up.currentTitle];//UP
    [self.dico setValue:[Button_name objectAtIndex:11] forKey:self.down.currentTitle];//DOWN
    [self.dico setValue:[Button_name objectAtIndex:12] forKey:self.left.currentTitle];//LEFT
    [self.dico setValue:[Button_name objectAtIndex:13] forKey:self.right.currentTitle];//RIGHT
    [self.dico setValue:[Button_name objectAtIndex:14] forKey:self.ok.currentTitle];//OK
    [self.dico setValue:[Button_name objectAtIndex:15] forKey:self.back.currentTitle];//BACK
    [self.dico setValue:[Button_name objectAtIndex:16] forKey:self.exit.currentTitle];//EXIT
    
    
    [self.one addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//1
    [self.two addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//2
    [self.three addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//3
    [self.four addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//4
    [self.five addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//5
    [self.six addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//6
    [self.seven addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//7
    [self.eight addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//8
    [self.nine addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//9
    [self.zero addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//0
    [self.up addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//UP
    [self.down addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//DOWN
    [self.left addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//LEFT
    [self.right addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//RIGHT
    [self.ok addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//OK
    [self.back addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//BACK
    [self.exit addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];//EXIT
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.bbox = [[Bbox alloc] initWithIp:[[NSUserDefaults standardUserDefaults] objectForKey:BBoxIp]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushedButton:(id)sender {
    
    UIButton * button = sender;
    
    self.manager = self.bbox.remoteManager;
    
    [self.manager sendThisKey:[self.dico objectForKey:button.currentTitle] ofThatType:Keypressed_Type andThenCall:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"Success");
        } else {
            NSLog(@"It's a FAIL");
        }
    }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

@end
