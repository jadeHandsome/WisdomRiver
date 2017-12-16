//
//  BussinessTableViewCell.h
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/15.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Item_click)(NSDictionary *dic);
@interface BussinessTableViewCell : UITableViewCell
@property (nonatomic, strong) Item_click block;
- (void)setUpWithDic:(NSDictionary *)dic;
@end
