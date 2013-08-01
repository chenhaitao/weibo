//
//  WeiboTableView.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-30.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "WeiboView.h"


@implementation WeiboTableView



#pragma mark - UITableView delegate and datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboCell *cell = nil;
    static NSString *cellIdentifier = @"WeiboCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.weiboModel = self.data[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [WeiboView heightForWeiboView:self.data[indexPath.row] andIsRepost:NO andIsDetail:NO];
    
    return height + 60;
}



#pragma mark -

@end
