//
//  AppDelegate.h
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-21.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@class MainViewController;
@class SinaWeibo;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainViewController;
@property (strong, nonatomic) SinaWeibo *sinaweibo;

@end
