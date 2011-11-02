//
//  RootViewController.m
//  MyFacebook
//
//  Created by  on 11-10-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"
#import "ResultsViewController.h"
#import "FrieldsViewController.h"

@implementation RootViewController

@synthesize facebook;
@synthesize loginButton;
@synthesize logoutButton;
@synthesize showMeButton;
@synthesize feedButton;
@synthesize requestButton;
@synthesize friendsButton;
@synthesize profileImageView;
@synthesize profileNameLabel;
@synthesize loggedInView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    facebook = [[Facebook alloc] initWithAppId:fbAppId andDelegate:self];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    //view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"farm.png"]];
    [view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"Facebook测试";
    self.view = view;
    [view release];
    
    loginButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    loginButton.frame = CGRectMake(0, 0, 318, 58);
    loginButton.center = CGPointMake(self.view.center.x, self.view.center.y);
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setImage:[UIImage imageNamed:@"FBConnect.bundle/images/LoginWithFacebookNormal.png"] forState:UIControlStateNormal];
    
    [loginButton setImage:[UIImage imageNamed:@"FBConnect.bundle/images/LoginWithFacebookPressed.png"] forState:UIControlStateHighlighted];

    [self.view addSubview:loginButton];
    
    
    //loggedIn
    loggedInView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    loggedInView.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
