//
//  HomeViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/14.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "NewPagedFlowView.h"
#import "CommonListViewController.h"
#import "HotNewsViewController.h"
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@end



@implementation HomeViewController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        NSArray *arr = @[@[
                             @{@"title":@"网上预审",@"icon":@"button2"},
                             @{@"title":@"全程代办",@"icon":@"button3"},
                             @{@"title":@"诉求互动",@"icon":@"button4"},
                             @{@"title":@"热点资讯",@"icon":@"button1"}],
                         @[
                           @{@"title":@"1",@"icon":@"button2"},
                           @{@"title":@"2",@"icon":@"button2"},
                           @{@"title":@"3",@"icon":@"button2"},
                           @{@"title":@"4",@"icon":@"button2"},
                           @{@"title":@"5",@"icon":@"button2"},
                           @{@"title":@"6",@"icon":@"button2"},
                           @{@"title":@"7",@"icon":@"button2"},],
                         @[
                             @{@"title":@"1",@"icon":@"button2"},
                             @{@"title":@"2",@"icon":@"button2"},
                             @{@"title":@"3",@"icon":@"button2"},
                             @{@"title":@"4",@"icon":@"button2"},
                             @{@"title":@"5",@"icon":@"button2"},
                             @{@"title":@"6",@"icon":@"button2"},
                             @{@"title":@"7",@"icon":@"button2"},
                             @{@"title":@"8",@"icon":@"button2"},
                             @{@"title":@"9",@"icon":@"button2"}]];
        _dataArr = arr.mutableCopy;
    }
    return _dataArr;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    // Do any additional setup after loading the view.
}

- (void)setUp{
    self.view.backgroundColor = COLOR(245, 245, 245, 1);
    UIImageView *topImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT(566) - 64 + navHight);
    }];
    
    _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, SIZEWIDTH, HEIGHT(566) - 64 + navHight)];
    _pageFlowView.delegate = self;
    _pageFlowView.dataSource = self;
    _pageFlowView.minimumPageAlpha = 1;
    _pageFlowView.isCarousel = NO;
    _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    _pageFlowView.isOpenAutoScroll = YES;
    _pageFlowView.autoTime = 3.0;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,(HEIGHT(896) - 64 + navHight) / 2 , SIZEWIDTH, (HEIGHT(236) - 64 + navHight) / 2)];
    _pageFlowView.pageControl = pageControl;
    [_pageFlowView addSubview:pageControl];
    pageControl.alpha = 1;
    [_pageFlowView reloadData];
    [self.view addSubview:_pageFlowView];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,HEIGHT(586) - 64 + navHight , SIZEWIDTH, SIZEHEIGHT - (HEIGHT(586) - 64 + navHight) - self.tabBarController.tabBar.frame.size.height) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.bounces = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:@"HomeCell"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeReusableView"];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}

