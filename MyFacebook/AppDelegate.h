//
//  AppDelegate.h
//  MyFacebook
//
//  Created by  on 11-10-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (nonatomic, retain) RootViewController *rootViewController;

extern NSString * const fbAppId; 

@end
