//
//  CommissionViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#define ItemW ( SIZEWIDTH - 20 - 15 ) / 4
#define ItemH ( SIZEWIDTH - 20 - 15 ) / 4

#import "CommissionViewController.h"
#import "CommissionCell.h"
#import "CommsissionReusableView.h"
#import "ZLPickPhotoViewController.h"
#import "CommsissonReusableFooter.h"
@interface CommissionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imagesArr;
@property (nonatomic, strong) NSArray *heightArr;
@end

@implementation CommissionViewController

- (NSMutableArray *)imagesArr{
    if (!_imagesArr) {
        _imagesArr = [NSMutableArray array];
        for (int i = 0; i < self.material.count; i++) {
            [_imagesArr addObject:[NSArray array]];
        }
    }
    return _imagesArr;
}

- (NSArray *)heightArr{
    if (!_heightArr) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in self.material) {
            CGRect rect = [dic[@"name"] boundingRectWithSize:CGSizeMake(SIZEWIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
            [arr addObject:@(rect.size.height + 20)];
        }
        _heightArr = arr;
    }
    return _heightArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服务预审";
    [self setUp];
    [self popOut];
    // Do any additional setup after loading the view.
}

- (void)setUp{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(ItemW, ItemH)];
    [layout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    [layout setMinimumLineSpacing:10];
    [layout setMinimumInteritemSpacing:5];
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SIZEWIDTH, SIZEHEIGHT - navHight) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.bounces = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerNib:[UINib nibWithNibName:@"CommissionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CommissionCell"];
    
    [collectionView registerNib:[UINib nibWithNibName:@"CommsissionReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CommsissionReusableView"];
    [collectionView registerNib:[UINib nibWithNibName:@"CommsissonReusableFooter" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CommsissonReusableFooter"];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}

#pragma mark ------ UICollectionView -------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.imagesArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.imagesArr[section] count] + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommissionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommissionCell" forIndexPath:indexPath];
    if (indexPath.item == [self.imagesArr[indexPath.section] count]) {
        cell.iconImage.image = [UIImage imageNamed:@"线圈"];
    }
    else{
        cell.iconImage.image = self.imagesArr[indexPath.section][indexPath.item];
    }
    return cell;
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        CommsissionReusableView *headerView = (CommsissionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CommsissionReusableView" forIndexPath:indexPath];
        headerView.titleLabel.text = self.material[indexPath.section][@"name"];
        return headerView;
    }
    else{
        if (indexPath.section == self.imagesArr.count - 1) {
            CommsissonReusableFooter *footerView = (CommsissonReusableFooter *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CommsissonReusableFooter" forIndexPath:indexPath];
            footerView.block = ^{
                NSDictionary *params = @{@"id":self.ids,@"auditType":@"0"};
                NSMutableArray *arr = [NSMutableArray array];
                for (NSArray *images in self.imagesArr) {
                    if (images.count == 0) {
                        [self showHUDWithText:@"请选择相应的照片"];
                        return ;
                    }
                    for (UIImage *image in images) {
                        [arr addObject:@{@"data":UIImageJPEGRepresentation(image, 1.0),@"name":@"file"}];
                    }
                }
                [[KRMainNetTool sharedKRMainNetTool] upLoadData:@"appGovernmentFront/serviceYYDB" params:params andData:arr waitView:self.view complateHandle:^(id showdata, NSString *error) {
                    if (showdata) {
                        [self showHUDWithText:@"提交成功"];
                        [self performSelector:@selector(popOutAction) withObject:nil afterDelay:1.0];
                    }
                }];
            };
            return footerView;
        }
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SIZEWIDTH, [self.heightArr[section] floatValue]);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section != self.imagesArr.count - 1) {
        return CGSizeZero;
    }
    else{
        return CGSizeMake(SIZEWIDTH, 100);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == [self.imagesArr[indexPath.section] count]) {
        ZLPickPhotoViewController *pickVC = [[ZLPickPhotoViewController alloc] initWithCompleteHandle:^(NSArray *images) {
            [self.imagesArr replaceObjectAtIndex:indexPath.section withObject:images];
            [self.collectionView reloadData];
        }];
        pickVC.limitCount = 9;
        [self.navigationController pushViewController:pickVC animated:YES];
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
