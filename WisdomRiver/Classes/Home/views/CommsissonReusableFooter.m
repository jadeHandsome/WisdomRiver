//
//  CommsissonReusableFooter.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "CommsissonReusableFooter.h"

@implementation CommsissonReusableFooter
- (IBAction)submit:(id)sender {
    self.block();
}

- (void)awakeFromNib {
    [super awakeFromNib];
    LRViewBorderRadius(self.submitBtn, 20, 0, [UIColor whiteColor]);
    // Initialization code
}

@end
