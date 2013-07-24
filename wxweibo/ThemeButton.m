//
//  ThemeButton.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-24.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"


@implementation ThemeButton

//加载主题图片
- (void)loadImage
{
    ThemeManager *themeManager = [ThemeManager shareInstance];
    [self setImage:[themeManager themeImageWithName:self.imageName] forState:UIControlStateNormal];
    [self setImage:[themeManager themeImageWithName:self.highlightedImageName] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[themeManager themeImageWithName:self.backgroundImageName] forState:UIControlStateNormal];
    [self setBackgroundImage:[themeManager themeImageWithName:self.backgroundHighlightedImageName] forState:UIControlStateHighlighted];
    
    
}


- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChagned:) name:kThemeChangedNotification object:nil];
    }
    return self;
}

- (void)themeChagned:(NSNotification *)notification
{
    [self loadImage];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.imageName = nil;
    self.highlightedImageName = nil;
    self.backgroundImageName = nil;
    self.backgroundHighlightedImageName = nil;
    
    [super dealloc];
}

- (id)initWithImage:(NSString *)imageName andHighlightedImage:(NSString *)highlightedImageName
{
    self = [self init];
    if (self) {
        self.imageName = imageName;
        self.highlightedImageName = highlightedImageName;
       [self loadImage];
    }
    
    return self;
}

- (id)initWithBackgroundImage:(NSString *)backgroundImageName andHighlightedImage:(NSString *)highligthedImageName
{
    self = [self init];
    if (self) {
        self.backgroundImageName = backgroundImageName;
        self.backgroundHighlightedImageName = highligthedImageName;
        [self loadImage];
    }
    
    return self;
}

- (void)setImageName:(NSString *)imageName
{
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName retain];
        [self loadImage];
    }
}

- (void)setHighlightedImageName:(NSString *)highlightedImageName
{
    if (_highlightedImageName != highlightedImageName) {
        [_highlightedImageName release];
        _highlightedImageName = [highlightedImageName retain];
        [self loadImage];
    }
}

- (void)setBackgroundImageName:(NSString *)backgroundImageName
{
    if (_backgroundImageName != backgroundImageName) {
        [_backgroundImageName release];
        _backgroundImageName = [backgroundImageName retain];
        [self loadImage];
    }
}

- (void)setBackgroundHighlightedImageName:(NSString *)backgroundHighlightedImageName
{
    if (_backgroundHighlightedImageName != backgroundHighlightedImageName) {
        [_backgroundHighlightedImageName release];
        _backgroundHighlightedImageName = [backgroundHighlightedImageName retain];
        [self loadImage];
    }
}


@end

















