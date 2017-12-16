//
//  SelectionView.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/16.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "SelectionView.h"



@implementation SelectionView
- (instancetype)initWithDataArr:(NSArray *)dataArr title:(NSString *)title currentIndex:(NSInteger)index seleted:(void (^)(NSInteger, NSString *))seleted{
    if (self = [super init]) {
        self.seleted = seleted;
        self.dataArr = dataArr;
        self.frame = CGRectMake(0, 0, SIZEWIDTH, SIZEHEIGHT);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        UITapGestureRecognizer *removeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
        [self addGestureRecognizer:removeTap];
        LRViewBorderRadius(self, 5, 0, [UIColor whiteColor]);
        UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(30, 0, SIZEWIDTH - 60, 40 * (dataArr.count + 1))];
        centerView.center = self.center;
        centerView.backgroundColor = [UIColor whiteColor];
        LRViewBorderRadius(centerView, 5, 0, [UIColor whiteColor]);
        [self addSubview:centerView];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, SIZEWIDTH - 85, 40)];
        titleLabel.text = title;
        [centerView addSubview:titleLabel];
        for (int i = 0; i < dataArr.count; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, (i + 1) * 40, SIZEWIDTH - 60, 40)];
            view.backgroundColor = [UIColor whiteColor];
            view.tag = i;
            [centerView addSubview:view];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
            imageView.image = [UIImage imageNamed:index == i ? @"选中":@"未选中"];
            [view addSubview:imageView];
            UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, SIZEWIDTH - 110, 40)];
            content.textColor = [UIColor grayColor];
            content.font = [UIFont systemFontOfSize:15];
            content.text = dataArr[i];
            [view addSubview:content];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [view addGestureRecognizer:tap];
        }
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)sender{
    self.seleted(sender.view.tag, self.dataArr[sender.view.tag]);
    [self removeFromSuperview];
}

- (void)remove{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
