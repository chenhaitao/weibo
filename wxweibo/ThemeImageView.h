//
//  ThemeImageView.h
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-25.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,assign) UIEdgeInsets edgeInset;

- (id)initWithImageName:(NSString *)imageName ithEdgeInset:(UIEdgeInsets)edgeInset;

@end
