//
//  YushenDetailViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "YushenDetailViewController.h"
#import "CailiaoView.h"
@interface YushenDetailViewController ()
@property (nonatomic, strong) UIScrollView *mainSco;
@property (nonatomic, strong) NSDictionary *myData;
@end

@implementation YushenDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.navigationItem.title = @"详情";
}
- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appPersonalCenter/governmentServiceDetail" params:@{@"id":self.ID} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        NSLog(@"%@",showdata);
        self.myData = [showdata copy];
        if ([self.viewType isEqualToString:@"1"]) {
            [self setUp];
        } else {
            [self setUpDati];
        }
        
    }];
}
- (void)setUp {
    NSDictionary *nowDic = nil;
    nowDic = [self.myData copy];
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
        make.height.equalTo(@160);
        //        if (!self.myData[@"reply"]) {
        //            make.bottom.equalTo(contans.mas_bottom).with.offset(-10);
        //        }
    }];
    UIView *temp = topView;
    NSArray *titleArray = @[@"预审信息",@"申请事项：",@"事项类型：",@"所属部门："];
    NSArray *rightArray = @[@"",nowDic[@"gsa"][@"serviceName"],nowDic[@"gsa"][@"typeName"],nowDic[@"gsa"][@"orgName"]];
    for (int i = 0; i < 4; i ++) {
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
//        make.height.equalTo(@120);
        make.top.equalTo(topView.mas_bottom).with.offset(10);
        make.bottom.equalTo(contans.mas_bottom).with.offset(-10);
    }];
    UIView *temp1 = bottomView;
    NSString *result = @"未审核";
    UIColor *color = nil;
    if (nowDic[@"gsa"][@"auditStatus"]) {
        if ([nowDic[@"gsa"][@"auditStatus"] integerValue]) {
            if ([nowDic[@"gsa"][@"auditResult"] integerValue]) {
                result = @"审核不通过";
                color = ColorRgbValue(0x03A9F4);
                
                
            } else {
                result = @"审核通过";
                color = ColorRgbValue(0xFFCC33);
            }
            
        } else {
            result = @"审核中";
            color = ColorRgbValue(0x5dca93);
        }
    }
    NSArray *titleArray1 = @[@"材料信息",@"审核意见："];
    NSArray *rightArray1 = @[@"",result];
    for (int i = 0; i < 2; i ++) {
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
            if ([self.myData[@"cailiao"] count] == 0) {
                make.bottom.equalTo(bottomView.mas_bottom);
            }
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
            leftLabel.textColor = color;
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
    for (int i = 0; i < [self.myData[@"cailiao"] count]; i ++) {
        CailiaoView *cailiao = [[[NSBundle mainBundle]loadNibNamed:@"CailiaoView" owner:self options:nil]firstObject];
        [cailiao setDataWithDic:self.myData[@"cailiao"][i]];
        [bottomView addSubview:cailiao];
        [cailiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(temp1.mas_bottom);
            make.left.right.equalTo(bottomView);
            if (i == [self.myData[@"cailiao"] count] - 1) {
                make.bottom.equalTo(bottomView.mas_bottom);
            }
        }];
        cailiao.superVC = self;
        temp1 = cailiao;
    }
    
}
- (void)setUpDati {
    NSDictionary *nowDic = nil;
    nowDic = [self.myData copy];
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
        make.height.equalTo(@160);
        //        if (!self.myData[@"reply"]) {
        //            make.bottom.equalTo(contans.mas_bottom).with.offset(-10);
        //        }
    }];
    UIView *temp = topView;
    NSArray *titleArray = @[@"代办信息",@"事项名称：",@"事项类型：",@"开展单位："];
    NSArray *rightArray = @[@"",nowDic[@"gsa"][@"serviceName"],nowDic[@"gsa"][@"typeName"],nowDic[@"gsa"][@"orgName"]];
    for (int i = 0; i < 4; i ++) {
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
        make.height.equalTo(@240);
        make.top.equalTo(topView.mas_bottom).with.offset(10);
        if ([nowDic[@"gsa"][@"auditResult"] isEqual:[NSNull null]]) {
            make.bottom.equalTo(contans.mas_bottom).with.offset(-10);
        }
        
    }];
    UIView *temp1 = bottomView;
    NSArray *titleArray1 = @[@"申请信息",@"姓名：",@"电话：",@"代办时间：",@"上门地址：",@"备注："];
    NSArray *rightArray1 = @[@"",nowDic[@"gsa"][@"userName"],nowDic[@"gsa"][@"phone"],nowDic[@"gsa"][@"applyDate"]?nowDic[@"gsa"][@"applyDate"]:@"-",nowDic[@"gsa"][@"auditPickupMap"]?nowDic[@"gsa"][@"auditPickupMap"]:@"-",nowDic[@"gsa"][@"note"]?nowDic[@"gsa"][@"note"]:@"-"];
    for (int i = 0; i < 6; i ++) {
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
    LRViewBorderRadius(bottomView, 5, 1, LRRGBColor(246, 246, 246));
    if (![nowDic[@"gsa"][@"auditResult"] isEqual:[NSNull null]]) {
        UIView *bottomView1 = [[UIView alloc]init];
        [contans addSubview:bottomView1];
        
        [bottomView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contans.mas_left).with.offset(5);
            make.right.equalTo(contans.mas_right).with.offset(-5);
            make.height.equalTo(@120);
            make.top.equalTo(bottomView.mas_bottom).with.offset(10);
            make.bottom.equalTo(contans.mas_bottom).with.offset(-10);
        }];
        UIView *temp1 = bottomView1;
        NSArray *titleArray1 = @[@"审核信息",@"办理结果：",@"审核意见："];
        NSString *result = @"未审核";
        UIColor *color = nil;
        if (nowDic[@"gsa"][@"auditStatus"]) {
            if ([nowDic[@"gsa"][@"auditStatus"] integerValue]) {
                if ([nowDic[@"gsa"][@"auditResult"] integerValue]) {
                    result = @"审核不通过";
                    color = ColorRgbValue(0xFFCC33);
                    
                } else {
                    result = @"审核通过";
                    color = ColorRgbValue(0x03A9F4);
                }
                
                NSString *str = @"-";
                if (nowDic[@"gsa"][@"opinion"]) {
                    str = nowDic[@"gsa"][@"opinion"];
                }
                NSArray *rightArray1 = @[@"",result,str];
                for (int i = 0; i < 3; i ++) {
                    UIView *subView = [[UIView alloc]init];
                    [bottomView1 addSubview:subView];
                    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                        if (i == 0) {
                            make.top.equalTo(temp1.mas_top);
                        } else {
                            make.top.equalTo(temp1.mas_bottom);
                        }
                        make.height.equalTo(@40);
                        make.left.right.equalTo(bottomView1);
                        
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
                        leftLabel.textColor = color;
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
                    if (i == 1) {
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
                    rightLabel.text = rightArray1[i];
                    
                }
                bottomView1.backgroundColor = [UIColor whiteColor];
                LRViewBorderRadius(bottomView1, 5, 1, LRRGBColor(246, 246, 246));
                
                
            } else {
                result = @"审核中";
                color = ColorRgbValue(0x5dca93);
            }
        }
        
        
        
        
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
