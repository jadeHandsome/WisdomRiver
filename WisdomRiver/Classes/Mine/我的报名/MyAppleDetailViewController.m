//
//  MyAppleDetailViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "MyAppleDetailViewController.h"

@interface MyAppleDetailViewController ()
@property (nonatomic, strong) UIScrollView *mainSco;
@property (nonatomic, strong) NSDictionary *myData;
@property (nonatomic, strong) NSDictionary *seve;
@end

@implementation MyAppleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appPersonalCenter/yybmDetail" params:@{@"id":self.appleId} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        self.myData = [showdata[@"personal"] copy];
        if (showdata[@"service1"]) {
            self.seve = [showdata[@"service1"] copy];
        } else {
            self.seve = [showdata[@"service2"] copy];
        }
        [self setUp];
    }];
}
- (void)setUp {
    NSDictionary *nowDic = nil;
    nowDic = [self.seve copy];
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
        make.height.equalTo(@280);
//        if (!self.myData[@"reply"]) {
//            make.bottom.equalTo(contans.mas_bottom).with.offset(-10);
//        }
    }];
    UIView *temp = topView;
    NSArray *titleArray = @[@"服务信息",@"服务名称：",@"服务类型：",@"开展单位：",@"报名开始时间：",@"报名结束时间：",@"备注："];
    NSArray *rightArray = @[@"",nowDic[@"vname"],nowDic[@"bname"],nowDic[@"oname"],nowDic[@"startdate"]?nowDic[@"startdate"]:@"无限制",nowDic[@"enddate"]?nowDic[@"enddate"]:@"无限制",nowDic[@"note"]];
    for (int i = 0; i < 7; i ++) {
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
//        if (i == 3) {
//            rightLabel.textColor = ThemeColor;
//        } else {
            rightLabel.textColor = LRRGBColor(144, 144, 144);
        //}
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
    
        UIView *bottomView = [[UIView alloc]init];
        [contans addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contans.mas_left).with.offset(5);
            make.right.equalTo(contans.mas_right).with.offset(-5);
            make.height.equalTo(@(40 * 5));
            make.top.equalTo(topView.mas_bottom).with.offset(10);
            make.bottom.equalTo(contans.mas_bottom).with.offset(-10);
        }];
        UIView *temp1 = bottomView;
        NSArray *titleArray1 = @[@"报名人信息",@"姓名：",@"电话：",@"紧急联系人：",@"紧急联系人电话："];
    NSArray *rightArray1 = @[@"",self.myData[@"uname"],self.myData[@"phone"],self.myData[@"emergencyContact"]?self.myData[@"emergencyContact"]:@"-",self.myData[@"emergencyPhone"]?self.myData[@"emergencyPhone"]:@"-"];
        for (int i = 0; i < 5; i ++) {
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
        
        //        LRViewBorderRadius(bottomView, 5, 1, LRRGBColor(246, 246, 246));
        topView.backgroundColor = [UIColor whiteColor];
        //        bottomView.backgroundColor = [UIColor whiteColor];
        self.view.backgroundColor = LRRGBColor(245, 245, 245);
    }
    
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
