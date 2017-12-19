//
//  HomeCell1.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/19.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "HomeCell1.h"

@implementation HomeCell1
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setUp];
    }
    return self;
}
- (void)setUp{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_grid"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.width.mas_equalTo(HEIGHT(80));
    }];
    

    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = COLOR(245, 245, 245, 1);
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = COLOR(245, 245, 245, 1);
    [self addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.mas_equalTo(1);
    }];
    
}
@end
