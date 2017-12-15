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

- (void)setType:(NSInteger)type{
    _type = type;
    if (type == 1) {
        [_iconImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self).offset(HEIGHT(45));
            make.height.width.mas_equalTo(HEIGHT(80));
        }];
        self.bottomLine.hidden = NO;
        self.rightLine.hidden = NO;
    }
    else if (type == 2){
        [_iconImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self).offset(HEIGHT(20));
            make.height.width.mas_equalTo(HEIGHT(120));
        }];
        self.bottomLine.hidden = YES;
        self.rightLine.hidden = YES;
    }
    else{
        [_iconImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.height.width.mas_equalTo(HEIGHT(80));
        }];
        self.bottomLine.hidden = NO;
        self.rightLine.hidden = NO;
    }
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
    label.font = [UIFont systemFontOfSize:HEIGHT(38)];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = label;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(imageView.mas_bottom).offset(HEIGHT(15));
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = COLOR(245, 245, 245, 1);
    self.bottomLine = lineView1;
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = COLOR(245, 245, 245, 1);
    self.rightLine = lineView2;
    [self addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.mas_equalTo(1);
    }];
    
}

@end
