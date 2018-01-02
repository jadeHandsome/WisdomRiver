//
//  BussCommondViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/24.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "BussCommondViewController.h"
#import "LDXScore.h"
#import "KRMyTextView.h"
#import "CommondPic.h"
@interface BussCommondViewController ()<UITextViewDelegate,LDXDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet LDXScore *scroView;
@property (weak, nonatomic) IBOutlet KRMyTextView *myText;
@property (weak, nonatomic) IBOutlet UILabel *contLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet CommondPic *centImageView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) NSInteger count;
@end

@implementation BussCommondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myText.myPlaceholder = @"长度在10-300字之间\n写下购买体验和使用过程中带来的帮助等，可以给小伙伴提供参考哦！";
    self.count = 0;
    self.myText.delegate = self;
    self.navigationItem.title = @"评价";
    [self.headImageView sd_setImageWithURL:self.headImageUrl placeholderImage:[UIImage new]];
    LRViewBorderRadius(self.sureBtn, 5, 0, [UIColor clearColor]);
    self.scroView.delegate = self;
    [self.centImageView setImageArray];
    self.centImageView.superVC = self;
}

- (IBAction)sureClick:(id)sender {
    if (self.myText.text.length == 0) {
        [self showHUDWithText:@"请输入评价"];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"sid"] = self.ID;
    param[@"evaluate"] = @(self.count);
    param[@"note"] = self.myText.text;
    
    NSMutableArray *array = [NSMutableArray array];
    if (self.centImageView.allImage.count > 1) {
        for (int i = 1; i < self.centImageView.allImage.count; i ++) {
            UIImage *image = self.centImageView.allImage[i];
            NSDictionary *dic = @{@"data":UIImageJPEGRepresentation(image, 0.5),@"name":[NSString stringWithFormat:@"%d",i]};
            [array addObject:dic];
        }
    }
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadData:@"appOrder/evaluate" params:param andData:array waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        [self showHUDWithText:@"评价成功"];
        [self performSelector:@selector(pop) withObject:nil afterDelay:1];
    }];
    
}
- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textViewDidChange:(UITextView *)textView {
    
    self.contLabel.text = [NSString stringWithFormat:@"%ld / 300",textView.text.length];
    
}
- (void)selectedScore:(NSInteger)score {
    self.count = score;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
