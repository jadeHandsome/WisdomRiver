//
//  MineViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/14.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "MineViewController.h"
#import "BaseMineView.h"
#import "InfoManagerViewController.h"
#import "ReparePwsViewController.h"
#import "MySuqiuViewController.h"
#import "MyApplyViewController.h"
#import "MyCommondViewController.h"
@interface MineViewController ()
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIScrollView *mainScoll;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ThemeColor;
    [self setUpMainScoll];
    
}
- (void)setUpMainScoll {
    self.mainScoll = [[UIScrollView alloc]init];
    [self.view addSubview:self.mainScoll];
    [self.mainScoll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIView * container = [UIView new];
    
    [self.mainScoll addSubview:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.mainScoll);
        
        make.width.equalTo(self.mainScoll);
        
    }];
    self.headView = [[UIView alloc]init];
    [container addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(container);
        make.height.equalTo(@(HEIGHT(537)));
        
    }];
    UIImageView *headImage = [[UIImageView alloc]init];
    [self.headView addSubview:headImage];
    if ([KRUserInfo sharedKRUserInfo].micon) {
        [headImage sd_setImageWithURL:[NSString stringWithFormat:@"http://182.151.204.201:8081/gfile/show?id=%@",[KRUserInfo sharedKRUserInfo].micon] placeholderImage:_zhanweiImageData];
    } else {
        [headImage sd_setImageWithURL:@"http://182.151.204.201:8081/static/wjzhfwpt/img/headSculpture.png" placeholderImage:_zhanweiImageData];
    }
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.headView);
        make.height.width.equalTo(@(HEIGHT(240)));
    }];
    LRViewBorderRadius(headImage, HEIGHT(240) * 0.5, 0, [UIColor clearColor]);
    UILabel *nameLabel = [[UILabel alloc]init];
    [self.headView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headImage.mas_centerX);
        make.top.equalTo(headImage.mas_bottom).with.offset(HEIGHT(46));
    }];
    nameLabel.text = [KRUserInfo sharedKRUserInfo].name;
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor whiteColor];
    self.headView.backgroundColor = [UIColor clearColor];
    UIView *topView = [[UIView alloc]init];
    [container addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container.mas_left).with.offset(15);
        make.right.equalTo(container.mas_right).with.offset(-15);
        make.top.equalTo(self.headView.mas_bottom);
        make.height.equalTo(@(HEIGHT(148) * 6));
    }];
    LRViewBorderRadius(topView, 5, 0, [UIColor clearColor]);
    UIView *tempView = topView;
    NSArray *topArray = @[@{@"image":@"1",@"name":@"我的预审"},@{@"image":@"2",@"name":@"我的待办"},@{@"image":@"3",@"name":@"我的评价"},@{@"image":@"4",@"name":@"我的预约"},@{@"image":@"5",@"name":@"我的报名"},@{@"image":@"6",@"name":@"我的述求"}];
    for (int i = 0; i < 6; i ++) {
        BaseMineView *baseView = [[[NSBundle mainBundle]loadNibNamed:@"BaseMineView" owner:self options:nil]firstObject];
        [topView addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.top.equalTo(topView.mas_top);
            } else {
                make.top.equalTo(tempView.mas_bottom);
            }
            make.left.right.equalTo(topView);
            make.height.equalTo(@(HEIGHT(148)));
        }];
        [baseView setDataWithDic:topArray[i]];
        tempView = baseView;
        baseView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [baseView addGestureRecognizer:tap];
    }
    UIView *bottomView = [[UIView alloc]init];
    [container addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container.mas_left).with.offset(15);
        make.right.equalTo(container.mas_right).with.offset(-15);
        make.top.equalTo(topView.mas_bottom).with.offset(10);
        make.height.equalTo(@(HEIGHT(148) * 2));
        make.bottom.equalTo(container.mas_bottom).with.offset(-30);
    }];
    LRViewBorderRadius(bottomView, 5, 0, [UIColor clearColor]);
    tempView = bottomView;
    NSArray *bottomArray = @[@{@"image":@"7",@"name":@"修改密码"},@{@"image":@"8",@"name":@"账号管理"}];
    for (int i = 0; i < 2; i ++) {
        BaseMineView *baseView = [[[NSBundle mainBundle]loadNibNamed:@"BaseMineView" owner:self options:nil]firstObject];
        [bottomView addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.top.equalTo(bottomView.mas_top);
            } else {
                make.top.equalTo(tempView.mas_bottom);
            }
            make.left.right.equalTo(bottomView);
            make.height.equalTo(@(HEIGHT(148)));
        }];
        [baseView setDataWithDic:bottomArray[i]];
        tempView = baseView;
        baseView.tag = i + 6;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [baseView addGestureRecognizer:tap];
    }
    
    
}
- (void)click:(UITapGestureRecognizer *)tap {
    switch (tap.view.tag) {
        case 0:
        {
            //预审
            MySuqiuViewController *suqiu = [MySuqiuViewController new];
            suqiu.hidesBottomBarWhenPushed = YES;
            suqiu.viewType = @"2";
            [self.navigationController pushViewController:suqiu animated:YES];
        }
            break;
        case 1:
        {
            //待办
            MySuqiuViewController *suqiu = [MySuqiuViewController new];
            suqiu.hidesBottomBarWhenPushed = YES;
            suqiu.viewType = @"3";
            [self.navigationController pushViewController:suqiu animated:YES];
        }
            break;
        case 2:
        {
            
            //评价
            MyCommondViewController *vc = [MyCommondViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            
            //预约
            MyApplyViewController *apple = [[MyApplyViewController alloc]init];
            apple.hidesBottomBarWhenPushed = YES;
            apple.viewType = @"2";
            [self.navigationController pushViewController:apple animated:YES];
        }
            break;
        case 4:
        {
            //报名
            MyApplyViewController *apple = [[MyApplyViewController alloc]init];
            apple.hidesBottomBarWhenPushed = YES;
            apple.viewType = @"1";
            [self.navigationController pushViewController:apple animated:YES];
        }
            break;
        case 5:
        {
            //述求
            MySuqiuViewController *suqiu = [MySuqiuViewController new];
            suqiu.hidesBottomBarWhenPushed = YES;
            suqiu.viewType = @"1";
            [self.navigationController pushViewController:suqiu animated:YES];
            
        }
            break;
        case 6:
        {
            //修改密码
            ReparePwsViewController *repare = [ReparePwsViewController new];
            repare.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:repare animated:YES];
        }
            break;
        case 7:
        {
            //账号管理
            InfoManagerViewController *info = [[InfoManagerViewController alloc]init];
            info.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:info animated:YES];
        }
            break;
            
        default:
            break;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
