//
//  DetailViewController.h
//  BboxRemoteControler
//
//  Created by Pierre-Etienne Cherière on 05/05/2014.
//  Copyright (c) 2014 Bouygues Telecom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BboxSecondScreen/BSSBboxSecondScreen.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Application* detailItem;

@property ApplicationsManager *manager;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property IBOutlet UISwitch *onOffSwitch;

@property IBOutlet UIActivityIndicatorView *indicator;

@property Bbox * bbox;

@end
