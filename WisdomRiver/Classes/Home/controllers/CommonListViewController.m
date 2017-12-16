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
@interface CommonListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) UIImageView *noDataImage;
@end

@implementation CommonListViewController

- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray arrayWithObject:@{@"title":@"123213",@"content":@"sadsdadsasdasdasdasdascaacxacscascadqwdqwqdscascZcxcacasdqwdqcscacacadakdhiahdabdkbkdbakbdahdiwhdbajkdbkahdhdlabdlkandkabdjkaskdalhsjadskjdalhd"}];
    }
    return _data;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self popOut];
    [self setUp];
    [self requestData];
    // Do any additional setup after loading the view.
}

- (void)requestData{
    if (!self.data.count) {
        self.noDataImage.hidden = NO;
    }
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
    self.navigationItem.titleView = searchField;
}

- (void)searchOnReturn:(UITextField *)sender{
    
}

- (void)typeItem{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonListCell *cell = (CommonListCell *)[tableView dequeueReusableCellWithIdentifier:@"CommonListCell" forIndexPath:indexPath];
    cell.title.text = self.data[indexPath.row][@"title"];
    cell.content.text = self.data[indexPath.row][@"content"];
    cell.iconImage.image = [UIImage imageNamed:@"icon111"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ItemDetailsViewController *itemVC = [ItemDetailsViewController new];
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
