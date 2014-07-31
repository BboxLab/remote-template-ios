//
//  RemoteViewController.h
//  BboxRemoteControler
//
//  Created by Pierre-Etienne Cherière on 14/05/2014.
//  Copyright (c) 2014 Bouygues Telecom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BboxSecondScreen/BSSBboxSecondScreen.h>

@interface RemoteViewController : UIViewController

@property IBOutlet UIButton * one;
@property IBOutlet UIButton * two;
@property IBOutlet UIButton * three;
@property IBOutlet UIButton * four;
@property IBOutlet UIButton * five;
@property IBOutlet UIButton * six;
@property IBOutlet UIButton * seven;
@property IBOutlet UIButton * eight;
@property IBOutlet UIButton * nine;
@property IBOutlet UIButton * zero;
@property IBOutlet UIButton * back;
@property IBOutlet UIButton * exit;
@property IBOutlet UIButton * up;
@property IBOutlet UIButton * down;
@property IBOutlet UIButton * left;
@property IBOutlet UIButton * right;
@property IBOutlet UIButton * ok;

@property Bbox * bbox;
@property BboxManager * bboxManager;

@end
