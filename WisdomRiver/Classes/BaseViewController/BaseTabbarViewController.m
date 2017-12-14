//
//  BaseTabbarViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/14.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "HomeViewController.h"
#import "BaseNaviViewController.h"
#import "MineViewController.h"
#import "BussinessViewController.h"
#import "PublickViewController.h"
@interface BaseTabbarViewController ()

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = ThemeColor;
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 初始化主tabbar

- (void)setUp {
    //首页
    BaseNaviViewController *homeNav = [[BaseNaviViewController alloc]initWithRootViewController:[HomeViewController new]];
    
    [homeNav.tabBarItem setImage:[[UIImage imageNamed:@"首页未选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [homeNav.tabBarItem setSelectedImage:[[UIImage imageNamed:@"首页选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //[home.tabBarItem setSelectedImage:[UIImage imageNamed:@"商城-已选中"]];
    homeNav.tabBarItem.title = @"政务服务";
    //社区
    BaseNaviViewController *community = [[BaseNaviViewController alloc]initWithRootViewController:[PublickViewController new]];
    [community.tabBarItem setImage:[[UIImage imageNamed:@"公共服务未选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [community.tabBarItem setSelectedImage:[[UIImage imageNamed:@"公共服务选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    community.tabBarItem.title = @"公共服务";
    //安装
    BaseNaviViewController *install = [[BaseNaviViewController alloc]initWithRootViewController:[BussinessViewController new]];
    [install.tabBarItem setImage:[[UIImage imageNamed:@"商业服务未选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [install.tabBarItem setSelectedImage:[[UIImage imageNamed:@"商业服务选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    install.tabBarItem.title = @"商业服务";
    //购物车
    BaseNaviViewController *buyCar = [[BaseNaviViewController alloc]initWithRootViewController:[MineViewController new]];
    buyCar.tabBarItem.title = @"个人中心";
    [buyCar.tabBarItem setImage:[[UIImage imageNamed:@"个人中心未选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [buyCar.tabBarItem setSelectedImage:[[UIImage imageNamed:@"个人中心选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //我的
    
    self.viewControllers = @[homeNav,community,install,buyCar];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
