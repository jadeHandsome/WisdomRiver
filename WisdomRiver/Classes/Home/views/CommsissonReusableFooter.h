//
//  CommsissonReusableFooter.h
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^submitBlock) (void);
@interface CommsissonReusableFooter : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic, strong) submitBlock block;
@end
