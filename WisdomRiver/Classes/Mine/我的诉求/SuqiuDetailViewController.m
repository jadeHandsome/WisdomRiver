//
//  SuqiuDetailViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "SuqiuDetailViewController.h"

@interface SuqiuDetailViewController ()
@property (nonatomic, strong) UIScrollView *mainSco;
@property (nonatomic, strong) NSDictionary *myData;
@end

@implementation SuqiuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.navigationItem.title = @"诉求详情";
}
- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appPersonalCenter/appealManagementDetail" params:@{@"id":self.suqiuId} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        self.myData = [showdata[@"appealManagement"] copy];
        [self setUp];
    }];
}
- (void)setUp {
    self.mainSco = [UIScrollView new];
    [self.view addSubview:self.mainSco];
    [self.mainSco mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIView *contans = [[UIView alloc]init];
    [self.mainSco addSubview:contans];
    [contans mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainSco);
        make.width.equalTo(self.mainSco.mas_width);
    }];
    UIView *topView = [[UIView alloc]init];
    [contans addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contans.mas_left).with.offset(5);
        make.right.equalTo(contans.mas_right).with.offset(-5);
        make.top.equalTo(contans.mas_top).with.offset(5);
        make.height.equalTo(@240);
        if (!self.myData[@"reply"]) {
            make.bottom.equalTo(contans.mas_bottom).with.offset(-10);
        }
    }];
    UIView *temp = topView;
    NSArray *titleArray = @[@"诉求信息",@"诉求标题：",@"诉求类型：",@"处理状态：",@"诉求内容：",@"提交时间："];
    NSArray *rightArray = @[@"",self.myData[@"title"],self.myData[@"typeName"],@"已回复",self.myData[@"content"],self.myData[@"createdate"]];
    for (int i = 0; i < 6; i ++) {
        UIView *subView = [[UIView alloc]init];
        [topView addSubview:subView];
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.top.equalTo(temp.mas_top);
            } else {
                make.top.equalTo(temp.mas_bottom);
            }
            make.height.equalTo(@40);
            make.left.right.equalTo(topView);
            
        }];
        
        temp = subView;
        UILabel *leftLabel = [[UILabel alloc]init];
        [subView addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(subView.mas_left).with.offset(15);
            make.centerY.equalTo(subView.mas_centerY);
        }];
        leftLabel.font = [UIFont systemFontOfSize:14];
        if (i == 0) {
            leftLabel.textColor = ThemeColor;
        } else {
            leftLabel.textColor = LRRGBColor(136, 136, 136);
        }
        leftLabel.text = titleArray[i];
        UILabel *rightLabel = [[UILabel alloc]init];
        [subView addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftLabel.mas_right);
            make.centerY.equalTo(leftLabel.mas_centerY);
        }];
        if (i == 3) {
            rightLabel.textColor = ThemeColor;
        } else {
            rightLabel.textColor = [UIColor blackColor];
        }
        rightLabel.font = [UIFont systemFontOfSize:14];
        UIView *lineView = [[UIView alloc]init];
        [subView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(subView);
            make.height.equalTo(@1);
        }];
        lineView.backgroundColor = LRRGBColor(246, 246, 246);
        rightLabel.text = rightArray[i];
        
    }
    LRViewBorderRadius(topView, 5, 1, LRRGBColor(246, 246, 246));
    if (self.myData[@"reply"]) {
        UIView *bottomView = [[UIView alloc]init];
        [contans addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contans.mas_left).with.offset(5);
            make.right.equalTo(contans.mas_right).with.offset(-5);
            make.height.equalTo(@120);
            make.top.equalTo(topView.mas_bottom).with.offset(10);
            make.bottom.equalTo(contans.mas_bottom).with.offset(-10);
        }];
        UIView *temp1 = bottomView;
        NSArray *titleArray1 = @[@"回复信息",@"诉求回复：",@"回复时间："];
        NSArray *rightArray1 = @[@"",self.myData[@"reply"],self.myData[@"date"]];
        for (int i = 0; i < 3; i ++) {
            UIView *subView = [[UIView alloc]init];
            [bottomView addSubview:subView];
            [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (i == 0) {
                    make.top.equalTo(temp1.mas_top);
                } else {
                    make.top.equalTo(temp1.mas_bottom);
                }
                make.height.equalTo(@40);
                make.left.right.equalTo(topView);
                
            }];
            
            temp1 = subView;
            UILabel *leftLabel = [[UILabel alloc]init];
            [subView addSubview:leftLabel];
            [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(subView.mas_left).with.offset(15);
                make.centerY.equalTo(subView.mas_centerY);
            }];
            leftLabel.font = [UIFont systemFontOfSize:14];
            if (i == 0) {
                leftLabel.textColor = ThemeColor;
            } else {
                leftLabel.textColor = LRRGBColor(136, 136, 136);
            }
            leftLabel.text = titleArray1[i];
            UILabel *rightLabel = [[UILabel alloc]init];
            [subView addSubview:rightLabel];
            [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(leftLabel.mas_right);
                make.centerY.equalTo(leftLabel.mas_centerY);
            }];
            
            rightLabel.textColor = [UIColor blackColor];
            
            rightLabel.font = [UIFont systemFontOfSize:14];
            UIView *lineView = [[UIView alloc]init];
            [subView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(subView);
                make.height.equalTo(@1);
            }];
            lineView.backgroundColor = LRRGBColor(246, 246, 246);
            rightLabel.text = rightArray1[i];
            LRViewBorderRadius(bottomView, 5, 1, LRRGBColor(246, 246, 246));
            //topView.backgroundColor = [UIColor whiteColor];
            bottomView.backgroundColor = [UIColor whiteColor];
        }
//        LRViewBorderRadius(bottomView, 5, 1, LRRGBColor(246, 246, 246));
        bottomView.backgroundColor = [UIColor whiteColor];
//        bottomView.backgroundColor = [UIColor whiteColor];
        self.view.backgroundColor = LRRGBColor(245, 245, 245);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
