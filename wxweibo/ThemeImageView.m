//
//  ThemeImageView.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-25.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"
#import "ThemeButton.h"

@implementation ThemeImageView

- (id)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanaged:) name:kThemeChangedNotification object:nil];
    }
    return self;
}

- (void)themeChanaged:(NSNotification *)notification
{
    [self themeImage];
}

- (void)themeImage
{
    UIImage *image = [[ThemeManager shareInstance] themeImageWithName:self.imageName];
    self.image = image;
}

- (id)initWithImageName:(NSString *)imageName
{
    self = [self init];
    if (self) {
         self.imageName = imageName;
    }
    return self;
}

- (void)setImageName:(NSString *)imageName
{
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName retain];
        [self themeImage];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanaged:) name:kThemeChangedNotification object:nil];
}



@end
























