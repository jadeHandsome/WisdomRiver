//
//  AppealViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/15.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "AppealViewController.h"
#import "AppealCell.h"
#import "SelectionView.h"
#import "AddCommitController.h"
@interface AppealViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) UIImageView *noDataImage;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation AppealViewController
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


- (void)setUp{
    self.navigationItem.title = @"诉求互动";
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_search_white"] style:UIBarButtonItemStylePlain target:self action:@selector(searchItem)];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_type"] style:UIBarButtonItemStylePlain target:self action:@selector(typeItem)];
    self.navigationItem.rightBarButtonItems = @[rightItem2,rightItem1];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SIZEWIDTH, SIZEHEIGHT - navHight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 105;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
#ifdef __IPHONE_11_0
    if ([tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    [tableView registerNib:[UINib nibWithNibName:@"AppealCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AppealCell"];
    [KRBaseTool tableViewAddRefreshHeader:tableView withTarget:self refreshingAction:@selector(refreshData)];
    [KRBaseTool tableViewAddRefreshFooter:tableView withTarget:self refreshingAction:@selector(getMoreData)];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton setBackgroundColor:ThemeColor];
    addButton.titleLabel.font = [UIFont systemFontOfSize:30];
    LRViewBorderRadius(addButton, 22.5, 0, ThemeColor);
    LRViewShadow(addButton, [UIColor blackColor], CGSizeMake(2, 2), 0.5, 5);
    [addButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view).offset(-25);
        make.width.height.mas_equalTo(45);
    }];
    
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

//重新获取
- (void)refreshData{
    [self requestData:YES];
}

//获取更多
- (void)getMoreData{
    [self requestData:NO];
}

- (void)requestData:(BOOL)isRefresh{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageSize"] = @(20);
    params[@"currPage"] = isRefresh ? @(1) : @(self.currPage + 1);
    params[@"title"] = self.textField.text;
    if (self.currentIndex == 0) {
        params[@"replyStatus"] = @"";
    }
    else if (self.currentIndex == 1){
        params[@"replyStatus"] = @"0";
    }
    else{
        params[@"replyStatus"] = @"1";
    }
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appGovernmentFront/getAppealManagement" params:params withModel:nil complateHandle:^(id showdata, NSString *error) {
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
    [self.view endEditing:YES];
    SelectionView *selectionView = [[SelectionView alloc] initWithDataArr:@[@"全部",@"未回复",@"已回复"] title:@"回复状态" currentIndex:self.currentIndex seleted:^(NSInteger index, NSString *selectStr) {
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
    AppealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppealCell" forIndexPath:indexPath];
    cell.title.text = self.data[indexPath.row][@"title"];
    cell.content.text = [NSString stringWithFormat:@"诉求内容：%@",self.data[indexPath.row][@"content"]];
    cell.time.text = [NSString stringWithFormat:@"提交时间：%@",self.data[indexPath.row][@"createdate"]];
    BOOL status = self.data[indexPath.row][@"reply"] != [NSNull null];
    cell.status.text =  status? @"已回复" : @"未回复";
    cell.status.textColor = status ? ThemeColor : ColorRgbValue(0xE2D423);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)add:(UIButton *)sender{
    AddCommitController *addVC = [AddCommitController new];
    [self.navigationController pushViewController:addVC animated:YES];
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
