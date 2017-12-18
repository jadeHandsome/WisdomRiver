//
//  BussinessTableViewCell.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/15.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "BussinessTableViewCell.h"
#import "BussItemBtnView.h"
@interface BussinessTableViewCell()
@property (nonatomic, strong) NSDictionary *myData;
@end
@implementation BussinessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setUpWithDic:(NSDictionary *)dic {
    if (!dic) {
        return;
    }
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
    self.myData = [dic copy];
//    UIView *bottomView = [[UIView alloc]init];
//    [self addSubview:bottomView];
//    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).with.offset(15);
//        make.right.equalTo(self.mas_right).with.offset(-15);
//        make.top.equalTo(self.mas_top);
//        make.height.equalTo(@(HEIGHT(242)));
//    }];
    
    BussItemBtnView *item = [[[NSBundle mainBundle]loadNibNamed:@"BussItemBtnView" owner:self options:nil]firstObject];
    [self addSubview:item];
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@(HEIGHT(242)));
    }];
    item.backgroundColor = [UIColor whiteColor];
    LRViewBorderRadius(item, 10, 1, LRRGBColor(240, 240, 240));
    LRViewShadow(item, [UIColor blackColor], CGSizeMake(2, 2), 0.5, 10);
    
    //LRViewBorderRadius(item, 10, 1, LRRGBColor(240, 240, 240));
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [item addGestureRecognizer:tap];
    [item setUpWithDic:self.myData];
}
- (void)click {
    if (self.block) {
        self.block(self.myData);
    }
}
@end
