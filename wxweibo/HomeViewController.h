//
//  HomeViewController.h
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-22.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"
#import "WeiboTableView.h"

@interface HomeViewController : BaseViewController <SinaWeiboRequestDelegate,RefreshTableViewDelegate>

@property (retain, nonatomic) IBOutlet WeiboTableView *tableView;


@end
