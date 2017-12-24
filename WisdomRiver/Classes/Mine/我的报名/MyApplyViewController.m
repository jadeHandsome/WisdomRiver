//
//  MyApplyViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "MyApplyViewController.h"
#import "MyAppleDetailViewController.h"
#import "MyApplyTableViewCell.h"
@interface MyApplyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allList;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger type;
@end

@implementation MyApplyViewController
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
    self.type = -1;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_type"] style:UIBarButtonItemStyleDone target:self action:@selector(statusClick)];
    self.navigationItem.title = @"我的报名";
    if ([self.viewType isEqualToString:@"1"]) {
        self.navigationItem.title = @"我的报名";
    } else {
        self.navigationItem.title = @"我的预约";
    }
}
- (void)statusClick {
    __weak typeof(self) weakSelf = self;
    [KRBaseTool showAlert:@"状态审核" with_Controller:self with_titleArr:@[@"全部",@"未审核",@"商家通过",@"商家驳回",@"审核通过",@"审核驳回",@"名额已满"] withShowType:UIAlertControllerStyleActionSheet with_Block:^(int index) {
        weakSelf.type = index - 1;
        [weakSelf headFresh];
    }];
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
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"currPage"] = @(self.page);
    param[@"pageSize"] = @10;
    if (self.type != -1) {
        param[@"auditstatus"] = @(self.type);
    }
    NSString *path = nil;
    if ([self.viewType isEqualToString:@"1"]) {
        path = @"appPersonalCenter/personApply";
    } else {
        path = @"appPersonalCenter/personOrder";
    }
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:path params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
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
    
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [KRBaseTool tableViewAddRefreshFooter:self.tableView withTarget:self refreshingAction:@selector(footFresh)];
    [KRBaseTool tableViewAddRefreshHeader:self.tableView withTarget:self refreshingAction:@selector(headFresh)];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyApplyTableViewCell" bundle:nil] forCellReuseIdentifier:@"baseCell"];
//    [self.view bringSubviewToFront:addBtn];
    self.tableView.tableFooterView = [UIView new];
    
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self.tableView tableViewDisplayWitMsg:@"暂无数据" ifNecessaryForRowCount:self.allList.count];
    return self.allList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell"];
    [cell setDataWithDic:self.allList[indexPath.row]];
//    [cell setdataWith:self.allList[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.allList[indexPath.row];
    MyAppleDetailViewController *detail = [MyAppleDetailViewController new];
    detail.appleId = dic[@"soid"];
    [self.navigationController pushViewController:detail animated:YES];
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
