//
//  PublicCollectionViewCell.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/18.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "PublicCollectionViewCell.h"
@interface PublicCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *watchCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameHeight;

@end
@implementation PublicCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageHeight.constant = HEIGHT(500);
    self.nameHeight.constant = HEIGHT(90);
    [self.statusLabel setTitleColor:ThemeColor forState:UIControlStateNormal];
    //self.statusLabel.textColor = ThemeColor;
    LRViewBorderRadius(self.backView, 10, 0, [UIColor clearColor]);
}
- (void)setDataWithDic:(NSDictionary *)data {
    NSString *im = @"";
    if ([data[@"isPic"] integerValue]) {
        im = [[@"http://182.151.204.201/gfile/downloadByBidAndClassName?bid=" stringByAppendingString:data[@"module"]]stringByAppendingString:@"&cname=programManagement"];
    } else {
        im = [[@"http://182.151.204.201/gfile/downloadByBidAndClassName?bid=" stringByAppendingString:data[@"id"]]stringByAppendingString:@"&cname=publicsermanpic"];
        
    }
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:im] placeholderImage:[UIImage new]];
    self.nameLabel.text = data[@"name"];
//    lxzt
//    int
//    预约或报名（-1未开始0报名中2名额已满1一结束）
//    @"" containsString:<#(nonnull NSString *)#>
    if ([data[@"typeName"] containsString:@"报名"]) {
        NSString *title = @"";
        if ([data[@"lxzt"] integerValue] == -1) {
            title = @" 未开始";
        } else if ([data[@"lxzt"] integerValue] == 0) {
            title = @" 报名中";
        } else if ([data[@"lxzt"] integerValue] == 2) {
            title = @" 名额已满";
        } else if ([data[@" lxzt"] integerValue] == 1) {
            title = @"已结束";
        }
        [self.statusLabel setTitle:title forState:UIControlStateNormal];
    } else {
        [self.statusLabel setTitle:data[@"abstract"] forState:UIControlStateNormal];
    }
    
    [self.watchCountLabel setTitle:[@" " stringByAppendingString:[NSString stringWithFormat:@"%@",data[@"viewNumber"]]] forState:UIControlStateNormal];
    [self.statusLabel setImage:[UIImage imageNamed:@"order"] forState:UIControlStateNormal];
    [self.watchCountLabel setImage:[UIImage imageNamed:@"see"] forState:UIControlStateNormal];
//    self.statusLabel.text = title;
//     self.watchCountLabel.text = [NSString stringWithFormat:@"%@",data[@"viewNumber"]];
}
@end
