//
//  BussItemBtnView.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/14.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "BussItemBtnView.h"
@interface BussItemBtnView()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titeLabel;

@end
@implementation BussItemBtnView

- (void)setUpWithDic:(NSDictionary *)data {
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[baseImage stringByAppendingString:data[@"images"][0][@"id"]]] placeholderImage:[UIImage new]];
    self.titeLabel.text = data[@"name"];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    LRViewBorderRadius(self.headImage, self.headImage.frame.size.width * 0.5, 0, [UIColor clearColor]);
    
}
@end