#pragma mark  -------------pageView ------------
- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [[PGIndexBannerSubiew alloc] init];
    bannerView.tag = index;
    bannerView.layer.cornerRadius = HEIGHT(10);
    bannerView.layer.masksToBounds = YES;
    bannerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    if (index == 0) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor whiteColor];
        [bannerView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bannerView).offset(HEIGHT(40));
            make.bottom.equalTo(bannerView).offset(HEIGHT(-40));
            make.centerX.equalTo(bannerView.mas_centerX);
            make.width.mas_equalTo(1);
        }];
        UIView *leftView = [[UIView alloc] init];
        leftView.backgroundColor = [UIColor clearColor];
        [bannerView addSubview:leftView];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(bannerView);
            make.right.equalTo(lineView.mas_left);
        }];
        UILabel *today = [[UILabel alloc] init];
        today.text = @"今天(限行)";
        today.textColor = [UIColor whiteColor];
        today.font = [UIFont systemFontOfSize:HEIGHT(55)];
        [leftView addSubview:today];
        [today mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leftView).offset(HEIGHT(50));
            make.centerX.equalTo(leftView.mas_centerX);
        }];
        UILabel *leftText = [[UILabel alloc] init];
        leftText.text = @"和";
        leftText.textColor = [UIColor whiteColor];
        leftText.font = [UIFont systemFontOfSize:HEIGHT(40)];
        [leftView addSubview:leftText];
        [leftText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(leftView).offset(HEIGHT(-65));
            make.centerX.equalTo(leftView.mas_centerX);
        }];
        UILabel *todayText1 = [[UILabel alloc] init];
        todayText1.text = @"2";
        todayText1.textColor = [UIColor whiteColor];
        todayText1.font = [UIFont systemFontOfSize:HEIGHT(80)];
        todayText1.backgroundColor = COLOR(93, 202, 147, 1);
        todayText1.layer.cornerRadius = HEIGHT(10);
        todayText1.layer.masksToBounds = YES;
        todayText1.textAlignment = NSTextAlignmentCenter;
        [leftView addSubview:todayText1];
        [todayText1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(leftView).offset(HEIGHT(-25));
            make.height.mas_equalTo(HEIGHT(143));
            make.width.mas_equalTo(WIDTH(100));
            make.right.equalTo(leftText.mas_left).offset(WIDTH(-25));
        }];
        UILabel *todayText2 = [[UILabel alloc] init];
        todayText2.text = @"8";
        todayText2.textColor = [UIColor whiteColor];
        todayText2.font = [UIFont systemFontOfSize:HEIGHT(80)];
        todayText2.backgroundColor = COLOR(93, 202, 147, 1);
        todayText2.layer.cornerRadius = HEIGHT(10);
        todayText2.layer.masksToBounds = YES;
        todayText2.textAlignment = NSTextAlignmentCenter;
        [leftView addSubview:todayText2];
        [todayText2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(leftView).offset(HEIGHT(-25));
            make.height.mas_equalTo(HEIGHT(143));
            make.width.mas_equalTo(WIDTH(100));
            make.left.equalTo(leftText.mas_right).offset(WIDTH(25));
        }];
        UIView *rightView = [[UIView alloc] init];
        rightView.backgroundColor = [UIColor clearColor];
        [bannerView addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(bannerView);
            make.left.equalTo(lineView.mas_right);
        }];
        UILabel *nextDay = [[UILabel alloc] init];
        nextDay.text = @"明天(限行)";
        nextDay.textColor = [UIColor whiteColor];
        nextDay.font = [UIFont systemFontOfSize:HEIGHT(55)];
        [rightView addSubview:nextDay];
        [nextDay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rightView).offset(HEIGHT(50));
            make.centerX.equalTo(rightView.mas_centerX);
        }];
        UILabel *rightText = [[UILabel alloc] init];
        rightText.text = @"和";
        rightText.textColor = [UIColor whiteColor];
        rightText.font = [UIFont systemFontOfSize:HEIGHT(40)];
        [rightView addSubview:rightText];
        [rightText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(rightView).offset(HEIGHT(-65));
            make.centerX.equalTo(rightView.mas_centerX);
        }];
        UILabel *nextDayText1 = [[UILabel alloc] init];
        nextDayText1.text = @"3";
        nextDayText1.textColor = [UIColor whiteColor];
        nextDayText1.font = [UIFont systemFontOfSize:HEIGHT(80)];
        nextDayText1.backgroundColor = COLOR(93, 202, 147, 1);
        nextDayText1.layer.cornerRadius = HEIGHT(10);
        nextDayText1.layer.masksToBounds = YES;
        nextDayText1.textAlignment = NSTextAlignmentCenter;
        [rightView addSubview:nextDayText1];
        [nextDayText1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(rightView).offset(HEIGHT(-25));
            make.height.mas_equalTo(HEIGHT(143));
            make.width.mas_equalTo(WIDTH(100));
            make.right.equalTo(rightText.mas_left).offset(WIDTH(-25));
        }];
        UILabel *nextDatText2 = [[UILabel alloc] init];
        nextDatText2.text = @"7";
        nextDatText2.textColor = [UIColor whiteColor];
        nextDatText2.font = [UIFont systemFontOfSize:HEIGHT(80)];
        nextDatText2.backgroundColor = COLOR(93, 202, 147, 1);
        nextDatText2.layer.cornerRadius = HEIGHT(10);
        nextDatText2.layer.masksToBounds = YES;
        nextDatText2.textAlignment = NSTextAlignmentCenter;
        [rightView addSubview:nextDatText2];
        [nextDatText2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(rightView).offset(HEIGHT(-25));
            make.height.mas_equalTo(HEIGHT(143));
            make.width.mas_equalTo(WIDTH(100));
            make.left.equalTo(rightText.mas_right).offset(WIDTH(25));
        }];
    }
    else{
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = [UIColor clearColor];
        [bannerView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(bannerView);
            make.height.mas_equalTo(HEIGHT(222));
        }];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s_1"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [topView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bannerView).offset(WIDTH(140));
            make.height.width.mas_equalTo(HEIGHT(96));
            make.centerY.equalTo(topView.mas_centerY);
        }];
        UILabel *weatherText = [[UILabel alloc] init];
        weatherText.text = @"阴";
        weatherText.textColor = [UIColor whiteColor];
        weatherText.font = [UIFont systemFontOfSize:HEIGHT(63)];
        [topView addSubview:weatherText];
        [weatherText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(WIDTH(45));
            make.centerY.equalTo(topView.mas_centerY);
        }];
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.text = @"12月15日";
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.font = [UIFont systemFontOfSize:HEIGHT(42)];
        [topView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weatherText.mas_right).offset(WIDTH(55));
            make.centerY.equalTo(topView.mas_centerY);
        }];
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor clearColor];
        [bannerView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(bannerView);
            make.top.equalTo(topView.mas_bottom);
        }];
        UILabel *temperatureLabel = [[UILabel alloc] init];
        temperatureLabel.text = @"7°~12°";
        temperatureLabel.textColor = [UIColor whiteColor];
        temperatureLabel.font = [UIFont systemFontOfSize:HEIGHT(40)];
        [bottomView addSubview:temperatureLabel];
        [temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView).offset(WIDTH(40));
            make.centerY.equalTo(bottomView.mas_centerY);
        }];
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.text = @"PM2.5：57 空气质量：良好°";
        detailLabel.textColor = [UIColor whiteColor];
        detailLabel.backgroundColor = COLOR(93, 202, 147, 1);
        detailLabel.layer.cornerRadius = HEIGHT(10);
        detailLabel.layer.masksToBounds = YES;
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.font = [UIFont systemFontOfSize:HEIGHT(36)];
        [bottomView addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(temperatureLabel.mas_right).offset(WIDTH(20));
            make.centerY.equalTo(bottomView.mas_centerY);
            make.height.mas_equalTo(HEIGHT(52));
            make.width.mas_equalTo(WIDTH(530));
        }];
    }
    return bannerView;
}
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return 2;
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(WIDTH(780), HEIGHT(330));
}

