//
//  PublicDetailViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "PublicDetailViewController.h"
#import "NewPagedFlowView.h"
#import "InfoManagerViewController.h"
#import "SignUpViewController.h"
@interface PublicDetailViewController ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>
@property (nonatomic, strong) UIScrollView *mainSco;
@property (nonatomic, strong) NSArray *allImage;
@property (nonatomic, strong) NSDictionary *myData;
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIButton *payBtn;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation PublicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self loadData];
    self.view.backgroundColor = LRRGBColor(245, 245, 245);
}
- (void)setUp {
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    UIButton *payBtn = [[UIButton alloc]init];
    [bottomView addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(bottomView);
        make.width.equalTo(@(SCREEN_WIDTH * 0.6));
        
    }];
    payBtn.backgroundColor = ThemeColor;
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(toBao) forControlEvents:UIControlEventTouchUpInside];
    UILabel *statusLabel = [[UILabel alloc]init];
    [bottomView addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).with.offset(15);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    statusLabel.textColor = LRRGBColor(255, 138, 78);
    _statusLabel = statusLabel;
    _payBtn = payBtn;
    
    _bottomView = bottomView;
    
}
- (void)toBao {
    if (![[self.payBtn titleForState:UIControlStateNormal] isEqualToString:@"立即参加"]) {
        return;
    }
    if (![KRUserInfo sharedKRUserInfo].card) {
        [KRBaseTool showAlert:@"办理该服务需要身份证细腻，请先完善您的身份证信息" with_Controller:self with_titleArr:@[@"确定"] withShowType:UIAlertControllerStyleAlert with_Block:^(int index) {
            if (index == 0) {
                InfoManagerViewController *mine = [InfoManagerViewController new];
                [self.navigationController pushViewController:mine animated:YES];
            }
        }];
        return;
    }
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appPublicService/YYBMValidate" params:@{@"id":self.ID,@"typeCode":self.myData[@"smv"][@"typeCode"]} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        SignUpViewController *sign = [SignUpViewController new];
        sign.ID = self.ID;
        sign.name = self.myData[@"smv"][@"name"];
        [self.navigationController pushViewController:sign animated:YES];
    }];
}
- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appPublicService/detail" params:@{@"id":self.ID} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        [self setUp];
        self.myData = [showdata copy];
        self.allImage = [showdata[@"images"] copy];
        [self addHeader:self.mainSco];
        if ([self.myData[@"smv"][@"typeName"] containsString:@"报名"]) {
            NSString *str = [NSString stringWithFormat:@"状态：%@中",self.myData[@"smv"][@"typeName"]];
            NSMutableAttributedString *atta = [[NSMutableAttributedString alloc]initWithString:str];
            [atta addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:[str rangeOfString:@"状态："]];
            [self.statusLabel setAttributedText:atta];
        } else {
            NSString *str = @"状态：寄售中";
            NSMutableAttributedString *atta = [[NSMutableAttributedString alloc]initWithString:str];
            [atta addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:[str rangeOfString:@"状态："]];
            [_statusLabel setAttributedText:atta];
            
        }
        if ([self.myData[@"smv"][@"typeName"] isEqualToString:@"报名"]) {
            [_payBtn setTitle:@"立即参加" forState:UIControlStateNormal];
        } else {
            if (self.myData[@"smv"][@"phone"]) {
                [_payBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
            } else {
                [_payBtn setTitle:@"暂无电话" forState:UIControlStateNormal];
            }
            
        }
    }];
}
- (void)addHeader:(UIScrollView *)sco {
    self.mainSco = [[UIScrollView alloc]init];
    [self.view addSubview:self.mainSco];
    [self.mainSco mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
    _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(-10, 10, SCREEN_WIDTH + 10, 250)];
    _pageFlowView.delegate = self;
    _pageFlowView.dataSource = self;
    _pageFlowView.minimumPageAlpha = 1;
    _pageFlowView.isCarousel = NO;
    _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    _pageFlowView.isOpenAutoScroll = YES;
    _pageFlowView.autoTime = 3.0;
    UIView *contans = [[UIView alloc]init];
    [self.mainSco addSubview:contans];
    [contans mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainSco.mas_top).with.offset(0);
        make.bottom.left.right.equalTo(self.mainSco);
        make.width.equalTo(self.mainSco.mas_width);
    }];
    
    [contans addSubview:_pageFlowView];
//    [_pageFlowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.top.equalTo(contans).with.offset(10);
//        make.height.equalTo(@250);
////        make.bottom.equalTo(contans.mas_bottom);
//        make.left.equalTo(contans.mas_left).with.offset(-10);
//    }];
    [_pageFlowView reloadData];
    UIView *first = [[UIView alloc]init];
    [contans addSubview:first];
    
    first.backgroundColor = [UIColor whiteColor];
    CGSize size = [KRBaseTool getNSStringSize:self.myData[@"smv"][@"abstract"] andViewWight:SCREEN_WIDTH - 40 andFont:12];
    [first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pageFlowView.mas_bottom).with.offset(10);
        make.left.equalTo(contans.mas_left).with.offset(10);
        make.right.equalTo(contans.mas_right).with.offset(-10);
        make.height.equalTo(@(30 + size.height + 10 + 40 + 6 * 30));
