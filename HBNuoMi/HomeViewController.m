//
//  HomeViewController.m
//  HBNuoMi
//
//  Created by wangfeng on 15/11/5.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "HomeViewController.h"
#import "HBCycleImageView.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIView* topHeadView;
@property (nonatomic, strong) HBCycleImageView* cycleImageView;
 
 
 
@end

@implementation HomeViewController


#pragma mark - vc-life-circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    [self addRightBarItemWith:@"icon_nav_saoyisao_normal"];
    [self initBar];
    [self initSubView];
           

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
- (void)initBar
{
     
    UIBarButtonItem* leftItemArea = [[UIBarButtonItem alloc]initWithTitle:@"深圳" style:UIBarButtonItemStylePlain target:nil action:nil];
  
    UIBarButtonItem* arrowItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_quxiao_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(barItemClick:)];

    self.navigationItem.leftBarButtonItems = @[leftItemArea,arrowItem];

    UISearchBar* searchBar = [[UISearchBar alloc]init];
    searchBar.placeholder = @"搜索商家或地点" ;
        // self.navigationController.navigationBar.topItem.titleView =
    self.navigationItem.titleView =  searchBar;

    BOOL b = [self.navigationItem isEqual:self.navigationController.navigationBar.topItem];
    ECLog(@"%d",b);

    

}
-(void)initSubView
{
    self.tableView.tableHeaderView = self.topHeadView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}
#pragma mark - property-setter-getter
-(UIView *)topHeadView
{
    if (!_topHeadView) {
        _topHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        
    }
    return _topHeadView;
}
-(HBCycleImageView *)cycleImageView
{
    if (!_cycleImageView) {
        _cycleImageView = [[HBCycleImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];

    }
    return _cycleImageView;
}
#pragma mark - event methords
-(void)barItemClick:(UIBarButtonItem*)sender
{
    UIViewController* vc = [UIViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - delegate methords
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 25;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text = @"测试一下";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
