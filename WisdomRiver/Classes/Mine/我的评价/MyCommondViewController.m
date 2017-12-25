//
//  MyCommondViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/25.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "MyCommondViewController.h"
#import "MyCommondTableViewCell.h"
@interface MyCommondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allCommond;
@property (nonatomic, assign) NSInteger page;
@end


@implementation MyCommondViewController
- (NSMutableArray *)allCommond {
    if (!_allCommond) {
        _allCommond = [NSMutableArray array];
    }
    return _allCommond;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTab];
    self.navigationItem.title = @"我的评价";
    
    [self headerRefresh];
}
- (void)setUpTab {
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCommondTableViewCell" bundle:nil] forCellReuseIdentifier:@"baseCell"];
    self.tableView.backgroundColor = LRRGBColor(245, 245, 245);
}
- (void)headerRefresh {
    self.page = 1;
    [self loadData];
}
- (void)footerFresh {
    self.page ++;
    [self loadData];
}
- (void)loadData {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"currPage"] = @(self.page);
    param[@"pageSize"] = @10;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appPersonalCenter/personalEvaluate" params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        if (self.page == 1) {
            self.allCommond = [showdata[@"list"] mutableCopy];
        } else {
            [self.allCommond addObjectsFromArray:showdata[@"list"]];
        }
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self.tableView tableViewDisplayWitMsg:@"暂无评论" ifNecessaryForRowCount:self.allCommond.count];
    return self.allCommond.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCommondTableViewCell *commond = [tableView dequeueReusableCellWithIdentifier:@"baseCell"];
    commond.selectionStyle = UITableViewCellSelectionStyleNone;
    [commond setCommondWithData:self.allCommond[indexPath.row]];
    return commond;
}

@end
