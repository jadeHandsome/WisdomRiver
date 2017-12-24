//
//  MySuqiuViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "MySuqiuViewController.h"
#import "MysuiquListTableViewCell.h"
#import "AddCommitController.h"
#import "SuqiuDetailViewController.h"
#import "YushenDetailViewController.h"

@interface MySuqiuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allList;
@property (nonatomic, assign) NSInteger page;
@end

@implementation MySuqiuViewController
- (NSMutableArray *)allList {
    if (!_allList) {
        _allList = [NSMutableArray array];
    }
    return _allList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self headFresh];
    [self setUp];
    if ([self.viewType isEqualToString:@"1"]) {
        self.navigationItem.title = @"我的诉求";
    } else {
        self.navigationItem.title = @"我的预审";
    }
    
    
}
- (void)headFresh {
    self.page = 1;
    [self loadData];
}
- (void)footFresh {
    self.page ++;
    [self loadData];
}
- (void)loadData {
    NSString *path = nil;
    if ([self.viewType isEqualToString:@"1"]) {
        path = @"appPersonalCenter/personalAppealManagement";
    } else if ([self.viewType isEqualToString:@"2"]) {
        path = @"appPersonalCenter/personalYSGovernmentService";
    } else {
        path = @"appPersonalCenter/personalDBGovernmentService";
    }
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:path params:@{@"currPage":@(self.page),@"pageSize":@10} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (showdata == nil) {
            return ;
        }
        if (self.page == 1) {
            self.allList = [showdata[@"list"] mutableCopy];
        } else {
            [self.allList addObjectsFromArray:showdata[@"list"]];
        }
        [self.tableView reloadData];
    }];
}

- (void)setUp {
    
    UIButton *addBtn = [[UIButton alloc]init];
    [self.view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-40);
        make.right.equalTo(self.view).with.offset(-15);
    }];
    [addBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [KRBaseTool tableViewAddRefreshFooter:self.tableView withTarget:self refreshingAction:@selector(footFresh)];
    [KRBaseTool tableViewAddRefreshHeader:self.tableView withTarget:self refreshingAction:@selector(headFresh)];
    [self.tableView registerNib:[UINib nibWithNibName:@"MysuiquListTableViewCell" bundle:nil] forCellReuseIdentifier:@"baseCell"];
    [self.view bringSubviewToFront:addBtn];
    self.tableView.tableFooterView = [UIView new];
    
    [addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    LRViewShadow(addBtn, [UIColor blackColor], CGSizeMake(0, 0), 0.5, [UIImage imageNamed:@"添加"].size.height * 0.5);
    if (![self.viewType isEqualToString:@"1"]) {
        addBtn.hidden = YES;
    }
}
- (void)addClick {
    AddCommitController *commit = [AddCommitController new];
    [self.navigationController pushViewController:commit animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self.tableView tableViewDisplayWitMsg:@"暂无数据" ifNecessaryForRowCount:self.allList.count];
    return self.allList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MysuiquListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell"];
    cell.cellType = self.viewType;
    [cell setdataWith:self.allList[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.viewType isEqualToString:@"1"]) {
        NSDictionary *dic = self.allList[indexPath.row];
        SuqiuDetailViewController *detail = [SuqiuDetailViewController new];
        detail.suqiuId = dic[@"id"];
        [self.navigationController pushViewController:detail animated:YES];
    } else {
        NSDictionary *dic = self.allList[indexPath.row];
        YushenDetailViewController *detail = [YushenDetailViewController new];
        detail.ID = dic[@"id"];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
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
