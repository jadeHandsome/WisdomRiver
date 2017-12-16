//
//  ItemDetailsViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/15.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "ItemDetailsViewController.h"

@interface ItemDetailsViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ItemDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self popOut];
    [self setUp];
    // Do any additional setup after loading the view.
}

- (void)setUp{
    self.navigationItem.title = @"事项详情";
    self.view.backgroundColor = COLOR(245, 245, 245, 1);
    UIView *buttonsView = [[UIView alloc] init];
    buttonsView.backgroundColor = COLOR(245, 245, 245, 1);
    [self.view addSubview:buttonsView];
    [buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT(152));
    }];
    UIButton *button1 = [[UIButton alloc] init];
    [button1 setTitle:@"基本信息" forState:UIControlStateNormal];
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
        make.width.mas_equalTo(SIZEWIDTH / 4);
    }];
    UIButton *button2 = [[UIButton alloc] init];
    [button2 setTitle:@"前置条件" forState:UIControlStateNormal];
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
        make.width.mas_equalTo(SIZEWIDTH / 4);
    }];
    UIButton *button3 = [[UIButton alloc] init];
    [button3 setTitle:@"办理流程" forState:UIControlStateNormal];
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
        make.width.mas_equalTo(SIZEWIDTH / 4);
    }];
    UIButton *button4 = [[UIButton alloc] init];
    [button4 setTitle:@"前置条件" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button4 setTitleColor:COLOR(78, 78, 78, 1) forState:UIControlStateNormal];
    button4.titleLabel.font = [UIFont systemFontOfSize:HEIGHT(44)];
    [button4 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    self.button4 = button4;
    button4.tag = 4;
    [buttonsView addSubview:button4];
    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(buttonsView);
        make.left.equalTo(button3.mas_right);
        make.width.mas_equalTo(SIZEWIDTH / 4);
    }];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT(147), SIZEWIDTH / 4, HEIGHT(5))];
    lineView.backgroundColor = ThemeColor;
    self.lineView = lineView;
    [buttonsView addSubview:lineView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HEIGHT(152), SIZEWIDTH, SIZEHEIGHT - navHight - HEIGHT(302))];
#ifdef __IPHONE_11_0
    if ([scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    scrollView.contentSize = CGSizeMake(SIZEWIDTH * 4, SIZEHEIGHT - navHight - HEIGHT(302));
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.backgroundColor = COLOR(245, 245, 245, 1);
    scrollView.delegate = self;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    UIView *bottomView =[[UIView alloc] init];
    bottomView.backgroundColor = COLOR(245, 245, 245, 1);
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT(150));
    }];
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn setTitle:@"预审" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setBackgroundColor:COLOR(4, 153, 204, 1)];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT(40)];
    [leftBtn addTarget:self action:@selector(preliminary:) forControlEvents:UIControlEventTouchUpInside];
    LRViewBorderRadius(leftBtn, HEIGHT(10), 0, COLOR(4, 153, 204, 1));
    [bottomView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo((SIZEWIDTH - WIDTH(90))/2);
        make.height.mas_equalTo(HEIGHT(120));
        make.left.equalTo(bottomView).offset(WIDTH(30));
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"代办" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setBackgroundColor:COLOR(105, 148, 225, 1)];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT(40)];
    [rightBtn addTarget:self action:@selector(commission:) forControlEvents:UIControlEventTouchUpInside];
    LRViewBorderRadius(rightBtn, HEIGHT(10), 0, COLOR(105, 148, 225, 1));
    [bottomView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo((SIZEWIDTH - WIDTH(90))/2);
        make.height.mas_equalTo(HEIGHT(120));
        make.right.equalTo(bottomView).offset(WIDTH(-30));
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.lineView.frame = CGRectMake(scrollView.contentOffset.x / 4, HEIGHT(147), SIZEWIDTH / 4, HEIGHT(5));
    NSInteger index = scrollView.contentOffset.x / SIZEWIDTH + 1;
    self.preBtn.selected = NO;
    self.preBtn = [self.view viewWithTag:index];
    self.preBtn.selected = YES;
}


- (void)change:(UIButton *)sender{
    self.preBtn.selected = NO;
    self.preBtn = sender;
    self.preBtn.selected = YES;
    [self.scrollView setContentOffset:CGPointMake(SIZEWIDTH *(sender.tag - 1), 0) animated:YES];
}
//预审
- (void)preliminary:(UIButton *)sender{
    
}
//代办
- (void)commission:(UIButton *)sender{
    
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
