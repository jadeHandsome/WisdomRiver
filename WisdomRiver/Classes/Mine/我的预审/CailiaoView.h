//
//  CailiaoView.h
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/24.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CailiaoView : UIView
@property (nonatomic, strong) BaseViewController *superVC;
- (void)setDataWithDic:(NSDictionary *)dic;
@end
