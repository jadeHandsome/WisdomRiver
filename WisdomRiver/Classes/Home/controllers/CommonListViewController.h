//
//  CommonListViewController.h
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/15.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "BaseViewController.h"

@interface CommonListViewController : BaseViewController
@property (nonatomic, strong) NSString *naviTitle;
@property (nonatomic, assign) BOOL haveType;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, assign) BOOL isTheme;//是否是主题
@end
