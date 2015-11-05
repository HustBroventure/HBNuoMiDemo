//
//  HBBaseViewController.m
//  HBNuoMi
//
//  Created by wangfeng on 15/11/5.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "HBBaseViewController.h"

@interface HBBaseViewController ()

@end

@implementation HBBaseViewController

#pragma mark - vc-life-circle
- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)addRightBarItemWith:(NSString*)imageName
{
    UIImage* itemImage = [UIImage imageNamed:@"icon_nav_cart_normal"];
    itemImage = [itemImage imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithImage:itemImage style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
    item.tag = 100;

    UIImage* itemImage2 = [UIImage imageNamed:imageName];
    itemImage2 = [itemImage2 imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithImage:itemImage2 style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
    item2.tag = 200;

    self.navigationItem.rightBarButtonItems = @[item2, item];
}
#pragma mark - private-tools methords
- (void)initData
{

}
#pragma mark - property-setter-getter


#pragma mark - event methords
-(void)rightClick:(UIBarButtonItem*)sender
{
    
}

#pragma mark - delegate methords

@end
