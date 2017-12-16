//
//  SelectionView.h
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/16.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)(NSInteger ,NSString *);
@interface SelectionView : UIView
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) Block seleted;

- (instancetype)initWithDataArr:(NSArray *)dataArr title:(NSString *)title currentIndex:(NSInteger)index seleted:(void(^)(NSInteger index,NSString *selectStr))seleted;


@end
