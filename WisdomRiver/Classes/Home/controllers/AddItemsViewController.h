//
//  AddItemsViewController.h
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/17.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^Selected) (NSArray *);
@interface AddItemsViewController : BaseViewController
@property (nonatomic, strong) NSString *naviTitle;
@property (nonatomic, strong) Selected block;
@end
