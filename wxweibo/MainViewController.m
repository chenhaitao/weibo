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
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self  _initViewController];
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
    // Dispose of any resources that can be recreated.
}

@end
