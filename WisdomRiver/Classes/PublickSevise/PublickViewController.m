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
#import "PublicDetailViewController.h"
@interface PublickViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *seachBar;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionFlowyout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *allItem;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *allGoods;
@property (nonatomic, strong) CBSegmentView *titleBtnView;
@property (nonatomic, strong) NSDictionary *selectedModel;
@property (nonatomic, strong) NSString *searchStr;
@property (nonatomic, strong) NSString *titles;
@property (nonatomic, strong) UIImageView *noDataImage;
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
    [KRBaseTool tableViewAddRefreshFooter:self.collectionView withTarget:self refreshingAction:@selector(footerFresh)];
    [KRBaseTool tableViewAddRefreshHeader:self.collectionView withTarget:self refreshingAction:@selector(headerFresh)];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PublicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    UIImageView *noDataImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty"]];
    noDataImage.contentMode = UIViewContentModeScaleAspectFit;
    noDataImage.hidden = YES;
    self.noDataImage = noDataImage;
    [self.view addSubview:noDataImage];
    [noDataImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.height.width.mas_equalTo(80);
    }];
}
- (void)loadData {
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"appPublicService/getProgramManagement" params:nil withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            [self addReLoadBtn];
            return ;
        }
        self.allItem = [showdata[@"pms"] copy];
        [self setUp];
        [self setUpCollec];
        if ([self.allItem count] > 0) {
            self.selectedModel = self.allItem[0];
        }
        [self headerFresh];
        
//        [self getFirstModel:self.allItem[0]];
    }];
}

- (void)addReLoadBtn{
    UIButton *reloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    reloadBtn.backgroundColor = ThemeColor;
    [reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    [reloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    LRViewBorderRadius(reloadBtn, 5, 0, ThemeColor);
    [reloadBtn addTarget:self action:@selector(reLoadData:) forControlEvents:UIControlEventTouchUpInside];
    reloadBtn.center = self.view.center;
    [self.view addSubview:reloadBtn];
}

- (void)reLoadData:(UIButton *)sender{
    [self loadData];
    [sender removeFromSuperview];
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
        self.titles = dic[@"name"];
        weakSelf.seachBar.placeholder = [NSString stringWithFormat:@"在 %@ 中搜索",dic[@"name"]];
        weakSelf.selectedModel = [dic copy];
//        [self getFirstModel:dic];
        [weakSelf headerFresh];
    };
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)headerFresh {
    self.page = 1;
    [self getFirstModel:self.selectedModel];
}
- (void)footerFresh {
    self.page ++;
    [self getFirstModel:self.selectedModel];
}
- (void)getFirstModel:(NSDictionary *)model {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (model) {
        param[@"moduleId"] = model[@"id"];
    }
    
    param[@"currPage"] = @(self.page);
    param[@"pageSize"] = @20;
    param[@"name"] = self.searchStr;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appPublicService/getServiceManagementByProgramManagement" params:param withModel:nil complateHandle:^(id showdata, NSString *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        if (showdata == nil) {
            return ;
        }
        if (self.page == 1) {
            self.allGoods = [showdata[@"list"] mutableCopy];
            
        } else {
            [self.allGoods addObjectsFromArray:showdata[@"list"]];
        }
        if (!showdata || self.allGoods.count == 0) {
            self.noDataImage.hidden = NO;
        }
        else{
            self.noDataImage.hidden = YES;
        }
        [self.collectionView reloadData];
        NSLog(@"%@",showdata);
    }];
}
- (void)addHeader {
    self.seachBar = [[UISearchBar alloc]init];
    self.navigationItem.titleView = self.seachBar;
    self.seachBar.placeholder = @"在 技能培训 中搜索";
    self.seachBar.delegate = self;
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
   
    if ([dic[@"typeName"] containsString:@"外链"] || [dic[@"typeName"] containsString:@"内链"]) {
        BaseWebViewController *web = [[BaseWebViewController alloc]init];
        web.urlStr = dic[@"requesturl"];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    } else {
        PublicDetailViewController *detail = [PublicDetailViewController new];
        detail.ID = dic[@"id"];
        detail.hidesBottomBarWhenPushed = YES;
        detail.title = dic[@"name"];
        detail.parenTitle = self.titles;
        [self.navigationController pushViewController:detail animated:YES];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchStr = searchBar.text;
    [self headerFresh];
    [self.seachBar resignFirstResponder];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchStr = searchBar.text;
}
@end