//    UIColor *facebookBlue = [UIColor 
//                             colorWithRed:59.0/255.0 
//                             green:89.0/255.0 
//                             blue:152.0/255.0 
//                             alpha:1.0];
    loggedInView.backgroundColor = [UIColor whiteColor];

    logoutButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    logoutButton.frame = CGRectMake(10,10,81,29);
    [logoutButton addTarget:self
                     action:@selector(logout)
           forControlEvents:UIControlEventTouchUpInside];
    [logoutButton setImage:
     [UIImage imageNamed:@"FBConnect.bundle/images/LogoutNormal.png"] 
                  forState:UIControlStateNormal];
    [logoutButton setImage:
     [UIImage imageNamed:@"FBConnect.bundle/images/LogoutPressed.png"] 
                  forState:UIControlStateHighlighted];
    [logoutButton sizeToFit];
    
    [loggedInView addSubview:logoutButton];
    
    showMeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    showMeButton.frame = CGRectMake(10, 50, (self.view.bounds.size.width - 20), 40);
    showMeButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    [showMeButton setTitle:@"Show Me" 
                  forState:UIControlStateNormal];
    [showMeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showMeButton addTarget:self action:@selector(showMeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [loggedInView addSubview:showMeButton];

    feedButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    feedButton.frame = CGRectMake(10, 100, (self.view.bounds.size.width - 20), 40);
    feedButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    [feedButton setTitle:@"Send to Wall" 
                  forState:UIControlStateNormal];
    [feedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [feedButton addTarget:self action:@selector(feedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [loggedInView addSubview:feedButton];

    requestButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    requestButton.frame = CGRectMake(10, 150, (self.view.bounds.size.width - 20), 40);
    requestButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    [requestButton setTitle:@"Send Request" 
                forState:UIControlStateNormal];
    [requestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [requestButton addTarget:self action:@selector(sendRequestButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [loggedInView addSubview:requestButton];
    
    friendsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    friendsButton.frame = CGRectMake(10, 200, (self.view.bounds.size.width - 20), 40);
    friendsButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    [friendsButton setTitle:@"Show Friends" 
                   forState:UIControlStateNormal];
    [friendsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [friendsButton addTarget:self action:@selector(sendFriendsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [loggedInView addSubview:friendsButton];
    
    [self.view addSubview:loggedInView];
    
    
    
}

/**
 * Show the authorization dialog.
 */
- (void)login {
    // Check and retrieve authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    if (![facebook isSessionValid]) {
        facebook.sessionDelegate = self;
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"user_likes", 
                                @"read_stream",
                                //@"user_about_me",
                                //@"email",
                                //@"publish_stream",
                                @"publish_actions", 
                                @"offline_access",
                                nil];
        [facebook authorize:permissions];
        [permissions release];
    } else {
        [self showLoggedIn];
    }
}


/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    [facebook logout:self];
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    NSLog(@"request did load.");
    
    switch (currGraphAPI) {
        case kGraphMe:
        {
            NSString *nameID = [[NSString alloc] initWithFormat:@"%@ (%@)", [result objectForKey:@"name"], [result objectForKey:@"id"]];
            
            NSDictionary *userData = [NSDictionary dictionaryWithObjectsAndKeys:[result objectForKey:@"id"], @"id", nameID, @"name", [result objectForKey:@"picture"], @"details", nil];
            
            [nameID release];
            
            ResultsViewController *controller = [[ResultsViewController alloc] initWithTitle:@"您的信息" data:userData];
            
            [self.navigationController pushViewController:controller animated:YES];
            
            [controller release];
            
            break;
        }
        case kGraphFriends:
        {
            NSMutableArray *frields = [[NSMutableArray alloc] initWithCapacity:1];
            NSArray *array = [result objectForKey:@"data"];
            for (NSInteger i = 0; i < [array count] && i < 16; i++) {
                [frields addObject:[array objectAtIndex:(arc4random() % [array count])]];
            }
                                    
            FrieldsViewController *frieldsViewController = [[FrieldsViewController alloc] initWithTitle:@"好友列表" data:frields];
            
            [frields release];
            
            [self.navigationController pushViewController:frieldsViewController animated:YES];
            
            [frieldsViewController release];
            
            break;
        }
        default:
            break;
    }
    
}

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"request did receive response.");
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    NSLog(@"Err code: %d", [error code]);
}

- (void)showMeButtonClicked:(id)sender
{
    currGraphAPI = kGraphMe;
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"name,picture",  @"fields",
                                   nil];
    [facebook requestWithGraphPath:@"me" andParams:params andDelegate:self];

}

- (void)feedButtonClicked:(id)sender
{
//    SBJSON *jsonWriter = [[SBJSON new] autorelease];
//    NSArray* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"Get Started",@"name",
//                                    @"http://m.facebook.com/apps/my_ios_app/",@"link", nil], nil];
//    NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
    // Dialog parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   fbAppId, @"app_id",
                                   @"my iOS test app", @"name",
                                   @"Test for iOS.", @"caption",
                                   @"Check out Test for iOS to learn how you can make your iOS apps social using Facebook Platform.", @"description",
                                   @"http://m.facebook.com/apps/my_ios_app/", @"link",
                                   @"http://fbrell.com/f8.jpg", @"picture",
//                                   actionLinksStr, @"actions",
                                   nil];

//    NSDictionary* attachment = [NSDictionary dictionaryWithObjectsAndKeys:
//                                @"name", @"name",
//                                @"caption", @"caption",
//                                @"description", @"description",
//                                @"http://lihuan.me/", @"href", nil];
    
//    NSMutableDictionary* params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                    @"131529600286680", @"api_key",
//                                    [jsonWriter stringWithObject:attachment], @"attachment",
//                                    nil];
    
    //[facebook dialog:@"stream.publish" andParams:params1 andDelegate:self disableTextArea:TRUE];
    [facebook dialog:@"feed" andParams:params andDelegate:self];
}

/*
 Send the app request
 */

//sendRequestButtonClicked
- (void) sendRequestButtonClicked:(id) sender
{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Check out this awesome app I am using.",  @"message",
                                   @"Check this out", @"notification_text",
                                   nil];
    
    [facebook dialog:@"apprequests"
           andParams:params
         andDelegate:self];
}

- (void)sendFriendsButtonClicked:(id)sender
{
    currGraphAPI = kGraphFriends;
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"name, picture", @"fields", nil];
    
    [facebook requestWithGraphPath:@"me/friends" andParams:param andDelegate:self];
}

- (void)dialogDidComplete:(FBDialog *)dialog
{
    NSLog(@"dialog completed successfully");
}

/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin
{
    [self showLoggedIn];
    
    NSLog(@"facebook accessToken : %@", [facebook accessToken]);
    
    // Save authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

- (void)fbDidLogout
{
    NSLog(@"facebook did logout");
    [self showLoggedOut:YES];
}

/**
 * Called when the user canceled the authorization dialog.
 */
- (void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"did not login");
}

#pragma mark -

- (void)showLoggedIn 
{
    loginButton.hidden = YES;
    loggedInView.hidden = NO;
}

- (void)showLoggedOut:(BOOL)clearInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (clearInfo && [defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
        
        // Nil out the session variables to prevent
        // the app from thinking there is a valid session
        if (nil != [facebook accessToken]) {
            facebook.accessToken = nil;
        }
        if (nil != [facebook expirationDate]) {
            facebook.expirationDate = nil;
        }
    }
    
    profileNameLabel.text = @"";
    [profileImageView setImage:nil];
    
    loginButton.hidden = NO;
    loggedInView.hidden = YES;

}

//视图即将可见时调用
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    if (![facebook isSessionValid]) {
        [self showLoggedOut:NO];
    } else {
        [self showLoggedIn];
    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.loginButton = nil;
    self.logoutButton = nil;
    self.showMeButton = nil;
    self.feedButton = nil;
    self.requestButton = nil;
    self.friendsButton = nil;
    self.profileImageView = nil;
    self.profileNameLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

- (void)dealloc {
    [loginButton release];
    [logoutButton release];
    [showMeButton release];
    [feedButton release];
    [requestButton release];
    [friendsButton release];
    [profileImageView release];
    [profileNameLabel release];
    [super dealloc];
}

@end
