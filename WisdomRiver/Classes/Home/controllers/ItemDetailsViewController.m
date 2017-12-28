//
//  ItemDetailsViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/15.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "ItemDetailsViewController.h"
#import "InquiryViewController.h"
#import "CommissionViewController.h"
#import "InfoManagerViewController.h"
@interface ItemDetailsViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSArray *material;
@end

@implementation ItemDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self popOut];
    [self requestData];
    // Do any additional setup after loading the view.
}

- (void)requestData{
    NSDictionary *params = @{@"id":self.ids};
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appGovernmentFront/detail" params:params withModel:nil complateHandle:^(id showdata, NSString *error) {
        if (showdata) {
            self.dic = showdata[@"gs"];
            self.material = showdata[@"material"];
            [self setUp];
        }
    }];
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
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
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
    button2.titleLabel.font = [UIFont systemFontOfSize:14];
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
    button3.titleLabel.font = [UIFont systemFontOfSize:14];
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
    [button4 setTitle:@"申请材料" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button4 setTitleColor:COLOR(78, 78, 78, 1) forState:UIControlStateNormal];
    button4.titleLabel.font = [UIFont systemFontOfSize:14];
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
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
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
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(commission:) forControlEvents:UIControlEventTouchUpInside];
    LRViewBorderRadius(rightBtn, HEIGHT(10), 0, COLOR(105, 148, 225, 1));
    [bottomView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo((SIZEWIDTH - WIDTH(90))/2);
        make.height.mas_equalTo(HEIGHT(120));
        make.right.equalTo(bottomView).offset(WIDTH(-30));
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
#ifdef __IPHONE_11_0
    if ([scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    //    scrollView.contentSize = CGSizeMake(SIZEWIDTH * 4, SIZEHEIGHT - navHight - HEIGHT(302));
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.backgroundColor = COLOR(245, 245, 245, 1);
    scrollView.delegate = self;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(buttonsView.mas_bottom);
        make.bottom.equalTo(bottomView.mas_top);
    }];
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = COLOR(245, 245, 245, 1);
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.height.mas_equalTo(scrollView);
        make.width.mas_equalTo(SIZEWIDTH * 4);
    }];
    UIView *baseInfoView = [[UIView alloc] init];
    baseInfoView.backgroundColor = [UIColor whiteColor];
    LRViewBorderRadius(baseInfoView, HEIGHT(15), 0.5, [UIColor lightTextColor]);
    LRViewShadow(baseInfoView, [UIColor blackColor], CGSizeMake(2, 2), 0.3, 5);
    [containerView addSubview:baseInfoView];
    [baseInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containerView).offset(10);
        make.top.equalTo(containerView).offset(10);
        make.width.mas_equalTo(SIZEWIDTH - 20);
        make.height.mas_equalTo(150);
    }];
    UIView *temp;
    for (int i = 0; i < 3; i ++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [baseInfoView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseInfoView).offset(10);
            make.right.equalTo(baseInfoView).offset(-10);
            make.height.mas_equalTo(50);
            if (i == 0) {
                make.top.equalTo(baseInfoView);
            }
            else{
                make.top.equalTo(temp.mas_bottom);
            }
        }];
        temp = view;
        UILabel *title = [[UILabel alloc] init];
        title.textColor = [UIColor lightGrayColor];
        title.font = [UIFont systemFontOfSize:14];
        [view addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view);
            make.width.mas_equalTo(62);
            make.centerY.equalTo(view.mas_centerY);
        }];
        UILabel *content = [[UILabel alloc] init];
        content.textColor = [UIColor blackColor];
        content.font = [UIFont systemFontOfSize:14];
        [view addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).offset(5);
            make.right.equalTo(view).offset(-10);
            make.centerY.equalTo(view.mas_centerY);
        }];
        if (i != 2) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = [UIColor lightGrayColor];
            [view addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(view);
                make.height.mas_equalTo(0.5);
            }];
        }
        if (i == 0) {
            title.text = @"事项名称:";
            content.text = self.dic[@"name"];
        }
        else if (i == 1) {
            title.text = @"事项类型:";
            content.text = self.dic[@"typeName"];
        }
        else if (i == 2) {
            title.text = @"所属部门:";
            content.text = self.dic[@"orgName"];
        }
    }
    
    UIView *conditionView = [[UIView alloc] init];
    conditionView.backgroundColor = [UIColor whiteColor];
    LRViewBorderRadius(conditionView, HEIGHT(15), 0.5, [UIColor lightTextColor]);
    LRViewShadow(conditionView, [UIColor blackColor], CGSizeMake(2, 2), 0.3, 5);
    [containerView addSubview:conditionView];
    [conditionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containerView).offset(SIZEWIDTH + 10);
        make.top.equalTo(containerView).offset(10);
        make.width.mas_equalTo(SIZEWIDTH - 20);
    }];
    UILabel *conditionLabel = [[UILabel alloc] init];
    conditionLabel.textColor = [UIColor blackColor];
    conditionLabel.font = [UIFont systemFontOfSize:14];
    conditionLabel.numberOfLines = 0;
    NSMutableAttributedString *muatt1 = [self attributedStringWithHTMLString:[self htmlEntityDecode:self.dic[@"precondition"]]].mutableCopy;
    [muatt1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0,  muatt1.length - 1)];
    conditionLabel.attributedText = muatt1;
    [conditionView addSubview:conditionLabel];
    [conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(conditionView).offset(10);
        make.bottom.right.equalTo(conditionView).offset(-10);
    }];
    
    UIView *processView = [[UIView alloc] init];
    processView.backgroundColor = [UIColor whiteColor];
    LRViewBorderRadius(processView, HEIGHT(15), 0.5, [UIColor lightTextColor]);
    LRViewShadow(processView, [UIColor blackColor], CGSizeMake(2, 2), 0.3, 5);
    [containerView addSubview:processView];
    [processView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containerView).offset(SIZEWIDTH * 2 + 10);
        make.top.equalTo(containerView).offset(10);
        make.width.mas_equalTo(SIZEWIDTH - 20);
    }];
    UILabel *processLabel = [[UILabel alloc] init];
    processLabel.textColor = [UIColor blackColor];
    processLabel.font = [UIFont systemFontOfSize:14];
    processLabel.numberOfLines = 0;
    NSMutableAttributedString *muatt2 = [self attributedStringWithHTMLString:[self htmlEntityDecode:self.dic[@"processingProcess"]]].mutableCopy;
    [muatt2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0,  muatt2.length - 1)];
    processLabel.attributedText = muatt2;
    [processView addSubview:processLabel];
    [processLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(processView).offset(10);
        make.bottom.right.equalTo(processView).offset(-10);
    }];
    
    UIView *materialsView = [[UIView alloc] init];
    materialsView.backgroundColor = [UIColor whiteColor];
    LRViewBorderRadius(materialsView, HEIGHT(15), 0.5, [UIColor lightTextColor]);
    LRViewShadow(materialsView, [UIColor blackColor], CGSizeMake(2, 2), 0.3, 5);
    [containerView addSubview:materialsView];
    [materialsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containerView).offset(SIZEWIDTH * 3 + 10);
        make.top.equalTo(containerView).offset(10);
        make.width.mas_equalTo(SIZEWIDTH - 20);
    }];
    UIView *materialsTemp;
    for (int i = 0; i < self.material.count; i ++) {
        UILabel *materialsLabel = [[UILabel alloc] init];
        materialsLabel.textColor = [UIColor blackColor];
        materialsLabel.font = [UIFont systemFontOfSize:14];
        materialsLabel.numberOfLines = 0;
        materialsLabel.text = [NSString stringWithFormat:@"%d、%@",i+1,self.material[i][@"name"]];
        [materialsView addSubview:materialsLabel];
        [materialsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(materialsView).offset(10);
            if (i == 0) {
                make.top.equalTo(materialsView).offset(10);
            }
            else{
                make.top.equalTo(materialsTemp.mas_bottom).offset(10);
            }
            make.right.equalTo(materialsView).offset(-10);
            if (i == self.material.count - 1) {
                make.bottom.equalTo(materialsView).offset(-10);
            }
        }];
        materialsTemp = materialsLabel;
    }
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
    if ([KRUserInfo sharedKRUserInfo].card.length > 0) {
        [self handle:@"0" complete:^{
            CommissionViewController *commissionVC = [CommissionViewController new];
            commissionVC.material = self.material;
            commissionVC.ids = self.dic[@"id"];
            [self.navigationController pushViewController:commissionVC animated:YES];
        }];
        
    }
    else{
        //去身份认证
        InfoManagerViewController *info = [InfoManagerViewController new];
        [self.navigationController pushViewController:info animated:YES];
    }
}
//代办
- (void)commission:(UIButton *)sender{
    if ([KRUserInfo sharedKRUserInfo].card.length > 0) {
        [self handle:@"1" complete:^{
            InquiryViewController *inquiryVC = [InquiryViewController new];
            inquiryVC.dic = self.dic;
            [self.navigationController pushViewController:inquiryVC animated:YES];
        }];
    }
    else{
        //去身份认证
        InfoManagerViewController *info = [InfoManagerViewController new];
        [self.navigationController pushViewController:info animated:YES];
    }
}

- (void)handle:(NSString *)auditType complete:(void(^)(void))complete{
    NSDictionary *params = @{@"id":self.dic[@"id"],@"auditType":auditType};
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appGovernmentFront/yyDBValidate" params:params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata) {
            complete();
        }
    }];
}


//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}

//将HTML字符串转化为NSAttributedString富文本字符串
- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
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
