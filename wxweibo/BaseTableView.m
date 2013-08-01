//
//  BaseTableView.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-30.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self _initView];
}

- (void)_initView
{
    self.refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0,0 -self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    self.refreshView.delegate = self;
   
    
    self.delegate = self;
    self.dataSource = self;
    self.isNeedRefresh = YES;
}

- (void)setIsNeedRefresh:(BOOL)isNeedRefresh
{
    _isNeedRefresh = isNeedRefresh;
    if (isNeedRefresh) {
         [self addSubview:self.refreshView];
    }else{
        if (self.refreshView.superview) {
            [self.refreshView removeFromSuperview];
        }
    }
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	self.reloading = YES;
    
    if ([self.refreshDelegate respondsToSelector:@selector(pullDown:)]) {
        [self.refreshDelegate pullDown:self];
    }
}

- (void)doneLoadingTableViewData{
	self.reloading = NO;
	[self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[self.refreshView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[self.refreshView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
    
}

//是否是在下载数据
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return self.reloading; 	
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; 	
}

//选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate  baseTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)dealloc
{
    self.refreshView = nil;
    self.data = nil;
    [super dealloc];
}
@end
