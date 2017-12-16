//
//  CommonListCell.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/15.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "CommonListCell.h"

@implementation CommonListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUp];
    }
    return self;
}

- (void)setUp{
    UIImageView *iconImage = [[UIImageView alloc] init];
    self.iconImage = iconImage;
    [self addSubview:iconImage];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(WIDTH(28));
        make.height.width.mas_equalTo(HEIGHT(138));
        make.centerY.equalTo(self);
    }];
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:HEIGHT(42)];
    self.title = title;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImage.mas_right).offset(WIDTH(28));
        make.top.equalTo(self).offset(HEIGHT(66));
    }];
    UILabel *content = [[UILabel alloc] init];
    content.font = [UIFont systemFontOfSize:HEIGHT(38)];
    content.textColor = COLOR(120, 120, 120, 1);
    content.numberOfLines = 0;
    self.content = content;
    [self addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImage.mas_right).offset(WIDTH(28));
        make.top.equalTo(title.mas_bottom).offset(HEIGHT(15));
        make.right.equalTo(self).offset(WIDTH(-50));
        make.bottom.equalTo(self).offset(HEIGHT(-43));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
