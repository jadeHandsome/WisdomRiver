//
//  AppealCell.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/16.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "AppealCell.h"

@implementation AppealCell

- (void)awakeFromNib {
    [super awakeFromNib];
    LRViewBorderRadius(self.container, HEIGHT(10), 0.5, [UIColor lightGrayColor]);
    LRViewShadow(self.container, [UIColor blackColor], CGSizeMake(1, 1), 0.3, HEIGHT(10));
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
