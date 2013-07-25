//
//  ThemeManager.h
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-24.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject
@property (nonatomic,strong) NSString *themeName;
@property (nonatomic,strong) NSDictionary *themesPlist;
@property (nonatomic,strong) NSDictionary *labelThemesPlist;


+ (id)shareInstance;

- (UIImage *)themeImageWithName:(NSString *)imageName;
- (UIColor *)themeColorWithName:(NSString *)name;
@end
