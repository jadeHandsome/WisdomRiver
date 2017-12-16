//
//  BussinessSubViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/15.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "BussinessSubViewController.h"

@interface BussinessSubViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeght;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UILabel *imageTitlelabel;
@property (weak, nonatomic) IBOutlet UILabel *imageNumLabel;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *leftItemLabel;
@property (nonatomic, strong) NSArray *allImage;
@end

@implementation BussinessSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleHeght.constant = HEIGHT(160);
    self.topHeight.constant = HEIGHT(740);
    [self loadData];
}
- (void)loadData {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"moduleId"] = self.moduleId;
    param[@"currPage"] = @1;
    param[@"pageSize"] = @10;
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"appBusiness/getServiceManagementByProgramManagement" params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        self.allImage = [showdata[@"list"] copy];
        [self addHeader];
        
    }];
}
- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}
- (void)addHeader {
    NSMutableArray *im = [NSMutableArray new];
    for (NSDictionary *baner in self.allImage) {
        if ([baner[@"isPic"] integerValue]) {
            [im addObject:[[@"http://182.151.204.201:8081/gfile/downloadByBidAndClassName?bid=" stringByAppendingString:baner[@"module"]]stringByAppendingString:@"&cname=programManagement"]];
        } else {
            [im addObject:[[@"http://182.151.204.201:8081/gfile/downloadByBidAndClassName?bid=" stringByAppendingString:baner[@"id"]]stringByAppendingString:@"&cname=businesssermanpic"]];
        }
        
    }
    
    HYBLoopScrollView *loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, self.topView.frame.size.width, self.topView.frame.size.height) imageUrls:im timeInterval:3 didSelect:^(NSInteger atIndex) {
        
    } didScroll:^(NSInteger toIndex) {
        
    }];
    //loop.timeInterval = 3;
    loop.placeholder = [UIImage new];
    [self.topView addSubview:loop];
    
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
