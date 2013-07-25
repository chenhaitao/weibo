//
//  HomeViewController.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-22.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = @"微博";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"绑定帐户" style:UIBarButtonItemStylePlain target:self action:@selector(bindAction:)] autorelease];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logoutAction:)];
    
    //判断微博授权是否可用
    if (self.sinaWeibo.isLoggedIn) {
        [self loadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - action
- (void)bindAction:(UIBarButtonItem *)sender
{
    [self.sinaWeibo logIn];
}

- (void)logoutAction:(UIBarButtonItem *)sender
{
    [self.sinaWeibo logOut];
}
#pragma mark - loadData
- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"5" forKey:@"count"];
    [self.sinaWeibo requestWithURL:@"statuses/home_timeline.json" params:params httpMethod:@"GET" delegate:self];
}

#pragma mark -
#pragma mark SinaWeiboRequestDelegate methods
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",[error localizedDescription]);
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"%@",result);
}


@end








