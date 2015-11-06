//
//  HBTableViewController.m
//  HBNuoMi
//
//  Created by wangfeng on 15/11/6.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "HBTableViewController.h"

@interface HBTableViewController ()

@end

@implementation HBTableViewController

#pragma mark - vc-life-circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
#pragma mark - public methords

#pragma mark - private-tools methords
- (void)initData
{
    
}
#pragma mark - property-setter-getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    }
    return _tableView;
}
#pragma mark - event methords


#pragma mark - delegate methords

@end
