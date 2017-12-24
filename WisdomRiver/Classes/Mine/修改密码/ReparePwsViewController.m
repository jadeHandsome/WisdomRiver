//
//  ReparePwsViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "ReparePwsViewController.h"

@interface ReparePwsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *orginPwd;
@property (weak, nonatomic) IBOutlet UITextField *nowPwd;
@property (weak, nonatomic) IBOutlet UIButton *repareBtn;
@property (weak, nonatomic) IBOutlet UITextField *repeatPwd;

@end

@implementation ReparePwsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    LRViewBorderRadius(self.repareBtn, 5, 0, [UIColor clearColor]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)repareClick:(id)sender {
    if (_orginPwd.text.length == 0) {
        [self showHUDWithText:@"请输入原密码"];
        return;
    }
    if (_nowPwd.text.length == 0) {
        [self showHUDWithText:@"请输入新密码"];
        return;
    }
    if (_repeatPwd.text.length == 0) {
        [self showHUDWithText:@"请确认新密码"];
        return;
    }
    if ([_repeatPwd.text isEqualToString:_nowPwd.text]) {
        [self showHUDWithText:@"两次输入密码不匹配"];
        return;
    }
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"appPersonalCenter/updatePassword" params:@{@"oldPassword":self.orginPwd.text,@"newPassword":self.nowPwd.text,@"uid":[KRUserInfo sharedKRUserInfo].userid} withModel:nil complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        [self showHUDWithText:@"修改成功"];
    }];
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
