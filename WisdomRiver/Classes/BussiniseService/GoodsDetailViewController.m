//
//  GoodsDetailViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/16.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "GoodsDetailViewController.h"

@interface GoodsDetailViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTop;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic, strong) UIScrollView *infoSco;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UITableView *commentTab;
@property (nonatomic, strong) NSArray *allImage;
@property (nonatomic, strong) NSDictionary *myData;
@end

@implementation GoodsDetailViewController
//- (NSArray *)allImage {
//    if (!_allImage) {
//        NSArray *array = [self.oldData[@"abstract"] componentsSeparatedByString:@","];
//        NSDictionary *dic = @{@"isPic":@0,@"id":array[]}
//        _allImage = self.oldData[@""];
//    }
//    return _allImage;
//}
- (UIScrollView *)infoSco {
    if (!_infoSco) {
        _infoSco = [[UIScrollView alloc]init];
        [self addHeader:_infoSco];
    }
    return _infoSco;
}
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        [_webView loadHTMLString:self.myData[@"smv"][@"content"] baseURL:nil];
    }
    return _webView;
}
//- (void)addHeader {
//    NSLog(@"%@",self.allImage);
//    NSMutableArray *im = [NSMutableArray new];
//    for (NSDictionary *baner in self.allImage) {
//        if ([baner[@"isPic"] integerValue]) {
//            [im addObject:[[@"http://182.151.204.201:8081/gfile/downloadByBidAndClassName?bid=" stringByAppendingString:baner[@"module"]]stringByAppendingString:@"&cname=programManagement"]];
//        } else {
//            [im addObject:[[@"http://182.151.204.201:8081/gfile/downloadByBidAndClassName?bid=" stringByAppendingString:baner[@"id"]]stringByAppendingString:@"&cname=businesssermanpic"]];
//        }
//        
//    }
//    
//    HYBLoopScrollView *loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, self.topView.frame.size.width, self.topView.frame.size.height) imageUrls:im timeInterval:3 didSelect:^(NSInteger atIndex) {
//        
//    } didScroll:^(NSInteger toIndex) {
//        NSDictionary *dic = self.allImage[toIndex];
//        self.topNameLabel.text = dic[@"name"];
//        self.topCountName.text = [NSString stringWithFormat:@"%d/%d",toIndex + 1,self.allImage.count];
//    }];
//    //loop.timeInterval = 3;
//    loop.placeholder = [UIImage new];
//    [self.topView addSubview:loop];
//    [self.topView bringSubviewToFront:self.shadView];
//    
//}
- (void)addHeader:(UIScrollView *)sco {
        NSLog(@"%@",self.allImage);
        NSMutableArray *im = [NSMutableArray new];
        for (NSDictionary *baner in self.allImage) {
            [im addObject:[baseImage stringByAppendingString:baner[@"id"]]];
    
        }
    
        HYBLoopScrollView *loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, self.topView.frame.size.width, HEIGHT(1078)) imageUrls:im timeInterval:3 didSelect:^(NSInteger atIndex) {
    
        } didScroll:^(NSInteger toIndex) {
           
        }];
        //loop.timeInterval = 3;
        loop.placeholder = [UIImage new];
        [sco addSubview:loop];
//    UILabel *nameLabel = [[UILabel alloc]init];
//    [sco addSubview:nameLabel];
//    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(loop.mas_bottom);
//        make.left.equalTo(sco.mas_left).with.offset(10);
//        make.right.equalTo(self.view.mas_right).with.offset(-10);
//    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottomHeight.constant = HEIGHT(140);
    self.topHeight.constant = HEIGHT(150);
    self.topTop.constant = 0;
    self.navigationItem.title = @"商品详情";
    [self loadData];
}
- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appPublicService/detail" params:@{@"id":self.ID} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        self.myData = [showdata copy];
        self.allImage = [showdata[@"images"] copy];
        [self.centerView addSubview:self.infoSco];
        [_infoSco mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerView.mas_left);
            make.bottom.equalTo(self.centerView.mas_bottom);
            make.top.equalTo(self.centerView.mas_top);
            make.right.equalTo(self.centerView.mas_right);
        }];
    }];
}
- (IBAction)topClick:(UIButton *)sender {
    for (UIButton *btn in self.topView.subviews) {
        btn.selected = NO;
        
    }
    sender.selected = YES;
    for (UIView *sub in self.centerView.subviews) {
        
            [sub removeFromSuperview];
        
        
    }
    if (sender.tag == 100) {
        [self.centerView addSubview:self.infoSco];
        [_infoSco mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerView.mas_left);
            make.bottom.equalTo(self.centerView.mas_bottom);
            make.top.equalTo(self.centerView.mas_top);
            make.right.equalTo(self.centerView.mas_right);
        }];
    } else if (sender.tag == 101) {
        [self.centerView addSubview:self.webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerView.mas_left);
            make.right.equalTo(self.centerView.mas_right);
            make.top.equalTo(self.centerView.mas_top);
            make.bottom.equalTo(self.centerView.mas_bottom);
        }];
    } else {
        
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
