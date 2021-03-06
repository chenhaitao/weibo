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
#import "Factory.h"

@interface ThemeViewController ()

@property (nonatomic,strong) NSArray *themes;

@end

@implementation ThemeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = @"皮肤选择";
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
    return self.themes.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        UILabel *label = [Factory createLabelWithFontColorName:@"kThemeListLabel"];
        CGRect frame = cell.bounds;
        frame.origin = CGPointMake(10, 5);
        label.frame = frame;
        label.tag = 1;
        [cell addSubview:label];
        
    }
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    if (indexPath.row == 0) {
         label.text = @"默认";
    }else{
        label.text = self.themes[indexPath.row - 1];
    }
    
    NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:@"themeKey"];
    
    if (row == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThemeManager *themeManager = [ThemeManager shareInstance];
    if (indexPath.row == 0) {
        themeManager.themeName =nil;
    }else{
        themeManager.themeName = self.themes[indexPath.row - 1];
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"themeKey"];
    [tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeChangedNotification object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
