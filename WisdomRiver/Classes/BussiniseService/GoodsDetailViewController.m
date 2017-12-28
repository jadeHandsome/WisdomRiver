//
//  GoodsDetailViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/16.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "KRMySegmentView.h"
#import "CommondTableViewCell.h"
#import "StoreDetailViewController.h"
#import "BussCommondViewController.h"
@interface GoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
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
@property (nonatomic, strong) UIView *commondView;
@property (nonatomic, strong) NSMutableArray *commondArray;
@property (nonatomic, assign) NSInteger commondPage;
@property (nonatomic, strong) NSString *chooseType;
@property (nonatomic, strong) HYBLoopScrollView *loop;

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
- (NSMutableArray *)commondArray {
    if (!_commondArray) {
        _commondArray = [NSMutableArray array];
    }
    return _commondArray;
}
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
- (void)setUpCommond {
    _commondView = [[UIView alloc]init];
    UIView *topView = [[UIView alloc]init];
    [_commondView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(HEIGHT(240)));
        make.left.top.right.equalTo(_commondView);
        
    }];
    UIView *totleView = [[UIView alloc]init];
    [topView addSubview:totleView];
    [totleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(topView);
        make.height.equalTo(@(HEIGHT(114)));
    }];
    UILabel *label = [[UILabel alloc]init];
    [totleView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totleView.mas_left).with.offset(15);
        make.centerY.equalTo(totleView.mas_centerY);
    }];
    label.text = @"总体评价：";
    CGFloat f = [self.myData[@"evrageRate"] floatValue];
    UIView *temp = label;
    for (int i = 0; i < 5; i ++) {
        UIImageView *com = nil;
        if (f > 0 && f < 1) {
            com = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star_half"]];
        } else if (f >= 1) {
            com = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star_full"]];
        } else {
            com = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star_empty"]];
        }
        [totleView addSubview:com];
        [com mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(temp.mas_right);
            make.centerY.equalTo(label.mas_centerY);
        }];
        temp = com;
        f --;
    }
    KRMySegmentView *segment = [[KRMySegmentView alloc]initWithFrame:CGRectMake(0, HEIGHT(114), SCREEN_WIDTH, HEIGHT(116)) andSegementArray:@[[NSString stringWithFormat:@"全部（%@）",self.myData[@"allRate"]],[NSString stringWithFormat:@"好评（%@）",self.myData[@"haoRate"]],[NSString stringWithFormat:@"中评（%@）",self.myData[@"zhongRate"]],[NSString stringWithFormat:@"差评（%@）",self.myData[@"chaRate"]]] andColorArray:@[LRRGBColor(0, 0, 0),ThemeColor] andClickHandle:^(NSInteger index) {
        if (index == 0) {
            self.chooseType = @"all";
        } else if (index == 1) {
            self.chooseType = @"hao";
        } else if (index == 2) {
            self.chooseType = @"zhong";
        } else {
            self.chooseType = @"cha";
        }
        [self headerFresh];
    }];
    [topView addSubview:segment];
}

- (void)addHeader:(UIScrollView *)sco {
        NSLog(@"%@",self.allImage);
    UIView *contans = [[UIView alloc]init];
    [sco addSubview:contans];
    [contans mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sco);
        make.width.equalTo(sco.mas_width);
    }];
    NSMutableArray *im = [NSMutableArray new];
    for (NSDictionary *baner in self.allImage) {
        [im addObject:[baseImage stringByAppendingString:baner[@"id"]]];
        
    }
    
    HYBLoopScrollView *loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, self.topView.frame.size.width, HEIGHT(1078)) imageUrls:im timeInterval:3 didSelect:^(NSInteger atIndex) {
        
    } didScroll:^(NSInteger toIndex) {
        
    }];
    _loop = loop;
        //loop.timeInterval = 3;
    _loop.imageContentMode = UIViewContentModeScaleAspectFill;
    _loop.clipsToBounds = YES;
        loop.placeholder = [UIImage new];
        [contans addSubview:loop];
    UIView *infoView = [[UIView alloc]init];
    [contans addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loop.mas_bottom);
        make.bottom.equalTo(contans.mas_bottom);
        make.left.right.equalTo(contans);
        make.height.equalTo(@(HEIGHT(330)));
    }];
    UILabel *nameLabel = [[UILabel alloc]init];
    [infoView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(HEIGHT(100)));
        make.left.equalTo(infoView.mas_left).with.offset(15);
        make.top.equalTo(infoView.mas_top);
    }];
    nameLabel.text = [NSString stringWithFormat:@"%@",self.myData[@"smv"][@"name"]];
    nameLabel.font = [UIFont systemFontOfSize:15];
    UILabel *detail = [[UILabel alloc]init];
    [infoView addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView.mas_left).with.offset(15);
        make.right.equalTo(infoView.mas_right).with.offset(-15);
        make.top.equalTo(nameLabel.mas_bottom);
    }];
    detail.text = [NSString stringWithFormat:@"【%@】",self.myData[@"smv"][@"note"]];
    detail.textColor = LRRGBColor(255, 96, 135);
    detail.numberOfLines = 0;
    detail.font = [UIFont systemFontOfSize:13];
    UILabel *priceLabel = [[UILabel alloc]init];
    [infoView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detail.mas_bottom).with.offset(10);
        make.left.equalTo(infoView.mas_left).with.offset(15);
    }];
    priceLabel.textColor = LRRGBColor(255, 60, 72);
    priceLabel.font = [UIFont systemFontOfSize:16];
    NSString *str = [NSString stringWithFormat:@"¥ %@",self.myData[@"smv"][@"originalprice"]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    [attr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:[str rangeOfString:@"¥"]];
    [priceLabel setAttributedText:attr];
    UILabel *nowLabel = [[UILabel alloc]init];
    [infoView addSubview:nowLabel];
    [nowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView.mas_left).with.offset(15);
        make.top.equalTo(priceLabel.mas_bottom).with.offset(10);
        
    }];
    nowLabel.textColor = LRRGBColor(117, 117, 117);
    nowLabel.font = [UIFont systemFontOfSize:14];
    nowLabel.text = [NSString stringWithFormat:@"进店价格：¥ %@",self.myData[@"smv"][@"currentprice"]];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LRRGBColor(117, 117, 117);
    [infoView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(nowLabel);
        make.centerY.equalTo(nowLabel.mas_centerY);
        make.height.equalTo(@1);
    }];
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
    self.chooseType = @"all";
    
    [self loadData];
