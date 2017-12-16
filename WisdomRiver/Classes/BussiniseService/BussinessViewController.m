//
//  BussinessViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/14.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "BussinessViewController.h"
#import "BussinessTableViewCell.h"
#import "BussinessSubViewController.h"
@interface BussinessViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *allItem;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BussinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LRRGBColor(245, 245, 245);
    [self loadData];
   
}
- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appBusiness/getProgramManagement" params:nil withModel:nil complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        NSLog(@"%@",showdata);
        
        self.allItem = [showdata[@"pms"] copy];
        [self setUp];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}
- (void)setUp {
    UIImageView *topImage = [[UIImageView alloc]init];
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(HEIGHT(483)));
    }];
    topImage.clipsToBounds = YES;
    topImage.contentMode = UIViewContentModeScaleAspectFill;
    topImage.image = [UIImage imageNamed:@"商业背景"];
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(topImage.mas_bottom).with.offset(-HEIGHT(50));
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[BussinessTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
#pragma -- mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allItem.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BussinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setUpWithDic:self.allItem[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) weakSelf = self;
    cell.block = ^(NSDictionary *dic) {
        BussinessSubViewController *sub = [BussinessSubViewController new];
        sub.moduleId = dic[@"id"];
        sub.hidesBottomBarWhenPushed = YES;
        sub.titleStr = dic[@"name"];
        [weakSelf.navigationController pushViewController:sub animated:YES];
    };
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HEIGHT(300);
}
@end
