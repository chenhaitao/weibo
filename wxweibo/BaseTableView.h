//
//  BaseTableView.h
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-30.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@class BaseTableView;
@protocol RefreshTableViewDelegate <NSObject>

//下拉
- (void)pullDown:(BaseTableView *)tableview;

//上拉
- (void)pullUp:(BaseTableView *)tableView;

//选中
- (void)baseTableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseTableView : UITableView <EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>
//下拉刷新页面
@property (nonatomic,strong) EGORefreshTableHeaderView *refreshView;
//是否是刷新请求状态
@property (nonatomic,assign) BOOL reloading;
//是否需要下拉刷新
@property (nonatomic,assign) BOOL isNeedRefresh;

//tableView需要展示的数据集合
@property (nonatomic,strong) NSMutableArray *data;

//下拉，上拉，选中的处理代理对象
@property  (nonatomic,strong) id<RefreshTableViewDelegate>refreshDelegate;

- (void)doneLoadingTableViewData;

@end
