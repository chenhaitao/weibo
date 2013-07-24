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

@interface MainViewController ()

@end

@implementation MainViewController 
 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBar.hidden = YES;
    }
    return self;
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
    self.tabbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    
    NSArray *tabbarItemImages = @[@"tabbar_home",@"tabbar_message_center",@"tabbar_profile",@"tabbar_discover",@"tabbar_more"];
    NSArray *tabbarItemHighlightedImages = @[@"tabbar_home_highlighted",@"tabbar_message_center_highlighted",@"tabbar_profile_highlighted",@"tabbar_discover_highlighted",@"tabbar_more_highlighted"];
    for (int i=0; i<tabbarItemImages.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setImage:[UIImage imageNamed:tabbarItemImages[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:tabbarItemHighlightedImages[i]] forState:UIControlStateHighlighted];
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
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = @{sinaweibo.accessToken :@"accessTokenKey",sinaweibo.expirationDate:@"expirationDateKey",sinaweibo.userID:@"userIDKey"};
    [userDefault setObject:dic forKey:@"SinaWeiboAuthData"];
    [userDefault synchronize];
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






























