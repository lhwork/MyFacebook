//
//  AppDelegate.m
//  MyFacebook
//
//  Created by  on 11-10-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

NSString * const fbAppId = @"131529600286680";

@implementation AppDelegate

@synthesize window = _window;
@synthesize rootViewController = _rootViewController;

- (void)dealloc
{
    [_window release];
    [_rootViewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _rootViewController = [[RootViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:_rootViewController];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    
    //[self.window addSubview:viewController.view];
    self.window.rootViewController = navController;
    
    [navController release];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

//pre 4.2
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [[_rootViewController facebook] handleOpenURL:url];
}

//4.2+
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[_rootViewController facebook] handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
