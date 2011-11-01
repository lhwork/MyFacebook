//
//  FrieldsViewController.h
//  MyFacebook
//
//  Created by  on 11-11-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrieldsViewController : UITableViewController
{
    NSMutableArray *frields;
}

@property (nonatomic, retain) NSMutableArray *frields;

- (id)initWithTitle:(NSString *)title data:(NSMutableArray *)data;

@end
