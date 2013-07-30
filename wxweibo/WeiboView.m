//
//  WeiboView.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-26.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "WeiboView.h"
#import "RTLabel.h"
#import "Factory.h"
#import "UIImageView+WebCache.h"
#import "NSString+URLEncoding.h"
#import "RegexKitLite.h"


@interface WeiboView ()

@property (nonatomic,strong)RTLabel *textLabel;//微博内容
@property (nonatomic,strong)UIImageView *imageView;//微博图片
@property (nonatomic,strong)ThemeImageView *repostViewBackgroundView;//转发微博视图的背景图片

@end

@implementation WeiboView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initSubViews];
    }
    return self;
}

- (void)_initSubViews
{
    //微博内容初始化
    self.textLabel = [[[RTLabel alloc] initWithFrame:CGRectZero] autorelease];
    self.textLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"blue" forKey:@"color"];
    self.textLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"red" forKey:@"color"];
    self.textLabel.font = [UIFont systemFontOfSize:14.0f];
    self.textLabel.userInteractionEnabled = YES;
    self.textLabel.delegate = self;
    [self addSubview:self.textLabel];
    
    //微博图片初始化
    self.imageView = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
    self.imageView.image = [UIImage imageNamed:@"page_image_loading.png"];
    [self addSubview:self.imageView];
    
    //初始化转发的微博的背景图片
    self.repostViewBackgroundView = (ThemeImageView *)[Factory createImageViewWithImageName:@"timeline_retweet_background.png" withEdgeInset: UIEdgeInsetsMake(10, 25, 5, 5)];
    self.repostViewBackgroundView.userInteractionEnabled = YES;
    [self insertSubview:self.repostViewBackgroundView atIndex:0];
    
}

#pragma mark - RTLabelDelegate method
//点击超链接处理事件
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    NSString *urlStr = [url absoluteString];
    if ([urlStr hasPrefix:@"user"]) {
        NSString *user = [[url host] URLDecodedString];
        NSLog(@"%@",user);
    }else if([urlStr  hasPrefix:@"http"]){
        NSString *http = [urlStr URLDecodedString];
        NSLog(@"%@",http);
    }else if([urlStr hasPrefix:@"topic"]){
        NSString *topic = [[url host] URLDecodedString];
        NSLog(@"%@",topic);
    }
}

#pragma mark -

- (void)setWeiboModel:(WeiboModel *)weiboModel
{
    if (_weiboModel != weiboModel) {
        [_weiboModel release];
        _weiboModel = [weiboModel retain];
    }
    
    //创建转发微博视图
    if (self.repostView == nil) {
        self.repostView = [[[WeiboView alloc] initWithFrame:CGRectZero] autorelease];
        self.repostView.isRepost = YES;
        [self addSubview:self.repostView];
    }
    
    [self changeLinkString];
}

- (void)changeLinkString
{
    
    NSString *text = self.weiboModel.text;
    
    if (self.linkString) {
        [self.linkString setString:@""];
    }else{
        self.linkString = [NSMutableString string];
    }
    
    NSString *relexStr = @"(@\\w+)|(#\\w+#)|(http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?)";
    NSArray *strs = [self.weiboModel.text componentsMatchedByRegex:relexStr];
    NSString *replaceString = nil;
    for (NSString *str in strs) {
        if ([str hasPrefix:@"@"]) {
            replaceString = [NSString stringWithFormat:@"<a href='user://%@'>%@</a>",[str  URLEncodedString],str];
        }else if([str hasPrefix:@"http"]){
            replaceString = [NSString stringWithFormat:@"<a href='%@'>%@</a>",[str  URLEncodedString],str];
        }else if([str hasPrefix:@"#"]){
            replaceString = [NSString stringWithFormat:@"<a href='topic://%@'>%@</a>",[str  URLEncodedString],str];
        }
    text = [text stringByReplacingOccurrencesOfString:str withString:replaceString];
    }
    
    
   [self.linkString appendString:text];
}


//展示数据，设置布局
- (void)layoutSubviews
{
    [super layoutSubviews];
        
    //微博内容子视图
    self.textLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 0);
    CGFloat sizeFont = [WeiboView fontSize:self.isDetail isRepost:self.isRepost];
    self.textLabel.font = [UIFont systemFontOfSize:sizeFont];
    //判断当前视图是否为转发视图
    if (self.isRepost) {
        self.textLabel.frame = CGRectMake(10, 10, self.bounds.size.width - 20, 0);
    }
    self.textLabel.text = self.linkString;
    CGSize size = self.textLabel.optimumSize;
    self.textLabel.height = size.height;
    
    //设置转发微博视图
    if (self.weiboModel.relWeibo != nil) {
        CGFloat height = [WeiboView heightForWeiboView:self.weiboModel.relWeibo andIsRepost:YES andIsDetail:NO];
        self.repostView.frame = CGRectMake(0, self.textLabel.bottom, self.width, height);
        self.repostView.weiboModel = self.weiboModel.relWeibo;
        self.repostView.hidden = NO;
    }else{
        self.repostView.hidden = YES;
    }
    
    //设置微博图片
    NSString *imageName = self.weiboModel.thumbnailImage;
    if (imageName.length > 0) {
        self.imageView.hidden = NO;
        self.imageView.frame = CGRectMake(10,self.textLabel.bottom , 70, 80);
        [self.imageView setImageWithURL:[NSURL URLWithString:imageName]];
    }else{
        self.imageView.hidden = YES;
    }
    
    //设置转发微博的背景图片
    if (self.isRepost) {
        self.repostViewBackgroundView.frame = self.bounds;
        self.repostViewBackgroundView.hidden = NO;
    }else{
        self.repostViewBackgroundView.hidden = YES;
    }
    
}





//获取微博文本字体
+ (CGFloat)fontSize:(BOOL)isDetail isRepost:(BOOL)isRepost
{
    CGFloat result = 14.0f;
    if (isDetail && !isRepost) {
        result = 18.0f;
    }else if(isDetail && isRepost){
        result = 17.0f;
    }else if(!isDetail && !isRepost){
        result = 14.0f;
    }else if(!isDetail && isRepost){
        result = 13.0f;
    }
    
    return result;
}

//获取weiboView的高度
+ (CGFloat)heightForWeiboView:(WeiboModel *)weiboModel andIsRepost:(BOOL)isRepost andIsDetail:(BOOL)isDetail
{
    CGFloat height = 0;
    
    RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectZero];
    CGFloat fontSize = [WeiboView fontSize:isDetail isRepost:isRepost];
    label.font = [UIFont systemFontOfSize:fontSize];
    if (isDetail) {
        label.width = kWeiboViewDetailWidth;
    }else{
        label.width = kWeiboViewListWidth;
    }
    if (isRepost) {
        label.width -= 20;
    }
    
    label.text = weiboModel.text;
    CGSize size = label.optimumSize;
    height += size.height;
    
    if (weiboModel.thumbnailImage.length > 0) {
        height += 80;
    }
    
    if (weiboModel.relWeibo) {
        height += [WeiboView heightForWeiboView:weiboModel.relWeibo andIsRepost:YES andIsDetail:isDetail];
    }
    
    if (isRepost) {
        height += 20;
    }
    
    return height;
}

@end



















