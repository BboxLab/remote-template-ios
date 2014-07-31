//
//  RemoteViewController.m
//  BboxRemoteControler
//
//  Created by Pierre-Etienne Cherière on 14/05/2014.
//  Copyright (c) 2014 Bouygues Telecom. All rights reserved.
//

#import "RemoteViewController.h"

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
    
    [self.dico setValue:@"1" forKey:self.one.currentTitle];
    [self.dico setValue:@"2" forKey:self.two.currentTitle];
    [self.dico setValue:@"3" forKey:self.three.currentTitle];
    [self.dico setValue:@"4" forKey:self.four.currentTitle];
    [self.dico setValue:@"5" forKey:self.five.currentTitle];
    [self.dico setValue:@"6" forKey:self.six.currentTitle];
    [self.dico setValue:@"7" forKey:self.seven.currentTitle];
    [self.dico setValue:@"8" forKey:self.eight.currentTitle];
    [self.dico setValue:@"9" forKey:self.nine.currentTitle];
    [self.dico setValue:@"0" forKey:self.zero.currentTitle];
    [self.dico setValue:@"UP" forKey:self.up.currentTitle];
    [self.dico setValue:@"DOWN" forKey:self.down.currentTitle];
    [self.dico setValue:@"LEFT" forKey:self.left.currentTitle];
    [self.dico setValue:@"RIGHT" forKey:self.right.currentTitle];
    [self.dico setValue:@"OK" forKey:self.ok.currentTitle];
    [self.dico setValue:@"BACK" forKey:self.back.currentTitle];
    [self.dico setValue:@"EXIT" forKey:self.exit.currentTitle];
    
    
    [self.one addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.two addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.three addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.four addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.five addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.six addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.seven addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.eight addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.nine addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.zero addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.up addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.down addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.left addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.right addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.ok addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.back addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.exit addTarget:self action:@selector(pushedButton:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.bbox = [[Bbox alloc] initWithIp:[[NSUserDefaults standardUserDefaults] objectForKey:@"bboxIp"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushedButton:(id)sender {
    
    UIButton * button = sender;
    
    self.manager = self.bbox.remoteManager;
    
    [self.manager sendThisKey:[self.dico objectForKey:button.currentTitle] ofThatType:@"keypressed" andThenCall:^(BOOL success, NSError *error) {
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
