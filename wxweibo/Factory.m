//
//  Factory.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-24.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "Factory.h"
#import "ThemeButton.h"
#import "ThemeManager.h"
#import "ThemeLabel.h"
#import "ThemeImageView.h"

@implementation Factory

+ (UIButton *)createButtonWithImage:(NSString *)imageName andHighlightedImage:(NSString *)highlighttedImageName
{
   return  [[[ThemeButton alloc] initWithImage:imageName andHighlightedImage:highlighttedImageName] autorelease];
}

+ (UIButton *)createButtonWithBackgroundImage:(NSString *)backgroundImageName andHightedImage:(NSString *)highlighttedBackgroundImageName
{
    return [[[ThemeButton alloc]  initWithBackgroundImage:backgroundImageName andHighlightedImage:highlighttedBackgroundImageName] autorelease];
}


+ (UIImageView *)createImageViewWithImageName:(NSString *)imageName
{
   return  [[[ThemeImageView alloc] initWithImageName:imageName] autorelease];
}

+ (UILabel *)createLabelWithFontColorName:(NSString *)fontColorName
{
    return [[[ThemeLabel alloc] initWithColorName:fontColorName] autorelease];
}

@end
