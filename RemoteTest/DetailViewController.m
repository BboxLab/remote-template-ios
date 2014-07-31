//
//  DetailViewController.m
//  BboxRemoteControler
//
//  Created by Pierre-Etienne Cherière on 05/05/2014.
//  Copyright (c) 2014 Bouygues Telecom. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize bbox;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem andBbox:(Bbox*)initialBbox
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        self.bbox = initialBbox;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    self.indicator.hidesWhenStopped = YES;
    [self.indicator startAnimating];
    if (self.detailItem) {
        self.manager = self.bbox.applicationsManager;
        Application* app = self.detailItem;
        self.detailDescriptionLabel.text = app.appName;
        [self.manager getApplicationWithThatPackageName:app.packageName ThenCall:^(BOOL success, Application *application, NSError *error) {
            if (application.state == STOPPED) {
                [self.onOffSwitch setOn:NO];
            } else {
                [self.onOffSwitch setOn:YES];
            }
            [self.onOffSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
            [self.indicator stopAnimating];
        }];
    } else {
        [self.indicator stopAnimating];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    self.bbox = [[Bbox alloc] initWithIp:[[NSUserDefaults standardUserDefaults] objectForKey:@"bboxIp"]];
        [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)switchChanged:(id)sender {
    
    [self.indicator startAnimating];
    if ([self.onOffSwitch isOn]) {
        [self.manager startApplication:self.detailItem thenCall:^(BOOL success, NSError *error) {
            if (!success) {
                [self.onOffSwitch setOn:NO];
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                  message:[error localizedDescription]
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                
                [message show];
            }
            [self.indicator stopAnimating];
        }];
    } else {
        [self.manager stopApplication:self.detailItem thenCall:^(BOOL success, NSError *error) {
            if (!success) {
                [self.onOffSwitch setOn:YES];
                if (!success) {
                    [self.onOffSwitch setOn:NO];
                    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:[error localizedDescription]
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles:nil];
                    
                    [message show];
                }
                [self.indicator stopAnimating];
            }
            [self.indicator stopAnimating];
        }];
    }
}

@end
