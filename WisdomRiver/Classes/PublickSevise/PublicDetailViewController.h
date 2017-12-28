//
//  PublicDetailViewController.h
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "BaseViewController.h"

@interface PublicDetailViewController : BaseViewController
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSDictionary *oldData;
@property (nonatomic, strong) NSString *parenTitle;
@end
