//
//  BussinessSubViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/15.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "BussinessSubViewController.h"
#import "BussinCollectionViewCell.h"
#import "GoodsDetailViewController.h"
@interface BussinessSubViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeght;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UILabel *imageTitlelabel;
@property (weak, nonatomic) IBOutlet UILabel *imageNumLabel;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *leftItemLabel;
@property (nonatomic, strong) NSArray *allImage;
@property (nonatomic, strong) NSArray *allTypes;
@property (nonatomic, strong) UIView *lineView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionFlowyout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *shadView;
@property (weak, nonatomic) IBOutlet UILabel *topNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *topCountName;
@property (nonatomic, strong) NSArray *allItem;
@end

@implementation BussinessSubViewController
-(UICollectionViewFlowLayout *)collectionFlowyout{

if (_collectionFlowyout == nil) {

_collectionFlowyout = [[UICollectionViewFlowLayout alloc] init];

_collectionFlowyout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*0.5, HEIGHT(710));

_collectionFlowyout.minimumLineSpacing = 0;

_collectionFlowyout.minimumInteritemSpacing = 0;

}

return _collectionFlowyout;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleHeght.constant = HEIGHT(160);
    self.topHeight.constant = HEIGHT(740);
    [self.searchBar setBackgroundImage:[UIImage new]];
    self.searchBar.backgroundColor = LRRGBColor(245, 245, 245);
    self.leftItemLabel.text = self.titleStr;
    [self loadData];
    [self setCollec];
}
- (void)setCollec {
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.collectionFlowyout];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.collectionView.backgroundColor = LRRGBColor(244, 244, 244);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"BussinCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
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
        self.allTypes = [showdata[@"types"] copy];
        [self addHeader];
        [self setBtns];
        [self getBottomData:self.allTypes[0][@"id"]];
    }];
}
- (void)setBtns {
    
    UIView *temp = self.btnView;
    for (int i = 0; i < self.allTypes.count; i ++) {
        UIButton *btn = [[UIButton alloc]init];
        NSDictionary *dic = self.allTypes[i];
        [_btnView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(temp.mas_left);
            } else {
                make.left.equalTo(temp.mas_right);
            }
            make.top.equalTo(_btnView.mas_top);
            make.bottom.equalTo(self.btnView.mas_bottom);
            if (i == self.allTypes.count - 1) {
                make.right.equalTo(_btnView.mas_right);
            }
            if (i > 0) {
                make.width.equalTo(temp.mas_width);
            }
            
        }];
        if (i == 0) {
            btn.selected = YES;
            self.searchBar.placeholder = [NSString stringWithFormat:@"在 %@中 搜索",dic[@"name"]];
        }
        btn.tag = 100 + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:dic[@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:ThemeColor forState:UIControlStateSelected];
        [btn setTitleColor:LRRGBColor(121, 121, 121) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        temp = btn;
    }
    
    self.lineView = [[UIView alloc]init];
    [self.btnView addSubview:self.lineView];
    CGSize size = [KRBaseTool getNSStringSize:self.allTypes[0][@"name"] andViewWight:MAXFLOAT andFont:14];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.bottom.equalTo(self.btnView.mas_bottom);
        make.width.equalTo(@(size.width));
        make.centerX.equalTo([self.btnView viewWithTag:100].mas_centerX);
    }];
    _lineView.backgroundColor = ThemeColor;
    
}
- (void)btnClick:(UIButton *)sender {
    for (UIButton *btn in self.btnView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn setSelected:NO];
        }
        
    }
    CGSize size = [KRBaseTool getNSStringSize:[sender titleForState:UIControlStateNormal] andViewWight:MAXFLOAT andFont:14];
    self.searchBar.placeholder = [NSString stringWithFormat:@"在 %@中 搜索",[sender titleForState:UIControlStateNormal]];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.bottom.equalTo(self.btnView.mas_bottom);
        make.width.equalTo(@(size.width));
        make.centerX.equalTo(sender.mas_centerX);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self.btnView layoutIfNeeded];
    } completion:^(BOOL finished) {
        sender.selected = YES;
        [self getBottomData:self.allTypes[sender.tag - 100][@"id"]];
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
    NSLog(@"%@",self.allImage);
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
        NSDictionary *dic = self.allImage[toIndex];
        self.topNameLabel.text = dic[@"name"];
        self.topCountName.text = [NSString stringWithFormat:@"%d/%d",toIndex + 1,self.allImage.count];
    }];
    //loop.timeInterval = 3;
    loop.placeholder = [UIImage new];
    [self.topView addSubview:loop];
    [self.topView bringSubviewToFront:self.shadView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allItem.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BussinCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setDataWithDic:self.allItem[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsDetailViewController *detail = [GoodsDetailViewController new];
    detail.ID = self.allItem[indexPath.row][@"id"];
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)getBottomData:(NSString *)ID {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"moduleId"] = self.moduleId;
    param[@"currPage"] = @1;
    param[@"pageSize"] = @10;
    param[@"type"] = ID;
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"appBusiness/getServiceManagementByProgramManagement" params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        self.allItem = [showdata[@"list"] copy];
        [self.collectionView reloadData];
    }];
}

@end
