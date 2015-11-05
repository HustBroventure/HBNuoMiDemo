//
//  SelectionViewController.m
//  HBNuoMi
//
//  Created by wangfeng on 15/11/5.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "SelectionViewController.h"

@interface SelectionViewController ()

@end

@implementation SelectionViewController

#pragma mark - vc-life-circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"精选";
    [self addRightBarItemWith:@"icon_nav_saoyisao_normal"];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - private-tools methords
- (void)initData
{

}
#pragma mark - property-setter-getter


#pragma mark - event methords


#pragma mark - delegate methords


@end
