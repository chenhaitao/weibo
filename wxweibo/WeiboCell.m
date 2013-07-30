//
//  WeiboCell.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-26.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "WeiboCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "WeiboView.h"
#import "RegexKitLite.h"

@interface WeiboCell ()

//用户头像
@property (nonatomic,strong) UIImageView *userImage;

//昵称
@property (nonatomic,strong) UILabel *nickLabel;

//转发次数
@property (nonatomic,strong) UILabel *repostCountLabel;

//评论次数
@property (nonatomic,strong) UILabel *commentCountLabel;

//微博来源
@property (nonatomic,strong) UILabel *sourceLabel;

//微博创建时间
@property (nonatomic,strong) UILabel *createlabel;

@end



@implementation WeiboCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initSubViews];
         self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
       
    }
    return self;
}

- (void)_initSubViews
{
    //用户头像
    self.userImage = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
    self.userImage.backgroundColor = [UIColor clearColor];
    self.userImage.layer.cornerRadius = 5.0f;
    self.userImage.layer.masksToBounds = YES;
    self.userImage.layer.borderColor = [[UIColor grayColor] CGColor];
    self.userImage.layer.borderWidth = 0.5f;
    [self.contentView addSubview:self.userImage];
    
    //用户昵称
    self.nickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nickLabel.backgroundColor = [UIColor clearColor];
    self.nickLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:self.nickLabel];
    
    //微博转发次数
    self.repostCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.repostCountLabel.backgroundColor = [UIColor clearColor];
    self.repostCountLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView  addSubview:self.repostCountLabel];
    
    //微博评论次数
    self.commentCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.commentCountLabel.backgroundColor = [UIColor clearColor];
    self.commentCountLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.commentCountLabel];
    
    //微博来源
    self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.sourceLabel.backgroundColor = [UIColor clearColor];
    self.sourceLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.sourceLabel];
    
    //微博创建时间
    self.createlabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.createlabel.backgroundColor = [UIColor clearColor];
    self.createlabel.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.createlabel];
    
    //微博视图
    self.weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.weiboView];
   
    
   
}


- (void)layoutSubviews
{
    //用户头像
    self.userImage.frame = CGRectMake(5, 5, 35, 35);
    [self.userImage setImageWithURL:[NSURL URLWithString:self.weiboModel.user.profile_image_url]];
    
    //用户昵称
    self.nickLabel.frame = CGRectMake(50, 5, 200, 20);
    self.nickLabel.text = self.weiboModel.user.screen_name;
    
    //微博视图
    self.weiboView.weiboModel = self.weiboModel;
    CGFloat height = [WeiboView heightForWeiboView:self.weiboModel andIsRepost:NO andIsDetail:NO];
    self.weiboView.frame = CGRectMake(50, self.nickLabel.bottom + 10,kWeiboViewListWidth, height);
    
     //微博创建时间
    NSString *createTime = self.weiboModel.createDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"E M dd HH:mm:ss z yyyy"];
    NSDate *createDate = [formatter dateFromString:createTime];
    [formatter setDateFormat:@"HH:mm M:dd"];
    NSString *dateStr = [formatter stringFromDate:createDate];
    if (dateStr.length > 0) {
        self.createlabel.hidden = NO;
        self.createlabel.text = dateStr;
        self.createlabel.frame = CGRectMake(50, self.weiboView.bottom, 100, 20);
        self.createlabel.textColor = [UIColor blueColor];
        [self.createlabel sizeToFit];
    }else{
        self.createlabel.hidden = YES;
    }
    
    //微博来源
    NSString *source = self.weiboModel.source;
    NSString *regexStr = @">\\w+<";
    NSArray *results = [source componentsMatchedByRegex:regexStr];
    if (results.count) {
        NSString *result = results[0];
        NSRange range = {1,result.length-2};
        result = [result substringWithRange:range];
        if (result.length) {
            self.sourceLabel.hidden = NO;
            self.sourceLabel.frame = CGRectMake(self.createlabel.right+ 10,self.createlabel.top  , 200, 20);
            self.sourceLabel.text = [NSString stringWithFormat:@"来自%@",result];
            [self.sourceLabel sizeToFit];
        }
    }else{
        self.sourceLabel.hidden = YES;
    }
    
    
    
    //设置cell选中的背景颜色,选中背景会自动的帮你将view的高和宽进行适配
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.height)];
    [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"statusdetail_cell_sepatator.png"]]];
    self.selectedBackgroundView = view;
    
}

@end






