//    [self headerFresh];
}
- (IBAction)pingjiaClick:(id)sender {
    BussCommondViewController *commond = [[BussCommondViewController alloc]init];
//    commond.headImage = ((UIImageView *)self.loop.subviews[1]).image;
    commond.ID = self.ID;
    commond.headImageUrl = self.loop.imageUrls[0];
    [self.navigationController pushViewController:commond animated:YES];
    
}
- (IBAction)gotoStorClick:(id)sender {
    StoreDetailViewController *store = [StoreDetailViewController new];
    store.stroID = self.myData[@"smv"][@"unit"];
    [self.navigationController pushViewController:store animated:YES];
}
- (IBAction)guanzuClick:(id)sender {
}
- (IBAction)callClick:(id)sender {
    [KRBaseTool callCellPhone:self.myData[@"org"][@"phone"]];
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
        [self setUpCommond];
        [self headerFresh];
    }];
}
- (void)headerFresh {
    self.commondPage = 1;
    [self loadCommond];
}
- (void)footerFresh {
    self.commondPage ++;
    [self loadCommond];
}
- (void)loadCommond {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"currPage"] = @(self.commondPage);
    param[@"pageSize"] = @10;
    param[@"evaluateType"] = self.chooseType;
    param[@"sid"] = self.ID;
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"appPublicService/findEvaluate" params:param withModel:nil complateHandle:^(id showdata, NSString *error) {
        [self.commentTab.mj_footer endRefreshing];
        [self.commentTab.mj_header endRefreshing];
        if (showdata == nil) {
            return ;
        }
        if (self.commondPage == 1) {
            self.commondArray = [showdata[@"list"] mutableCopy];
        } else {
            [self.commondArray addObjectsFromArray:showdata[@"list"]];
        }
        [self setUpTab];
        [self.commentTab reloadData];
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
        [self.centerView addSubview:self.commondView];
        [self.commondView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerView.mas_left);
            make.right.equalTo(self.centerView.mas_right);
            make.top.equalTo(self.centerView.mas_top);
            make.bottom.equalTo(self.centerView.mas_bottom);
        }];
        [self headerFresh];
    }
}

- (void)setUpTab {
    self.commentTab = [[UITableView alloc]init];
    [self.commondView addSubview:self.commentTab];
    self.commentTab.delegate = self;
    self.commentTab.dataSource = self;
    [self.commentTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commondView.mas_top).with.offset(HEIGHT(240));
        make.bottom.left.right.equalTo(_commondView);
    }];
    [self.commentTab registerNib:[UINib nibWithNibName:@"CommondTableViewCell" bundle:nil] forCellReuseIdentifier:@"commondCell"];
    [KRBaseTool tableViewAddRefreshHeader:self.commentTab withTarget:self refreshingAction:@selector(headerFresh)];
    [KRBaseTool tableViewAddRefreshFooter:self.commentTab withTarget:self refreshingAction:@selector(footerFresh)];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commondArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommondTableViewCell *comond = [tableView dequeueReusableCellWithIdentifier:@"commondCell"];
    [comond setDataWith:self.commondArray[indexPath.row]];
    return comond;
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
