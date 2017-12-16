//
//  HotNewsViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/15.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "HotNewsViewController.h"
#import "CommonListCell.h"
#import "HotNewsDetailViewController.h"
@interface HotNewsViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *policyTableView;
@property (nonatomic, strong) UITableView *notificationTableView;
@property (nonatomic, strong) UITableView *informationTableView;
@property (nonatomic, strong) NSMutableArray *policyArr;
@property (nonatomic, strong) NSMutableArray *notificationArr;
@property (nonatomic, strong) NSMutableArray *informationArr;

@end

@implementation HotNewsViewController
- (NSMutableArray *)policyArr{
    if (!_policyArr) {
        _policyArr = [NSMutableArray arrayWithObject:@{@"title":@"123213",@"content":@"sadsdadsasdasdasdasdascaacxacscascadqwdqwqdscascZcxcacasdqwdqcscacacadakdhiahdabdkbkdbakbdahdiwhdbajkdbkahdhdlabdlkandkabdjkaskdalhsjadskjdalhd"}];
    }
    return _policyArr;
}

- (NSMutableArray *)notificationArr{
    if (!_notificationArr) {
        _notificationArr = [NSMutableArray arrayWithObjects:@{@"title":@"123213",@"content":@"sadsdadsasdasdasdasdascaacxacscascadqwdqwqdscascZcxcacasdqwdqcscacacadakdhiahdabdkbkdbakbdahdiwhdbajkdbkahdhdlabdlkandkabdjkaskdalhsjadskjdalhd"},@{@"title":@"123213",@"content":@"sadsdadsasdasdasdasdascaacxacscascadqwdqwqdscascZcxcacasdqwdqcscacacadakdhiahdabdkbkdbakbdahdiwhdbajkdbkahdhdlabdlkandkabdjkaskdalhsjadskjdalhd"}, nil];
    }
    return _notificationArr;
}

- (NSMutableArray *)informationArr{
    if (!_informationArr) {
        _informationArr = [NSMutableArray arrayWithObjects:@{@"title":@"123213",@"content":@"sadsdadsasdasdasdasdascaacxacscascadqwdqwqdscascZcxcacasdqwdqcscacacadakdhiahdabdkbkdbakbdahdiwhdbajkdbkahdhdlabdlkandkabdjkaskdalhsjadskjdalhd"},@{@"title":@"123213",@"content":@"sadsdadsasdasdasdasdascaacxacscascadqwdqwqdscascZcxcacasdqwdqcscacacadakdhiahdabdkbkdbakbdahdiwhdbajkdbkahdhdlabdlkandkabdjkaskdalhsjadskjdalhd"},@{@"title":@"123213",@"content":@"sadsdadsasdasdasdasdascaacxacscascadqwdqwqdscascZcxcacasdqwdqcscacacadakdhiahdabdkbkdbakbdahdiwhdbajkdbkahdhdlabdlkandkabdjkaskdalhsjadskjdalhd"},@{@"title":@"123213",@"content":@"sadsdadsasdasdasdasdascaacxacscascadqwdqwqdscascZcxcacasdqwdqcscacacadakdhiahdabdkbkdbakbdahdiwhdbajkdbkahdhdlabdlkandkabdjkaskdalhsjadskjdalhd"}, nil];
    }
    return _informationArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self popOut];
    [self setUp];
    [self request];
    // Do any additional setup after loading the view.
}

- (void)request{
    
}

- (void)setUp{
    self.navigationItem.title = @"热点资讯";
    UIView *buttonsView = [[UIView alloc] init];
    buttonsView.backgroundColor = COLOR(245, 245, 245, 1);
    [self.view addSubview:buttonsView];
    [buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT(152));
    }];
    UIButton *button1 = [[UIButton alloc] init];
    [button1 setTitle:@"政策解读" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button1 setTitleColor:COLOR(78, 78, 78, 1) forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:HEIGHT(44)];
    [button1 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    button1.selected = YES;
    button1.tag = 1;
    self.button1 = button1;
    self.preBtn = button1;
    [buttonsView addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(buttonsView);
        make.width.mas_equalTo(SIZEWIDTH / 3);
    }];
    UIButton *button2 = [[UIButton alloc] init];
    [button2 setTitle:@"通知公告" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button2 setTitleColor:COLOR(78, 78, 78, 1) forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:HEIGHT(44)];
    [button2 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 2;
    self.button2 = button2;
    [buttonsView addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(buttonsView);
        make.left.equalTo(button1.mas_right);
        make.width.mas_equalTo(SIZEWIDTH / 3);
    }];
    UIButton *button3 = [[UIButton alloc] init];
    [button3 setTitle:@"便民信息" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button3 setTitleColor:COLOR(78, 78, 78, 1) forState:UIControlStateNormal];
    button3.titleLabel.font = [UIFont systemFontOfSize:HEIGHT(44)];
    [button3 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = 3;
    self.button3 = button3;
    [buttonsView addSubview:button3];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(buttonsView);
        make.left.equalTo(button2.mas_right);
        make.width.mas_equalTo(SIZEWIDTH / 3);
    }];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT(147), SIZEWIDTH / 3, HEIGHT(5))];
    lineView.backgroundColor = ThemeColor;
    self.lineView = lineView;
    [buttonsView addSubview:lineView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HEIGHT(152), SIZEWIDTH, SIZEHEIGHT - navHight - HEIGHT(152))];
