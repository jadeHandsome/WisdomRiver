//
//  CommonListViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/15.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "CommonListViewController.h"
#import "CommonListCell.h"
#import "ItemDetailsViewController.h"
#import "SelectionView.h"
@interface CommonListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) UIImageView *noDataImage;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation CommonListViewController

- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self popOut];
    [self setUp];
    self.currPage = 1;
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

//重新获取
- (void)refreshData{
    [self requestData:YES];
}

//获取更多
- (void)getMoreData{
    [self requestData:NO];
}

- (void)requestData:(BOOL)isRefresh{
    NSString *url = nil;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageSize"] = @(20);
    params[@"currPage"] = isRefresh ? @(1) : @(self.currPage + 1);
    params[@"name"] = self.textField.text;
    if ([self.naviTitle isEqualToString:@"网上预审"]) {
        url = @"appGovernmentFront/getSubscribeGovernmentService";
        if (self.currentIndex == 0) {
            params[@"userid"] = [KRUserInfo sharedKRUserInfo].userid;
        }
        else{
            params[@"userid"] = @"";
        }
    }
    else if ([self.naviTitle isEqualToString:@"全程代办"]) {
        url = @"appGovernmentFront/getCommissionGovernmentService";
        if (self.currentIndex == 0) {
            params[@"userid"] = [KRUserInfo sharedKRUserInfo].userid;
        }
        else{
            params[@"userid"] = @"";
        }
    }
    else{
        if (self.isTheme) {
            url = @"appGovernmentFront/getGovernmentServiceByType";
            params[@"type"] = self.itemId;
        }
        else{
            url = @"appGovernmentFront/getGovernmentServiceByOrg";
            params[@"orgid"] = self.itemId;
        }
    }
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:url params:params withModel:nil complateHandle:^(id showdata, NSString *error) {
        if (showdata) {
            if (isRefresh) {
                self.currPage = 1;
                self.data = [showdata[@"list"] mutableCopy];
                [self.tableView.mj_header endRefreshing];
            }
            else{
                self.currPage ++;
                [self.data addObjectsFromArray:showdata[@"list"]];
                [self.tableView.mj_footer endRefreshing];
            }
            if ([showdata[@"lastPage"] integerValue] == 1) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                self.tableView.mj_footer.state = MJRefreshStateIdle;
            }
            [self.tableView reloadData];
        }
        if (!showdata || self.data.count == 0) {
            self.noDataImage.hidden = NO;
        }
        else{
            self.noDataImage.hidden = YES;
        }
    }];
}



- (void)setUp{
    self.navigationItem.title = self.naviTitle;
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_search_white"] style:UIBarButtonItemStylePlain target:self action:@selector(searchItem)];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_type"] style:UIBarButtonItemStylePlain target:self action:@selector(typeItem)];
    self.navigationItem.rightBarButtonItems = self.haveType ? @[rightItem2,rightItem1] : @[rightItem1];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SIZEWIDTH, SIZEHEIGHT - navHight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = HEIGHT(300);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
#ifdef __IPHONE_11_0
    if ([tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    [tableView registerClass:[CommonListCell class] forCellReuseIdentifier:@"CommonListCell"];
    [KRBaseTool tableViewAddRefreshHeader:tableView withTarget:self refreshingAction:@selector(refreshData)];
    [KRBaseTool tableViewAddRefreshFooter:tableView withTarget:self refreshingAction:@selector(getMoreData)];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    UIImageView *noDataImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty"]];
    noDataImage.contentMode = UIViewContentModeScaleAspectFit;
    noDataImage.hidden = YES;
    self.noDataImage = noDataImage;
    [self.view addSubview:noDataImage];
    [noDataImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.height.width.mas_equalTo(128);
    }];
    
}

- (void)searchItem{
    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SIZEWIDTH / 2, 44)];
    searchField.placeholder = @"输入标题查询";
    searchField.textColor = [UIColor whiteColor];
    searchField.returnKeyType = UIReturnKeySearch;
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField addTarget:self action:@selector(searchOnReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [searchField becomeFirstResponder];
    self.textField = searchField;
    self.navigationItem.titleView = searchField;
}

- (void)searchOnReturn:(UITextField *)sender{
    [self.tableView.mj_header beginRefreshing];
}

- (void)typeItem{
    [self.textField resignFirstResponder];
    SelectionView *selectionView = [[SelectionView alloc] initWithDataArr:@[@"全部社区",@"本社区"] title:@"事项开放社区" currentIndex:self.currentIndex seleted:^(NSInteger index, NSString *selectStr) {
        self.currentIndex = index;
        [self.tableView.mj_header beginRefreshing];
    }];
    [self.view.window addSubview:selectionView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonListCell *cell = (CommonListCell *)[tableView dequeueReusableCellWithIdentifier:@"CommonListCell" forIndexPath:indexPath];
    cell.title.text = self.data[indexPath.row][@"name"];
    cell.content.text = self.data[indexPath.row][@"preconditionContent"];
    cell.iconImage.image = [UIImage imageNamed:@"icon111"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ItemDetailsViewController *itemVC = [ItemDetailsViewController new];
    itemVC.dic = self.data[indexPath.row];
    [self.navigationController pushViewController:itemVC animated:YES];
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
