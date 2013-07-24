//
//  ThemeButton.h
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-24.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kThemeChangedNotification @"themeChangedNotification"

@interface ThemeButton : UIButton

//image
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *highlightedImageName;

//background image
@property (nonatomic,strong) NSString *backgroundImageName;
@property (nonatomic,strong) NSString *backgroundHighlightedImageName;

- (id)initWithImage:(NSString *)imageName andHighlightedImage:(NSString *)highlightedImageName;
- (id)initWithBackgroundImage:(NSString *)backgroundImageName andHighlightedImage:(NSString *)highligthedImageName;


@end
