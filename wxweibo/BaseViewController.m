//
//  BaseViewController.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-21.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "ThemeButton.h"
#import "Factory.h"

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
        
    }
    return self;
}



- (void)addCustomBackItem
{
    if (self.navigationController.viewControllers[0] != self) {
        UIButton *button = [Factory createButtonWithImage:@"navigationbar_back.png" andHighlightedImage:@"navigationbar_back_highlighted.png"];
        button.frame = CGRectMake(0, 0, 24, 24);
        [button addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = barButtonItem;
        [barButtonItem release];
    }
}

- (void)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addCustomBackItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end























