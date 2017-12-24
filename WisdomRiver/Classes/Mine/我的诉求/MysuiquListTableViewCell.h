//
//  MysuiquListTableViewCell.h
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MysuiquListTableViewCell : UITableViewCell
- (void)setdataWith:(NSDictionary *)data;
@property (nonatomic, strong) NSString *cellType;
@end