//        make.bottom.equalTo(contans.mas_bottom).with.offset(-10);
    }];
    UILabel *nameLabel = [[UILabel alloc]init];
    [first addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(first.mas_top);
        make.left.equalTo(first.mas_left).with.offset(10);
        make.height.equalTo(@30);
        
    }];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.text = self.myData[@"smv"][@"name"];
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.numberOfLines = 0;
    contentLabel.text = self.myData[@"smv"][@"abstract"];
    contentLabel.textColor = LRRGBColor(140, 140, 140);
    [first addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom);
        make.left.equalTo(first.mas_left).with.offset(10);
        make.right.equalTo(first.mas_right).with.offset(-10);
        
    }];
    UIView *line = [[UIView alloc]init];
    [first addSubview:line];
    line.backgroundColor = LRRGBColor(246, 246, 246);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(first);
        make.top.equalTo(contentLabel.mas_bottom).with.offset(10);
        make.height.equalTo(@1);
        
    }];
    UIButton *addressBtn = [[UIButton alloc]init];
    [first addSubview:addressBtn];
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(first.mas_left).with.offset(10);
        make.top.equalTo(line.mas_bottom);
        make.height.equalTo(@40);
    }];
    if (self.myData[@"smv"][@"hddd"]) {
        [addressBtn setTitle:[@" " stringByAppendingString:self.myData[@"smv"][@"hddd"]] forState:UIControlStateNormal];
    } else {
        [addressBtn setTitle:[@" " stringByAppendingString:@"暂无"] forState:UIControlStateNormal];
    }
    
    addressBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addressBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addressBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    addressBtn.userInteractionEnabled = NO;
    NSArray *leftArray = @[@"开展单位：",@"开课时间：",@"开班人数：",@"已报名人数：",@"开始报名时间：",@"结束报名时间："];
    NSArray *rightArray = @[self.myData[@"smv"][@"orgName"],self.myData[@"smv"][@"hdsj"]?self.myData[@"smv"][@"hdsj"]:@"无",@"无限制",@"0",@"无限制",@"无限制"];
    UIView *temp = addressBtn;
    for (int i = 0; i < 6; i ++) {
        UIView *sub = [[UIView alloc]init];
        [first addSubview:sub];
        [sub mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(first.mas_left).with.offset(10);
            make.top.equalTo(temp.mas_bottom);
            make.right.equalTo(first.mas_right);
            make.height.equalTo(@30);
        }];
        temp = sub;
        UILabel *left = [[UILabel alloc]init];
        [sub addSubview:left];
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sub.mas_left);
            make.centerY.equalTo(sub.mas_centerY);
        }];
        left.font = [UIFont systemFontOfSize:14];
        UILabel *right = [[UILabel alloc]init];
        right.font = [UIFont systemFontOfSize:14];
        if (i == 0) {
            right.textColor = ThemeColor;
        } else {
            right.textColor = LRRGBColor(140, 140, 140);
        }
        [sub addSubview:right];
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(left.mas_right);
            make.centerY.equalTo(left.mas_centerY);
        }];
        right.text = rightArray[i];
        left.text = leftArray[i];
    }
    UIView *second = [[UIView alloc]init];
    [contans addSubview:second];
    second.backgroundColor = [UIColor whiteColor];
    [second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(first.mas_bottom).with.offset(10);
        make.left.equalTo(contans.mas_left).with.offset(5);
        make.right.equalTo(contans.mas_right).with.offset(-5);
        make.bottom.equalTo(contans.mas_bottom).with.offset(-10);
        
    }];
    UILabel *titleLabel = [[UILabel alloc]init];
    [second addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.top.equalTo(second.mas_top);
        make.centerX.equalTo(second.mas_centerX);
        
    }];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"服务介绍";
    UILabel *webLabel = [[UILabel alloc]init];
    [second addSubview:webLabel];
    [webLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(second.mas_left).with.offset(10);
        make.top.equalTo(titleLabel.mas_bottom);
        make.right.equalTo(second.mas_right).with.offset(-10);
        make.bottom.equalTo(second.mas_bottom).with.offset(-10);
    }];
    webLabel.numberOfLines = 0;
    NSString *str = [self.myData[@"smv"][@"content"] stringByReplacingOccurrencesOfString:@"/gfile/downloadURL" withString:@"http://182.151.204.201:8081/gfile/downloadURL"];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [webLabel setAttributedText:attrStr];
    [webLabel sizeToFit];
    [second sizeToFit];
//    self.mainSco.contentSize = CGSizeMake(0, CGRectGetMaxY(second.frame));
//    [second mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(first.mas_bottom).with.offset(10);
//        make.left.equalTo(contans.mas_left).with.offset(5);
//        make.right.equalTo(contans.mas_right).with.offset(-5);
//        make.bottom.equalTo(contans.mas_bottom).with.offset(-10);
//        make.height.equalTo(@(webLabel.frame.size.height + 30));
//    }];
    
   
    
}
#pragma mark  -------------pageView ------------
- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    [bannerView.mainImageView sd_setImageWithURL:[baseImage stringByAppendingString:self.allImage[index][@"id"]] placeholderImage:[UIImage new]];
    
//    PGIndexBannerSubiew *bannerView = [[PGIndexBannerSubiew alloc] init];
//    bannerView.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
//    bannerView.mainImageView.clipsToBounds = YES;
    
    return bannerView;
}
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.allImage.count;
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(SCREEN_WIDTH - 30, 240);
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
