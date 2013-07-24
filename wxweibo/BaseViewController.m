//
//  BaseViewController.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-21.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (SinaWeibo *)sinaWeibo
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.sinaWeibo;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
