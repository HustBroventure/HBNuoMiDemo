//
//  HBNavigationController.m
//  HBNuoMi
//
//  Created by wangfeng on 15/11/5.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "HBNavigationController.h"

@interface HBNavigationController ()

@end

@implementation HBNavigationController

-(instancetype)init
{
    if (self = [super init]) {

    }
    return self;
}
#pragma mark - vc-life-circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.tintColor = BASE_STYLE_COLOR;
    UIImage* backImage =   [UIImage imageNamed:@"icon_nav_fanhui_normal"];
    UIImage* backTMImage = [UIImage imageNamed:@"icon_nav_fanhui_pressed"];
        //backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationBar.backIndicatorImage= backImage;
    self.navigationBar.backIndicatorTransitionMaskImage = backTMImage;
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
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    viewController.navigationItem.backBarButtonItem = item;
    [super pushViewController:viewController animated:animated];
    
       
   

}
#pragma mark - private-tools methords
- (void)initData
{
    
}
#pragma mark - property-setter-getter


#pragma mark - event methords


#pragma mark - delegate methords


@end
