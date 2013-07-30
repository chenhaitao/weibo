//
//  WeiboView.h
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-26.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboView.h"
#import "RTLabel.h"
#import "ThemeImageView.h"

#define kWeiboViewListWidth (320 - 60)
#define kWeiboViewDetailWidth 300

@interface WeiboView : UIView <RTLabelDelegate>
//微博数据模型对象
@property (nonatomic,strong) WeiboModel *weiboModel;
//转发的微博视图
@property (nonatomic,strong) WeiboView *repostView;
//当前的微博视图是否是转发的
@property (nonatomic,assign) BOOL isRepost;

//当前微博视图是否在详情页面
@property (nonatomic,assign) BOOL isDetail;
//将超链接替换后的微博内容
@property (nonatomic,strong) NSMutableString *linkString;

//获取微博文本字体
+ (CGFloat)fontSize:(BOOL)isDetail isRepost:(BOOL)isRepost;

//获取weiboView的高度
+ (CGFloat)heightForWeiboView:(WeiboModel *)weiboModel andIsRepost:(BOOL)isRepost andIsDetail:(BOOL)isDetail;

@end
