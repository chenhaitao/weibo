//
//  BaseNavigationController.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-21.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "BaseNavigationController.h"
#import "ThemeManager.h"
#import "ThemeButton.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged:) name:kThemeChangedNotification  object:nil];
        
    }
    return self;
}

- (void)themeChanged:(NSNotification *)notification
{
    [self customNavigationbarWithThemeImage];
}

- (void)customNavigationbarWithThemeImage
{
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        
        UIImage *image = [[ThemeManager shareInstance] themeImageWithName:@"navigationbar_background.png"];
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationBar setNeedsDisplay];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customNavigationbarWithThemeImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
