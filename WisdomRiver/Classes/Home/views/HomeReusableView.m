//
//  HomeReusableView.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/19.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "HomeReusableView.h"

@implementation HomeReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR(245, 245, 245, 1);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT(20), SIZEHEIGHT, HEIGHT(110))];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH(35), 0, SIZEHEIGHT - WIDTH(35), HEIGHT(110))];
        self.title = label;
        label.font = [UIFont systemFontOfSize:HEIGHT(46)];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT(110) - 1, SIZEWIDTH, 1)];
        lineView.backgroundColor = COLOR(245, 245, 245, 1);
        [view addSubview:lineView];
        [view addSubview:label];
    }
    return self;
}
@end
