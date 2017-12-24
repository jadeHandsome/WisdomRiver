//
//  CommondTableViewCell.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "CommondTableViewCell.h"
@interface CommondTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIView *countView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *CONTENvIEW;
@property (weak, nonatomic) IBOutlet UIView *centerImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerHeight;

@end
@implementation CommondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataWith:(NSDictionary *)data {
    for (UIView *sub in self.centerImageView.subviews) {
        [sub removeFromSuperview];
    }
    if (data[@"fileName"]) {
        if ([data[@"fileName"] count] == 0) {
            self.centerHeight.constant = 0;
        } else {
            self.centerHeight.constant = 100;
            UIView *temp = self.centerImageView;
            for (int i = 0; i < [data[@"fileName"] count]; i ++) {
                UIImageView *contenImage = [[UIImageView alloc]init];
                contenImage.clipsToBounds = YES;
                contenImage.contentMode = UIViewContentModeScaleAspectFill;
                [self.centerImageView addSubview:contenImage];
                [contenImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (i == 0) {
                        make.left.equalTo(temp.mas_left);
                    } else {
                        make.left.equalTo(temp.mas_right);
                    }
                    make.width.equalTo(@((SCREEN_WIDTH - 100)/3.0));
                    make.top.bottom.equalTo(self.centerImageView);
                }];
                [contenImage sd_setImageWithURL:[baseImage stringByAppendingString:data[@"fileName"][i][@"id"]] placeholderImage:[UIImage new]];
                temp = contenImage;
            }
            
        }
    } else {
        self.centerHeight.constant = 0;
    }
    
    self.nameLabel.text = data[@"uid"];
    self.timeLabel.text = data[@"date"];
    self.CONTENvIEW.text = data[@"note"];
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
    
}

@end
