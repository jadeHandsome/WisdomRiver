//
//  HomeViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/14.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "HomeViewController.h"
#import "NewPagedFlowView.h"
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    // Do any additional setup after loading the view.
}

- (void)setUp{
    self.view.backgroundColor = COLOR(245, 245, 245, 1);
    UIImageView *topImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT(566) - 64 + navHight);
    }];
    
    
    
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//
//    UICollectionView *collectionView = [[UICollectionView alloc] init];
//    [collectionView setCollectionViewLayout:layout];
//    collectionView.backgroundColor = [UIColor whiteColor];
//    collectionView.delegate = self;
//    collectionView.dataSource = self;
//    [self.view addSubview:collectionView];
//    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.top.equalTo(topImage.mas_bottom).offset(HEIGHT(20));
//    }];
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
