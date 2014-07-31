//
//  FindBboxTableViewController.h
//  BboxRemoteControler
//
//  Created by Pierre-Etienne Cherière on 20/05/2014.
//  Copyright (c) 2014 Bouygues Telecom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BboxSecondScreen/BSSBboxSecondScreen.h>

@interface FindBboxTableViewController : UITableViewController

@property Bbox * bbox;
@property BboxManager * bboxManager;

@end
