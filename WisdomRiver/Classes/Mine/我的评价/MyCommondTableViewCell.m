//
//  MyCommondTableViewCell.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/25.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "MyCommondTableViewCell.h"
#import "CommondPic.h"
@interface MyCommondTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *countView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet CommondPic *picView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picHight;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation MyCommondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    LRViewBorderRadius(self.centerView, 5, 0, [UIColor clearColor]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCommondWithData:(NSDictionary *)data {
    self.nameLabel.text = data[@"name"];
    for (UIView *sub in self.countView.subviews) {
        [sub removeFromSuperview];
    }
    NSInteger f = [data[@"evaluate"] integerValue];
    UIView *temp = self.countView;
    for (int i = 0; i < 5; i ++) {
        UIImageView *imageView = nil;
        if (f > 0) {
            imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star_y"]];
            
        } else {
            imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star_empty"]];
        }
        [self.countView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(temp.mas_left);
            } else {
                make.left.equalTo(temp.mas_right);
            }
            make.centerY.equalTo(_countView.mas_centerY);
            make.width.height.equalTo(@20);
        }];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        temp = imageView;
        f --;
    }
    self.contentLabel.text = data[@"note"];
    self.timeLabel.text = data[@"date"];
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",data[@"currentprice"]];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in data[@"fileName"]) {
        [array addObject:[baseImage stringByAppendingString:dic[@"id"]]];
    }
    if (array.count == 0) {
        self.picHight.constant = 10;
    } else if (array.count > 0 && array.count <= 3) {
        self.picHight.constant = 120;
    } else {
        self.picHight.constant = 230;
    }
    self.picView.allImage = [array copy];
    for (UIView *sub in self.picView.subviews) {
        [sub removeFromSuperview];
    }
    self.picView.isShow = YES;
    [self.picView setImageArray];
}

@end
