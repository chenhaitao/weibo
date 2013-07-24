//
//  AppDelegate.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-21.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "DDMenuController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "SinaWeibo.h"


@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    self.mainViewController = nil;
    self.sinaWeibo = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    self.mainViewController = [[[MainViewController alloc]  init] autorelease];
    LeftViewController *leftViewController = [[LeftViewController alloc] init];
    RightViewController *rightViewController = [[RightViewController alloc] init];
    
    //DDMenuController不持有mainViewController，leftViewController，rightViewController ，因此在此处不能对这几个控制器进行内存释放，需要当menuViewController被释放的时候释放他们的内存，也就是在程序退出时，共同释放所有内存
    DDMenuController *menuViewController = [[DDMenuController alloc] initWithRootViewController:self.mainViewController];
    menuViewController.leftViewController = leftViewController;
    menuViewController.rightViewController = rightViewController;
    
    //初始化微博
    [self _initSinaWeibo];
    
    self.window.rootViewController = menuViewController;
    [menuViewController release];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

//初始化微博
- (void)_initSinaWeibo
{
    self.sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kAppKey  appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self.mainViewController];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *paramsDic = [userDefaults objectForKey:@"SinaWeiboAuthData"];
    
    if ([paramsDic objectForKey:@"accessTokenKey"]
        && [paramsDic objectForKey:@"expirationDateKey"]
        && [paramsDic objectForKey:@"userIDKey"]) {
        self.sinaWeibo.accessToken = [paramsDic objectForKey:@"accessTokenKey"];
        self.sinaWeibo.expirationDate = [paramsDic objectForKey:@"expirationDateKey"];
        self.sinaWeibo.userID = [paramsDic objectForKey:@"userIDKey"];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
