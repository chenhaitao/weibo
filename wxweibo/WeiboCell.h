//
//  WeiboCell.h
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-26.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboView.h"
#import "WeiboModel.h"

@interface WeiboCell : UITableViewCell
//微博数据模型对象
@property (nonatomic,strong) WeiboModel *weiboModel;
//微博视图
@property (nonatomic,strong) WeiboView *weiboView;

@end