#pragma mark ------ UICollectionView -------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return [self.dataArr[section] count];
    }
    return [self.dataArr[section] count] + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeCell *cell = (HomeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.type = 2;
        cell.iconImage.image = [UIImage imageNamed:self.dataArr[indexPath.section][indexPath.item][@"icon"]];
        cell.titleLabel.text = self.dataArr[indexPath.section][indexPath.item][@"title"];
    }
    else{
        if (indexPath.item == 0) {
            cell.type = 0;
            cell.iconImage.image = [UIImage imageNamed:@"add_grid"];
            cell.titleLabel.text = @"";
        }
        else{
            cell.type = 1;
            cell.iconImage.image = [UIImage imageNamed:self.dataArr[indexPath.section][indexPath.item - 1][@"icon"]];
            cell.titleLabel.text = self.dataArr[indexPath.section][indexPath.item - 1][@"title"];
        }
    }
    if ((indexPath.item + 1) % 4 == 0) {
        cell.rightLine.hidden = YES;
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return nil;
    }
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeReusableView" forIndexPath:indexPath];
    headerView.backgroundColor = COLOR(245, 245, 245, 1);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT(20), SIZEHEIGHT, HEIGHT(110))];
    view.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:view];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH(35), 0, SIZEHEIGHT - WIDTH(35), HEIGHT(110))];
    label.text = indexPath.section == 1 ? @"部门" : @"主题";
    label.font = [UIFont systemFontOfSize:HEIGHT(46)];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT(110) - 1, SIZEWIDTH, 1)];
    lineView.backgroundColor = COLOR(245, 245, 245, 1);
    [view addSubview:lineView];
    [view addSubview:label];
    return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(SIZEWIDTH / 4, HEIGHT(250));
    }
    return CGSizeMake(SIZEWIDTH / 4, HEIGHT(240));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(SIZEWIDTH, HEIGHT(130));
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0 && indexPath.item == 0) {
        
    }
    else{
        if (indexPath.section == 0 && indexPath.item == 3) {
            HotNewsViewController *hotNewsVC = [HotNewsViewController new];
            [self.navigationController pushViewController:hotNewsVC animated:YES];
        }
        else if (indexPath.section == 0 && indexPath.item == 2) {
            
        }
        else{
            CommonListViewController *listVC = [CommonListViewController new];
            listVC.naviTitle = self.dataArr[indexPath.section][indexPath.item][@"title"];
            [listVC setHidesBottomBarWhenPushed:YES];
            if (indexPath.section == 0) {
                listVC.haveType = YES;
            }
            [self.navigationController pushViewController:listVC animated:YES];
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
