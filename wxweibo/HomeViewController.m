//
//  HomeViewController.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-22.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboModel.h"
#import "WeiboCell.h"
#import "NSString+RMURLEncoding.h"

@interface HomeViewController ()

@property (nonatomic,strong) NSMutableArray *weiboData;

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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

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
    NSArray *statuses = [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statuses.count];
    for (NSDictionary *dic in statuses) {
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:dic];
        [weibos addObject:weibo];
        [weibo release];
    }
    self.weiboData = weibos;
    [self.tableView reloadData];
}

#pragma mark - UITableView delegate and datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weiboData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboCell *cell = nil;
    static NSString *cellIdentifier = @"WeiboCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
   
    cell.weiboModel = self.weiboData[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [WeiboView heightForWeiboView:self.weiboData[indexPath.row] andIsRepost:NO andIsDetail:NO];
    
    return height + 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

#pragma mark -


- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end








