//
//  AppDelegate.h
//  BboxRemoteControler
//
//  Created by Pierre-Etienne Cherière on 05/05/2014.
//  Copyright (c) 2014 Bouygues Telecom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BboxSecondScreen/BSSBboxSecondScreen.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property NSNetServiceBrowser *serviceBrowser;
@property NSNetService *serviceResolver;

@property Bbox * bbox;
@property BboxManager * bboxManager;
@property ConnectManager * connectManager;

@end
