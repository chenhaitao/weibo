//
//  ThemeLabel.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-25.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeLabel

- (id)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanaged:) name:kThemeChangedNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.colorName = nil;
    [super dealloc];
}

- (void)themeChanaged:(NSNotification *)nitification
{
    [self loadThemeColor];
}


- (void)loadThemeColor
{
    UIColor *color = [[ThemeManager shareInstance] themeColorWithName:self.colorName];
    self.textColor = color;
}

- (void)setColorName:(NSString *)colorName
{
    if (_colorName != colorName) {
        [_colorName release];
        _colorName = [colorName retain];
    }
    
    [self loadThemeColor];
}

- (id)initWithColorName:(NSString*)colorName
{
    self = [self init];
    if (self) {
        self.colorName = colorName;
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanaged:) name:kThemeChangedNotification object:nil];
}

@end
























