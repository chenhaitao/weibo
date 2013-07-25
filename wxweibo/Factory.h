//
//  Factory.h
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-24.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject

+ (UIButton *)createButtonWithImage:(NSString *)imageName andHighlightedImage:(NSString *)highlighttedImageName;
+ (UIButton *)createButtonWithBackgroundImage:(NSString *)backgroundImageName andHightedImage:(NSString *)highlighttedBackgroundImageName;

+ (UIImageView *)createImageViewWithImageName:(NSString *)imageName;

+ (UILabel *)createLabelWithFontColorName:(NSString *)fontColorName;

@end