#ifdef __IPHONE_11_0
    if ([scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    scrollView.contentSize = CGSizeMake(SIZEWIDTH * 3, SIZEHEIGHT - navHight - HEIGHT(152));
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.backgroundColor = COLOR(245, 245, 245, 1);
    scrollView.delegate = self;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];

    _policyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SIZEWIDTH, SIZEHEIGHT - navHight - HEIGHT(152))];
    _policyTableView.delegate = self;
    _policyTableView.dataSource = self;
    _policyTableView.rowHeight = HEIGHT(300);
    _policyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
#ifdef __IPHONE_11_0
    if ([_policyTableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        _policyTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    [_policyTableView registerClass:[CommonListCell class] forCellReuseIdentifier:@"CommonListCell"];
    [scrollView addSubview:_policyTableView];
    
    _notificationTableView = [[UITableView alloc] initWithFrame:CGRectMake(SIZEWIDTH, 0, SIZEWIDTH, SIZEHEIGHT - navHight - HEIGHT(152))];
    _notificationTableView.delegate = self;
    _notificationTableView.dataSource = self;
    _notificationTableView.rowHeight = HEIGHT(300);
    _notificationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
#ifdef __IPHONE_11_0
    if ([_notificationTableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        _notificationTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    [_notificationTableView registerClass:[CommonListCell class] forCellReuseIdentifier:@"CommonListCell"];
    [scrollView addSubview:_notificationTableView];
    
    _informationTableView = [[UITableView alloc] initWithFrame:CGRectMake(SIZEWIDTH*2, 0, SIZEWIDTH, SIZEHEIGHT - navHight - HEIGHT(152))];
    _informationTableView.delegate = self;
    _informationTableView.dataSource = self;
    _informationTableView.rowHeight = HEIGHT(300);
    _informationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
#ifdef __IPHONE_11_0
    if ([_informationTableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        _informationTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    [_informationTableView registerClass:[CommonListCell class] forCellReuseIdentifier:@"CommonListCell"];
    [scrollView addSubview:_informationTableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.lineView.frame = CGRectMake(scrollView.contentOffset.x / 3, HEIGHT(147), SIZEWIDTH / 3, HEIGHT(5));
    NSInteger index = scrollView.contentOffset.x / SIZEWIDTH + 1;
    self.preBtn.selected = NO;
    self.preBtn = [self.view viewWithTag:index];
    self.preBtn.selected = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _policyTableView) {
        return self.policyArr.count;
    }
    else if (tableView == _notificationTableView){
        return self.notificationArr.count;
    }
    else{
        return self.informationArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonListCell" forIndexPath:indexPath];
    NSDictionary *dic;
    if (tableView == _policyTableView) {
        dic = self.policyArr[indexPath.row];
    }
    else if (tableView == _notificationTableView){
        dic = self.notificationArr[indexPath.row];
    }
    else{
        dic = self.informationArr[indexPath.row];
    }
    cell.title.text = dic[@"title"];
    cell.content.text = dic[@"content"];
    cell.iconImage.image = [UIImage imageNamed:@"zcjd_icon"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HotNewsDetailViewController *detailVC = [HotNewsDetailViewController new];
    if (tableView == _policyTableView) {
        detailVC.naviTitle = @"政策解读";
        detailVC.dic = self.policyArr[indexPath.row];
    }
    else if (tableView == _notificationTableView){
        detailVC.naviTitle = @"通知公告";
        detailVC.dic = self.notificationArr[indexPath.row];
    }
    else{
        detailVC.naviTitle = @"便民信息";
        detailVC.dic = self.informationArr[indexPath.row];
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)change:(UIButton *)sender{
    self.preBtn.selected = NO;
    self.preBtn = sender;
    self.preBtn.selected = YES;
    [self.scrollView setContentOffset:CGPointMake(SIZEWIDTH *(sender.tag - 1), 0) animated:YES];
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
