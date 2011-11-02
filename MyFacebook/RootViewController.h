//
//  RootViewController.h
//  MyFacebook
//
//  Created by  on 11-10-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

typedef enum graphAPI
{
    kGraphMe,
    kGraphFriends,
} graphAPI;

@interface RootViewController : UIViewController <FBRequestDelegate, FBSessionDelegate, FBDialogDelegate>
{
    Facebook *facebook;
    UIButton *loginButton;
    UIButton *logoutButton;
    UIButton *showMeButton;
    UIButton *feedButton;
    UIButton *requestButton;
    UIButton *friendsButton;
    UIImageView *profileImageView;
    UILabel *profileNameLabel;
    UIView *loggedInView;
    int currGraphAPI;
}

@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) UIButton *loginButton;
@property (nonatomic, retain) UIButton *logoutButton;
@property (nonatomic, retain) UIButton *showMeButton;
@property (nonatomic, retain) UIButton *feedButton;
@property (nonatomic, retain) UIButton *requestButton;
@property (nonatomic, retain) UIButton *friendsButton;
@property (nonatomic, retain) UIImageView *profileImageView;
@property (nonatomic, retain) UILabel *profileNameLabel;
@property (nonatomic, retain) UIView *loggedInView;

- (void)showLoggedIn;
- (void)showLoggedOut:(BOOL)clearInfo;

@end
