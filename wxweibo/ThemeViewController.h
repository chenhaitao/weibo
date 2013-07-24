//
//  ThemeViewController.h
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-24.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "BaseViewController.h"

@interface ThemeViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
