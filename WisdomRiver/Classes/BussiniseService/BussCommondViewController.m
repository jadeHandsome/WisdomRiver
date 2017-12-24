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
@interface BussCommondViewController ()<UITextViewDelegate,LDXDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet LDXScore *scroView;
@property (weak, nonatomic) IBOutlet KRMyTextView *myText;
@property (weak, nonatomic) IBOutlet UILabel *contLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIView *centImageView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) NSInteger count;
@end

@implementation BussCommondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myText.myPlaceholder = @"长度在100-300字之间\n写下购买体验和使用过程中带来的帮助等，可以给小伙伴提供参考哦！";
    self.myText.delegate = self;
    self.navigationItem.title = @"评价";
    self.headImageView.image = self.headImage;
    LRViewBorderRadius(self.sureBtn, 5, 0, [UIColor clearColor]);
    self.scroView.delegate = self;
}
- (IBAction)imageClick:(id)sender {
    
}
- (IBAction)sureClick:(id)sender {
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
