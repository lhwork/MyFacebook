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
    UIImageView *profileImageView;
    UILabel *profileNameLabel;
    UIView *loggedInView;
    int currGraphAPI;
}

@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) UIButton *loginButton;
@property (nonatomic, retain) UIImageView *profileImageView;
@property (nonatomic, retain) UILabel *profileNameLabel;
@property (nonatomic, retain) UIView *loggedInView;

@end
