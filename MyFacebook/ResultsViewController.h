//
//  ResultsViewController.h
//  MyFacebook
//
//  Created by  on 11-11-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsViewController : UITableViewController
{
    NSMutableDictionary *myData;
}

@property (nonatomic, retain) NSMutableDictionary *myData;

- (id)initWithTitle:(NSString *)title data:(NSDictionary *)data;

@end
