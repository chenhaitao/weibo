//
//  ThemeViewController.m
//  wxweibo
//
//  Created by 陈 海涛 on 13-7-24.
//  Copyright (c) 2013年 陈 海涛. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeManager.h"
#import "ThemeButton.h"

@interface ThemeViewController ()

@property (nonatomic,strong) NSArray *themes;

@end

@implementation ThemeViewController

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
	self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.themes = [[[ThemeManager shareInstance] themesPlist] allKeys];
}

#pragma mark - UITableView delegate and dataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.themes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.textLabel.text = self.themes[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThemeManager *themeManager = [ThemeManager shareInstance];
    themeManager.themeName = self.themes[indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeChangedNotification object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
