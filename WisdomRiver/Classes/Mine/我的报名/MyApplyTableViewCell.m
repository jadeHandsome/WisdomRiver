//
//  MyApplyTableViewCell.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "MyApplyTableViewCell.h"
@interface MyApplyTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *statuLabel;
@property (weak, nonatomic) IBOutlet UIView *centerView;

@end
@implementation MyApplyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    LRViewBorderRadius(self.centerView, 5, 1, LRRGBColor(246, 246, 246));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataWithDic:(NSDictionary *)dic {
    self.titleLabel.text = dic[@"vname"];
    self.firstLabel.text = [NSString stringWithFormat:@"服务类型：%@",dic[@"bname"]];
    self.secondLabel.text = [NSString stringWithFormat:@"开展单位：%@",dic[@"oname"]];
    self.thirdLabel.text = [NSString stringWithFormat:@"申请时间：%@",dic[@"date"]];
}

@end
