//
//  HomeCell.h
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/14.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) UIView *rightLine;
@property (nonatomic, strong) UIView *bottomLine;
@end
