//
//  MainViewController.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-21.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationController.h"
#import "Factory.h"
#import "ThemeButton.h"
#import "ThemeManager.h"

@interface MainViewController ()

@end

@implementation MainViewController 
 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBar.hidden = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged:) name:kThemeChangedNotification object:nil];
    }
    return self;
}

- (void)themeChanged:(NSNotification *)nitification
{
    [self tabbarBackgroundThemeImage];
}

- (void)tabbarBackgroundThemeImage
{
    UIImage *image = [[ThemeManager shareInstance] themeImageWithName:@"tabbar_background.png"];
    self.tabbarView.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self  _initViewController];
    [self _initTabbarView];
}

- (void)_initTabbarView
{
    self.tabbarView = [[[UIView alloc] initWithFrame:CGRectMake(0, kScreenHight - 49 -20, kScreenWidth, 49)] autorelease];
    [self tabbarBackgroundThemeImage];
    
    NSArray *tabbarItemImages = @[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    NSArray *tabbarItemHighlightedImages = @[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
    for (int i=0; i<tabbarItemImages.count; i++) {
        UIButton *button = [Factory createButtonWithImage:tabbarItemImages[i] andHighlightedImage:tabbarItemHighlightedImages[i]];
        button.tag = i;
        button.frame = CGRectMake(((kScreenWidth/5)-30)/2 + (kScreenWidth/5 * i), (49-30)/2, 30, 30);
        [button addTarget:self action:@selector(selectTabbarItem:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(doubleSelectTabbarItem:) forControlEvents:UIControlEventTouchDownRepeat];
        [self.tabbarView addSubview:button];
    }
    
    
    [self.view addSubview:self.tabbarView];
}

- (void)selectTabbarItem:(UIButton *)button
{
    self.selectedIndex = button.tag;
}

- (void)doubleSelectTabbarItem:(UIButton *)button
{
    UIViewController *ctrl = self.viewControllers[button.tag];
    if ([ctrl isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)ctrl;
        [nav popToRootViewControllerAnimated:YES];
    }
    
}

- (void)_initViewController
{
    HomeViewController *home = [HomeViewController new];
    MessageViewController *message = [MessageViewController new];
    ProfileViewController *profile = [ProfileViewController new];
    DiscoverViewController *discover = [DiscoverViewController new];
    MoreViewController *more = [MoreViewController new];
    
    NSArray *controllers = @[home,message,profile,discover,more];
    [home release];
    [message release];
    [profile release];
    [discover release];
    [more release];
    NSMutableArray *tabbarViewControllers = [NSMutableArray arrayWithCapacity:5];
    for (BaseViewController *base in controllers) {
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:base];
        [tabbarViewControllers addObject:nav];
        [nav release];
    }
    self.viewControllers = tabbarViewControllers;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark sinaweibo delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSDictionary *dic = @{sinaweibo.accessToken :@"accessTokenKey",sinaweibo.expirationDate:@"expirationDateKey",sinaweibo.userID:@"userIDKey"};
//    [userDefault setObject:dic forKey:@"SinaWeiboAuthData"];
//    [userDefault synchronize];
    
    //保存认证的数据到本地
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{

}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{

}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{

}

#pragma mark -

@end






























