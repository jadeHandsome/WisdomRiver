//
//  StoreDetailViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/24.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "StoreDetailViewController.h"
#import "BussinCollectionViewCell.h"
#import "KRMySegmentView.h"
#import "GoodsDetailViewController.h"
@interface StoreDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionFlowyout;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) NSMutableArray *allItem;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, assign) NSInteger page;
@end

@implementation StoreDetailViewController
- (NSMutableArray *)allItem {
    if (!_allItem) {
        _allItem = [NSMutableArray array];
    }
    return _allItem;
}
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
    [self addHeadView];
    [self setCollec];
    self.navigationItem.title = @"商家主页";
    self.view.backgroundColor = LRRGBColor(245, 245, 245);
    [self headerFresh];
}
- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"appShopInformation/shopInfoService" params:@{@"unit":self.stroID,@"category":@2,@"currPage":@(self.page),@"pageSize":@10} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        if (showdata == nil) {
            return ;
        }
        NSLog(@"%@",showdata);
        if (self.page == 1) {
            self.allItem = [showdata[@"list"] mutableCopy];
        } else {
            [self.allItem addObjectsFromArray:showdata[@"list"]];
        }
        
        [self.collectionView reloadData];
        [self.headImageView sd_setImageWithURL:[baseImage stringByAppendingString:showdata[@"org"][@"imageId"]] placeholderImage:[UIImage imageNamed:@"shop_icon"]];
        self.nameLabel.text = [NSString stringWithFormat:@"%@\n平台自营",showdata[@"org"][@"name"]];
    }];
}
- (void)addHeadView {
    self.headView = [[UIView alloc]init];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@110);
    }];
    UIView *leftView = [[UIView alloc]init];
    [self.headView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.headView);
        make.width.equalTo(@(SCREEN_WIDTH * 0.6));
        make.height.equalTo(@80);
    }];
    UIImageView *storeImageView = [[UIImageView alloc]init];
    [leftView addSubview:storeImageView];
    [storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(leftView);
        make.height.width.equalTo(@(80));
    }];
    storeImageView.contentMode = UIViewContentModeCenter;
    _headImageView = storeImageView;
    UILabel *nameLabel = [[UILabel alloc]init];
    [leftView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(storeImageView.mas_right);
        make.centerY.equalTo(storeImageView.mas_centerY);
    }];
    _nameLabel = nameLabel;
    nameLabel.numberOfLines = 0;
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = @"培训室\n平台自营";
    
    UIView *line = [[UIView alloc]init];
    [leftView addSubview:line];
    line.backgroundColor = LRRGBColor(246, 246, 246);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(leftView);
        make.height.equalTo(@40);
        make.width.equalTo(@1);
        make.centerY.equalTo(leftView.mas_centerY);
    }];
    UIView *rightView = [[UIView alloc]init];
    [self.headView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftView.mas_right);
        make.right.equalTo(self.headView.mas_right);
        make.top.equalTo(self.headView.mas_top);
        make.height.equalTo(@80);
        
    }];
    UILabel *fensiLabel  = [[UILabel alloc]init];
    [rightView addSubview:fensiLabel];
    [fensiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightView.mas_left).with.offset(10);
        make.centerY.equalTo(rightView.mas_centerY);
    }];
    fensiLabel.font = [UIFont systemFontOfSize:14];
    fensiLabel.numberOfLines = 0;
    fensiLabel.text = @"0\n粉丝";
    fensiLabel.textAlignment = NSTextAlignmentCenter;
    UIButton *guanzu = [[UIButton alloc]init];
    [rightView addSubview:guanzu];
    guanzu.titleLabel.font = [UIFont systemFontOfSize:15];
    [guanzu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.centerY.equalTo(rightView.mas_centerY);
        make.left.equalTo(fensiLabel.mas_right).with.offset(10);
        make.width.equalTo(@80);
    }];
    [guanzu setTitle:@"关注" forState:UIControlStateNormal];
    guanzu.backgroundColor = LRRGBColor(255, 38, 56);
    [guanzu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    LRViewBorderRadius(guanzu, 5, 0, [UIColor clearColor]);
    KRMySegmentView *segement = [[KRMySegmentView alloc]initWithFrame:CGRectZero andSegementArray:@[@"首页",@"全部",@"新品",@"活动"] andColorArray:nil andClickHandle:^(NSInteger index) {
        [self loadData];
    }];
    [self.headView addSubview:segement];
    [segement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headView);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.headView.mas_centerX);
        make.width.equalTo(@(SCREEN_WIDTH * 0.5));
    }];
}
- (void)footerFresh {
    self.page ++;
    [self loadData];
}
- (void)headerFresh {
    self.page = 1;
    [self loadData];
}

- (void)setCollec {
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.collectionFlowyout];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.collectionView.backgroundColor = LRRGBColor(244, 244, 244);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [KRBaseTool tableViewAddRefreshFooter:self.collectionView withTarget:self refreshingAction:@selector(footerFresh)];
    [KRBaseTool tableViewAddRefreshHeader:self.collectionView withTarget:self refreshingAction:@selector(headerFresh)];
    [self.collectionView registerNib:[UINib nibWithNibName:@"BussinCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
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
