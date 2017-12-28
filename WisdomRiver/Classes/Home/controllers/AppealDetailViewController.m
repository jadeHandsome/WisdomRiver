//
//  AppealDetailViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/19.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "AppealDetailViewController.h"
#import "MyLabel.h"
@interface AppealDetailViewController ()

@end

@implementation AppealDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"诉求详情";
    [self popOut];
    [self setUp];
    // Do any additional setup after loading the view.
}

- (void)setUp{
    BOOL status = YES;
    if (self.dic[@"reply"] == [NSNull null] || [self.dic[@"reply"] isEqualToString:@""] || !self.dic[@"reply"]) {
        status = NO;
    }
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = COLOR(245, 245, 245, 1);
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIView * container = [UIView new];
    container.backgroundColor = COLOR(245, 245, 245, 1);
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    LRViewBorderRadius(topView, HEIGHT(15), 0.5, [UIColor lightTextColor]);
    LRViewShadow(topView, [UIColor blackColor], CGSizeMake(2, 2), 0.3, 5);
    [container addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(container).offset(5);
        make.right.equalTo(container).offset(-5);
        if (!status) {
            make.bottom.equalTo(container).offset(-5);
        }
    }];
    UILabel *appealTitle = [[UILabel alloc] init];
    appealTitle.text = @"诉求信息";
    appealTitle.textColor = ThemeColor;
    appealTitle.font = [UIFont systemFontOfSize:14];
    [topView addSubview:appealTitle];
    [appealTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(10);
        make.top.right.equalTo(topView);
        make.height.mas_equalTo(status ? 25 : 0);
    }];
    UIView *temp = appealTitle;
    for (int i = 0; i < 5; i ++) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [topView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(topView);
            make.height.mas_equalTo(0.5);
            make.top.equalTo(temp.mas_bottom);
        }];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [topView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topView).offset(10);
            make.right.equalTo(topView).offset(-10);
            make.top.equalTo(lineView.mas_bottom);
            if (i == 3) {
                make.height.mas_greaterThanOrEqualTo(50);
            }
            else{
                make.height.mas_equalTo(50);
            }
            if (i == 4) {
                make.bottom.equalTo(topView);
            }
        }];
        temp = view;
        MyLabel *title = [[MyLabel alloc] init];
        title.textColor = [UIColor lightGrayColor];
        title.font = [UIFont systemFontOfSize:14];
        [view addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view);
            make.width.mas_equalTo(62);
            if (i == 3) {
                make.top.equalTo(view).offset(4.5);
            }
            else{
                make.centerY.equalTo(view.mas_centerY);
            }
            
        }];
        
        MyLabel *content = [[MyLabel alloc] init];
        content.textColor = i == 2 ? (status ? ColorRgbValue(0x03A9F4) : ColorRgbValue(0xFFCC33)) : [UIColor blackColor];
        content.font = [UIFont systemFontOfSize:14];
        content.numberOfLines = 0;
        [view addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).offset(5);
            make.right.equalTo(view).offset(-10);
            make.top.equalTo(title.mas_top);
            if (i == 3) {
                make.bottom.equalTo(view).offset(-5);
            }
            
        }];
        if (i == 0) {
            title.text = @"诉求标题:";
            content.text = self.dic[@"title"];
        }
        else if (i == 1) {
            title.text = @"诉求类型:";
            content.text = self.dic[@"typeName"];
        }
        else if (i == 2) {
            title.text = @"处理状态:";
            content.text = status ? @"已回复":@"未回复";
        }
        else if (i == 3) {
            title.text = @"诉求内容:";
            content.text = self.dic[@"content"];
        }
        else{
            title.text = @"提交时间:";
            content.text = self.dic[@"createdate"];
        }
    }
    
    if (status) {
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor whiteColor];
        LRViewBorderRadius(bottomView, HEIGHT(15), 0.5, [UIColor lightTextColor]);
        LRViewShadow(bottomView, [UIColor blackColor], CGSizeMake(2, 2), 0.3, 5);
        [container addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(container).offset(5);
            make.top.equalTo(topView.mas_bottom).offset(10);
            make.right.bottom.equalTo(container).offset(-5);
        }];
        UILabel *replyTitle = [[UILabel alloc] init];
        replyTitle.text = @"回复信息";
        replyTitle.textColor = ThemeColor;
        replyTitle.font = [UIFont systemFontOfSize:14];
        [bottomView addSubview:replyTitle];
        [replyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView).offset(10);
            make.top.right.equalTo(bottomView);
            make.height.mas_equalTo(25);
        }];
        UIView *bottomTemp = replyTitle;
        for (int i = 0; i < 2; i ++) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [bottomView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(bottomView);
                make.height.mas_equalTo(0.5);
                make.top.equalTo(bottomTemp.mas_bottom);
            }];
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor whiteColor];
            [bottomView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(bottomView).offset(10);
                make.right.equalTo(bottomView).offset(-10);
                make.top.equalTo(lineView.mas_bottom);
                if (i == 0) {
                    make.height.mas_greaterThanOrEqualTo(50);
                }
                else{
                    make.height.mas_equalTo(50);
                    make.bottom.equalTo(bottomView);
                }
            }];
            bottomTemp = view;
            MyLabel *title = [[MyLabel alloc] init];
            title.textColor = [UIColor lightGrayColor];
            title.font = [UIFont systemFontOfSize:14];
            [view addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view);
                make.width.mas_equalTo(62);
                if (i == 0) {
                    make.top.equalTo(view).offset(4.5);
                }
                else{
                    make.centerY.equalTo(view.mas_centerY);
                }
            }];
            
            MyLabel *content = [[MyLabel alloc] init];
            content.textColor = [UIColor blackColor];
            content.font = [UIFont systemFontOfSize:14];
            content.numberOfLines = 0;
            [view addSubview:content];
            [content mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(title.mas_right).offset(5);
                make.right.equalTo(view).offset(-10);
                if (i == 0) {
                    make.bottom.equalTo(view).offset(-5);
                }
                make.top.equalTo(title.mas_top);
            }];
            if (i == 0) {
                title.text = @"诉求回复:";
                content.text = self.dic[@"reply"];
            }
            else if (i == 1) {
                title.text = @"回复时间:";
                content.text = self.dic[@"date"];
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
