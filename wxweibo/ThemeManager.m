//
//  ThemeManager.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-24.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "ThemeManager.h"

static ThemeManager *shareInstance;

@implementation ThemeManager

#pragma mark - 
#pragma mark 创建相应的单例对象
+ (id)shareInstance
{
    if (shareInstance == nil) {
        @synchronized(self){
            shareInstance = [[ThemeManager alloc] init];
        }
    }
    return shareInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (shareInstance == nil) {
            shareInstance = [super allocWithZone:zone];
        }
    }
    return shareInstance;
}

- (id)copy
{
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return INT32_MAX;
}

- (oneway void)release
{

}

#pragma mark - 重写初始化方法

- (id)init
{
    self = [super init];
    if (self) {
        NSString *themesPlistPath = [[NSBundle mainBundle] pathForResource:@"themes" ofType:@"plist"];
        self.themesPlist = [NSDictionary dictionaryWithContentsOfFile:themesPlistPath];
        self.themeName = nil;
    }
    return self;
}

#pragma mark -
//获取相应主题的路径
- (NSString *)_themePath
{
    if (self.themeName == nil) {
        return [[NSBundle mainBundle] resourcePath];
    }
    
    NSString *themePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.themesPlist[self.themeName]];
    return themePath;
}

//获取主题图片
- (UIImage *)themeImageWithName:(NSString *)imageName
{
    if (imageName.length == 0) {
        return nil;
    }
    
    NSString *imagePath = [[self _themePath] stringByAppendingPathComponent:imageName];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    
    return [image autorelease];
}

- (void)setThemeName:(NSString *)themeName
{
    if (_themeName != themeName) {
        [_themeName release];
        _themeName = [themeName retain];
    }
    
    NSString *filePath = [[self _themePath] stringByAppendingPathComponent:@"fontColor.plist"];
    self.labelThemesPlist = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
}


- (UIColor *)themeColorWithName:(NSString *)name
{
    NSString *colorStr = self.labelThemesPlist[name];
    NSArray *colors = [colorStr componentsSeparatedByString:@","];
    if (colors.count == 3) {
        UIColor *color = [UIColor colorWithRed:[colors[0] floatValue]/255.0 green:[colors[1] floatValue]/255.0 blue:[colors[2] floatValue]/255.0 alpha:1];
        return color;
    }
    return nil;
}

@end









