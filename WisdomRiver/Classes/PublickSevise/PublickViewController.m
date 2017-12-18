//
//  PublickViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/14.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "PublickViewController.h"
#import "CBSegmentView.h"
#import "PublicCollectionViewCell.h"
@interface PublickViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UISearchBar *seachBar;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionFlowyout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *allItem;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *allGoods;
@property (nonatomic, strong) CBSegmentView *titleBtnView;
@end

@implementation PublickViewController
-(UICollectionViewFlowLayout *)collectionFlowyout{
    
    if (_collectionFlowyout == nil) {
        
        _collectionFlowyout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionFlowyout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*0.5, HEIGHT(700));
        
        _collectionFlowyout.minimumLineSpacing = 0;
        
        _collectionFlowyout.minimumInteritemSpacing = 0;
        
    }
    return _collectionFlowyout;
}
- (NSMutableArray *)allGoods {
    if (!_allGoods) {
        _allGoods = [NSMutableArray array];
    }
    return _allGoods;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeader];
    //[self setUp];
    self.page = 1;
    [self loadData];
    
}
- (void)setUpCollec {
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.collectionFlowyout];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBtnView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.collectionView.backgroundColor = LRRGBColor(244, 244, 244);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"PublicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}
- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"appPublicService/getProgramManagement" params:nil withModel:nil complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        self.allItem = [showdata[@"pms"] copy];
        [self setUp];
        [self setUpCollec];
        [self getFirstModel:self.allItem[0]];
    }];
}
- (void)setUp {
    CBSegmentView *titlBtnView = [[CBSegmentView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    _titleBtnView = titlBtnView;
    [self.view addSubview:titlBtnView];
    NSMutableArray *titleArray = [NSMutableArray array];
    for (NSDictionary *dic in self.allItem) {
        [titleArray addObject:dic[@"name"]];
    }
    __weak typeof(self) weakSelf = self;
    [titlBtnView setTitleArray:titleArray titleFont:14 titleColor:[UIColor blackColor] titleSelectedColor:ThemeColor withStyle:CBSegmentStyleSlider];
    titlBtnView.titleChooseReturn = ^(NSInteger x) {
        NSLog(@"点了弟%d个",x);
        NSDictionary *dic = self.allItem[x];
        [self getFirstModel:dic];
    };
}
- (void)getFirstModel:(NSDictionary *)model {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"moduleId"] = model[@"id"];
    param[@"currPage"] = @(self.page);
    param[@"pageSize"] = @20;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appPublicService/getServiceManagementByProgramManagement" params:param withModel:nil complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        if (self.page == 1) {
            self.allGoods = [showdata[@"list"] mutableCopy];
            
        } else {
            [self.allGoods addObjectsFromArray:showdata[@"list"]];
        }
        [self.collectionView reloadData];
        NSLog(@"%@",showdata);
    }];
}
- (void)addHeader {
    self.seachBar = [[UISearchBar alloc]init];
    self.navigationItem.titleView = self.seachBar;
    self.seachBar.placeholder = @"在 技能培训 中搜索";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allGoods.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PublicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setDataWithDic:self.allGoods[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.allGoods[indexPath.row];
    if (![dic[@"requesturl"] isEqual:[NSNull null]]) {
        BaseWebViewController *web = [[BaseWebViewController alloc]init];
        web.urlStr = dic[@"requesturl"];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }
}
@end
