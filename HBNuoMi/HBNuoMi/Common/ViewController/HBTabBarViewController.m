//
//  HBTabBarViewController.m
//  HBNuoMi
//
//  Created by wangfeng on 15/11/5.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "HBTabBarViewController.h"
#import "HBNavigationController.h"
@interface HBTabBarViewController ()

@end

@implementation HBTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTabBar];
    
        // UIColor *titleHighlightedColor = [UIColor colorWithRed:153/255.0 green:192/255.0 blue:48/255.0 alpha:1.0];
}

-(void)configTabBar
{
   
    HBNavigationController* baseNavi_0 = [[HBNavigationController alloc]initWithRootViewController:[UIViewController new]];
    HBNavigationController* baseNavi_1 = [[HBNavigationController alloc]initWithRootViewController:[UIViewController new]];
    HBNavigationController* baseNavi_2 = [[HBNavigationController alloc]initWithRootViewController:[UIViewController new]];
    HBNavigationController* baseNavi_3 = [[HBNavigationController alloc]initWithRootViewController:[UIViewController new]];

    self.viewControllers = @[baseNavi_0,baseNavi_1,baseNavi_2,baseNavi_3];
    UITabBarItem* item_0 = self.tabBar.items[0];
    item_0.title = @"首页";
    item_0.image = [[UIImage imageNamed:@"icon_tab_shouye_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item_0.selectedImage = [[UIImage imageNamed:@"icon_tab_shouye_highlight"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 
    
    UITabBarItem* item_1 = self.tabBar.items[1];
    item_1.title = @"附近";
    item_1.image = [[UIImage imageNamed:@"icon_tab_fujin_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item_1.selectedImage = [[UIImage imageNamed:@"icon_tab_fujin_highlight"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem* item_2 = self.tabBar.items[2];
    item_2.title = @"精选";
    item_2.image = [[UIImage imageNamed:@"tab_icon_selection_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item_2.selectedImage = [[UIImage imageNamed:@"tab_icon_selection_highlight"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem* item_3 = self.tabBar.items[3];
    item_3.title = @"我的";
    item_3.image = [[UIImage imageNamed:@"icon_tab_wode_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item_3.selectedImage = [[UIImage imageNamed:@"icon_tab_wode_highlight"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.tintColor = [UIColor colorWithRed:1 green:70.0/255 blue:131.0/255 alpha:1];


    
    
    
}

@end
