//
//  CommondPic.h
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/24.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommondPic : UIView
@property (nonatomic, strong) BaseViewController *superVC;
@property (nonatomic, strong) NSMutableArray *allImage;
@property (nonatomic, assign) BOOL isShow;
- (void)setImageArray;
@end
