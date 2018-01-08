//
//  CailiaoView.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/24.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "CailiaoView.h"
#import "UILabel+YBAttributeTextTapAction.h"
@interface CailiaoView()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *cailiaoLabel;

@end
@implementation CailiaoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setDataWithDic:(NSDictionary *)dic {
    self.nameLabel.text = dic[@"name"];
    UIColor *color = nil;
    if (dic[@"isPass"]) {
        if ([dic[@"isPass"] integerValue]) {
            self.statusLabel.text = @"审核通过";
            color = ColorRgbValue(0x03A9F4);
            
        } else {
            self.statusLabel.text = @"审核不通过";
            color = ColorRgbValue(0xFFCC33);
        }
    } else {
        self.statusLabel.text = @"审核中";
        color = ColorRgbValue(0x5dca93);
    }
    self.statusLabel.textColor = color;
    NSMutableArray *array = [NSMutableArray array];
    NSMutableString *str = [[NSMutableString alloc]init];
    for (NSDictionary *file in dic[@"fileName"]) {
        [str appendString:[file[@"name"] stringByAppendingString:@"\n"]];
        [array addObject:file[@"name"]];
    }
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
//    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//
//    [paragraphStyle setLineSpacing:10];//行间距
//
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    self.cailiaoLabel.userInteractionEnabled = YES;
    [self.cailiaoLabel setAttributedText:attributedString];
    [self.cailiaoLabel yb_addAttributeTapActionWithStrings:array tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        [self.superVC showLoadingHUD];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *file = dic[@"fileName"][index];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[baseImage stringByAppendingString:file[@"id"]]]]];
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        });
        
//        [KRBaseTool showAlert:string with_Controller:self.superVC with_titleArr:@[@"确定"] withShowType:UIAlertControllerStyleAlert with_Block:^(int index) {
//            
//        }];
    }];
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.superVC showHUDWithText:@"材料已保存到本地相册"];
    });
}
//- (void)didend {
//    
//    
//}

@end
