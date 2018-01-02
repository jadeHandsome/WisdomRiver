//
//  LoginViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/14.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "HomeViewController.h"
#import "BaseTabbarViewController.h"

@interface LoginViewController ()
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *pwdField;
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    self.phoneField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    self.pwdField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];
    if (self.phoneField.text && self.pwdField.text) {
        [self loginAction:nil];
    }
}

- (void)setUp{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loadingbg_66"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT(613));
    }];
    
    UIView *userView = [[UIView alloc] init];
    userView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:userView];
    [userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(HEIGHT(153));
        make.width.mas_equalTo(WIDTH(900));
        make.height.mas_equalTo(WIDTH(150));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user"]];
    userImage.contentMode = UIViewContentModeScaleAspectFit;
    [userView addSubview:userImage];
    [userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(userView);
        make.width.mas_equalTo(WIDTH(50));
        make.height.mas_equalTo(HEIGHT(60));
    }];
    UITextField *userField = [[UITextField alloc] init];
    userField.placeholder = @"请输入手机号";
    userField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneField = userField;
    [userView addSubview:userField];
    [userField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userImage.mas_right).offset(WIDTH(30));
        make.right.equalTo(userView);
        make.centerY.equalTo(userImage.mas_centerY);
    }];
    UIView *userLine = [[UIView alloc] init];
    userLine.backgroundColor = COLOR(207, 205, 205, 1);
    [userView addSubview:userLine];
    [userLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(userView);
        make.height.mas_equalTo(1);
    }];
    
    UIView *pwdView = [[UIView alloc] init];
    pwdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pwdView];
    [pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userView.mas_bottom).offset(HEIGHT(40));
        make.width.mas_equalTo(WIDTH(900));
        make.height.mas_equalTo(WIDTH(150));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    UIImageView *pwdImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    pwdImage.contentMode = UIViewContentModeScaleAspectFit;
    [pwdView addSubview:pwdImage];
    [pwdImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(pwdView);
        make.width.mas_equalTo(WIDTH(50));
        make.height.mas_equalTo(HEIGHT(60));
    }];
    UITextField *pwdField = [[UITextField alloc] init];
    pwdField.placeholder = @"请输入密码";
    self.pwdField = pwdField;
    pwdField.secureTextEntry = YES;
    [pwdView addSubview:pwdField];
    [pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdImage.mas_right).offset(WIDTH(30));
        make.right.equalTo(pwdView);
        make.centerY.equalTo(pwdImage.mas_centerY);
    }];
    UIView *pwdLine = [[UIView alloc] init];
    pwdLine.backgroundColor = COLOR(207, 205, 205, 1);
    [pwdView addSubview:pwdLine];
    [pwdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(pwdView);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT(48)];
    [loginBtn setBackgroundColor:ThemeColor];
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    LRViewBorderRadius(loginBtn, HEIGHT(63), 0.5, ThemeColor);
    LRViewShadow(loginBtn, [UIColor blackColor], CGSizeMake(2, 2), 0.5, HEIGHT(10));
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdView.mas_bottom).offset(HEIGHT(50));
        make.width.mas_equalTo(WIDTH(900));
        make.height.mas_equalTo(HEIGHT(126));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    UIButton *registerBtn = [[UIButton alloc] init];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT(48)];
    [registerBtn setBackgroundColor:[UIColor whiteColor]];
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    LRViewBorderRadius(registerBtn, HEIGHT(63), 0.5, [UIColor whiteColor]);
    LRViewShadow(registerBtn, [UIColor blackColor], CGSizeMake(2, 2), 0.5, HEIGHT(10));
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(HEIGHT(40));
        make.width.mas_equalTo(WIDTH(900));
        make.height.mas_equalTo(HEIGHT(126));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

- (void)loginAction:(UIButton *)sender{
    if ([self cheakPhoneNumber:self.phoneField.text]) {
        if (self.pwdField.text) {
            NSDictionary *params = @{@"phone":self.phoneField.text,@"password":self.pwdField.text};
            [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appMain/login" params:params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                if (showdata) {
                    [self showHUDWithText:showdata[@"mess"]];
                    [[NSUserDefaults standardUserDefaults] setObject:self.phoneField.text forKey:@"phone"];
                    [[NSUserDefaults standardUserDefaults] setObject:self.pwdField.text forKey:@"pwd"];
                    [[NSUserDefaults standardUserDefaults] setObject:showdata[@"user"] forKey:@"userInfo"];
                    [[KRUserInfo sharedKRUserInfo] setValuesForKeysWithDictionary:showdata[@"user"]];
                    BaseTabbarViewController *tab = [[BaseTabbarViewController alloc]init];
                    self.view.window.rootViewController = tab;
                }
                else{
                    [self showHUDWithText:@"服务器异常，请稍后再试"];
                }
            }];
        }
        else{
            [self showHUDWithText:@"密码不能为空"];
        }
    }
    else{
        [self showHUDWithText:@"手机号格式错误"];
    }

}

- (void)registerAction:(UIButton *)sender{
    RegisterViewController *registerVC = [RegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
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
