//
//  BussinCollectionViewCell.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/16.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "BussinCollectionViewCell.h"
@interface BussinCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeght;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLael;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;

@end
@implementation BussinCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageHeght.constant = HEIGHT(490);
}
- (void)setDataWithDic:(NSDictionary *)dic {
    NSString *im = @"";
    if ([dic[@"isPic"] integerValue]) {
        im = [[@"http://182.151.204.201:8081/gfile/downloadByBidAndClassName?bid=" stringByAppendingString:dic[@"module"]]stringByAppendingString:@"&cname=programManagement"];
    } else {
        im = [[@"http://182.151.204.201:8081/gfile/downloadByBidAndClassName?bid=" stringByAppendingString:dic[@"id"]]stringByAppendingString:@"&cname=businesssermanpic"];
        
    }
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:im] placeholderImage:[UIImage new]];
    self.namelabel.text = dic[@"name"];
    self.priceLael.text = [@"¥ " stringByAppendingString:[NSString stringWithFormat:@"%@",dic[@"currentprice"]]];
    self.oldPriceLabel.text = [@"¥ " stringByAppendingString: [NSString stringWithFormat:@"%@",dic[@"originalprice"]]];
    [self.nameBtn setTitle:dic[@"orgName"] forState:UIControlStateNormal];
}
@end
