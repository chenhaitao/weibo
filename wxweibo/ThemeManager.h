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


+ (id)shareInstance;

- (UIImage *)themeImageWithName:(NSString *)imageName;

@end
