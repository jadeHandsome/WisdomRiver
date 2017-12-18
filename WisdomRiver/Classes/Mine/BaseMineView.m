//
//  BaseMineView.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/18.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "BaseMineView.h"

@interface BaseMineView()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation BaseMineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setDataWithDic:(NSDictionary *)dic {
    self.headImageView.image = [UIImage imageNamed:dic[@"image"]];
    self.nameLabel.text = dic[@"name"];
}

@end
