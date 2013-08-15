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
    
    self.tableView.refreshDelegate = self;
    
    
    //判断微博授权是否可用
    if (self.sinaWeibo.isLoggedIn) {
        [self loadData];
    }
    
   

}

- (void)pullDownLoadData
{//since_id
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"20" forKey:@"count"];
    if (self.topWeiboId.length == 0) {
        NSLog(@"topWeiboId为空！");
        [self.tableView performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1];
        return;
    }
    [params setObject:self.topWeiboId forKey:@"since_id"];
    [self.sinaWeibo requestWithURL:@"statuses/home_timeline.json" params:params httpMethod:@"GET" block:^(id result) {
        
        NSArray *statuses = [result objectForKey:@"statuses"];
        NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statuses.count];
        for (NSDictionary *dic in statuses) {
            WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:dic];
            [weibos addObject:weibo];
            [weibo release];
        }
        
        if (weibos.count > 0) {
            WeiboModel *weibo = (WeiboModel *)[weibos objectAtIndex:0];
            self.topWeiboId = weibo.weiboId.stringValue;
            [weibos addObjectsFromArray:self.weibos];
            self.weibos = weibos;
            self.tableView.data = self.weibos;
            [self.tableView reloadData];
        }
        
        [self.tableView doneLoadingTableViewData];
        
        //显示了刷新了多少条微博
        NSInteger number = weibos.count;
        NSLog(@"更新微博%i条！",number);
    }];
}


#pragma mark - refreshDelegate methods
- (void)pullDown:(BaseTableView *)tableview
{
    [self pullDownLoadData];
    //[tableview performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3];
}

- (void)pullUp:(BaseTableView *)tableView
{

}

- (void)baseTableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark -


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
    [params setObject:@"20" forKey:@"count"];
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
    
    
    
    if (weibos.count > 0) {
        WeiboModel *weibo = (WeiboModel *)[weibos objectAtIndex:0];
        self.topWeiboId = weibo.weiboId.stringValue;
        self.tableView.data = weibos;
        [self.tableView reloadData];
    }
    
    
}




- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end








