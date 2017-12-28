//
//  HomeCell.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/14.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setUp];
    }
    return self;
}

- (void)setUp{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImage = imageView;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self).offset(HEIGHT(20));
        make.height.width.mas_equalTo(HEIGHT(120));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = label;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(imageView.mas_bottom).offset(HEIGHT(15));
    }];

}

@end
