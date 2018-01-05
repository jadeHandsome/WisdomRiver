//
//  MysuiquListTableViewCell.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "MysuiquListTableViewCell.h"
@interface MysuiquListTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *namelable;
@property (weak, nonatomic) IBOutlet UILabel *contenLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIView *centerView;

@end
@implementation MysuiquListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    LRViewBorderRadius(self.centerView, 5, 1, LRRGBColor(246, 246, 246));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setdataWith:(NSDictionary *)data {
    if ([self.cellType isEqualToString:@"1"]) {
        self.namelable.text = data[@"typeName"];
        self.contenLabel.text = [NSString stringWithFormat:@"诉求内容：%@",data[@"content"]];
        self.timeLabel.text = [NSString stringWithFormat:@"提交时间：%@",data[@"createdate"]];
        if (data[@"reply"]) {
            self.statusLabel.text = @"已回复";
            self.statusLabel.textColor = ColorRgbValue(0x03A9F4);
        } else {
            self.statusLabel.text = @"未回复";
            self.statusLabel.textColor = ColorRgbValue(0xFFCC33);
            
        }
//        [data[@"auditStatus"] integerValue] == 0 ?@"待处理":@"已处理";
    } else if ([self.cellType isEqualToString:@"2"]) {
        self.namelable.text = data[@"serviceName"];
        self.contenLabel.text = [NSString stringWithFormat:@"事项类型：%@",data[@"typeName"]];
        self.timeLabel.text = [NSString stringWithFormat:@"申请时间：%@",data[@"applyDate"]];
//        self.statusLabel.text = [data[@"auditStatus"] integerValue] == 0 ?@"待处理":@"已处理";
        if (data[@"auditResult"]) {
            if (![data[@"auditResult"] integerValue]) {
                self.statusLabel.textColor = ColorRgbValue(0x03A9F4);
                self.statusLabel.text = @"通过";
            } else {
                self.statusLabel.textColor = ColorRgbValue(0xFFCC33);
                self.statusLabel.text = @"未通过";
            }
        } else {
            self.statusLabel.textColor = ColorRgbValue(0x5dca93);
            self.statusLabel.text = @"待处理";
        }
    } else if ([self.cellType isEqualToString:@"3"]) {
        self.namelable.text = data[@"serviceName"];
        self.contenLabel.text = [NSString stringWithFormat:@"事项类型：%@",data[@"typeName"]];
        self.timeLabel.text = [NSString stringWithFormat:@"申请时间：%@",data[@"applyDate"]];
        if (data[@"auditResult"]) {
            if (![data[@"auditResult"] integerValue]) {
                self.statusLabel.textColor = ColorRgbValue(0x03A9F4);
                self.statusLabel.text = @"通过";
            } else {
                self.statusLabel.textColor = ColorRgbValue(0xFFCC33);
                self.statusLabel.text = @"未通过";
            }
        } else {
            self.statusLabel.textColor = ColorRgbValue(0x5dca93);
            self.statusLabel.text = @"待处理";
        }
        //self.statusLabel.text = [data[@"auditStatus"] integerValue] == 0 ?@"待处理":@"已处理";
        //self.statusLabel.textColor = LRRGBColor(101, 216, 165);
    }
    
//    self.statusLabel.text = data[@""]
}
@end
