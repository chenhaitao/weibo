//
//  MainViewController.h
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-21.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@interface MainViewController : UITabBarController <SinaWeiboDelegate>

@property (nonatomic,strong) UIView *tabbarView;
@property (nonatomic,strong) UIView *sliderView;

@end
