//
//  RegisterViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 4017/12/14.
//  Copyright © 4017年 曾洪磊. All rights reserved.
//

#import "RegisterViewController.h"
#import "CommuntyViewController.h"
@interface RegisterViewController ()
@property (nonatomic, strong) UITextField *IDField;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *codeField;
@property (nonatomic, strong) UITextField *pwdField;
@property (nonatomic, strong) UITextField *surePwdField;
@property (nonatomic, strong) UITextField *commiField;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) NSString *communityId;
@end

@implementation RegisterViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    self.time = 60;
    [self popOut];
    [self setUp];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(community:) name:@"SelectCommunity" object:nil];

    // Do any additional setup after loading the view.
}

- (void)community:(NSNotification *)sender{
    NSDictionary *dic = sender.object;
    self.communityId = dic[@"id"];
    self.commiField.text = dic[@"name"];
}

- (void)setUp{
    UIView *IdContainer = [[UIView alloc] init];
    IdContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:IdContainer];
    [IdContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WIDTH(80));
        make.right.equalTo(self.view).offset(-WIDTH(80));
        make.top.equalTo(self.view).offset(HEIGHT(40));
        make.height.mas_equalTo(HEIGHT(120));
    }];
    UITextField *IDField = [[UITextField alloc] init];
    IDField.placeholder = @"身份证号";
    IDField.font = [UIFont systemFontOfSize:14];
    self.IDField = IDField;
    [IdContainer addSubview:IDField];
    [IDField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(IdContainer);
    }];
    UIView *IDLine = [[UIView alloc] init];
    IDLine.backgroundColor = [UIColor lightGrayColor];
    [IdContainer addSubview:IDLine];
    [IDLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(IdContainer);
        make.height.mas_equalTo(0.5);
    }];
    UIView *nameContainer = [[UIView alloc] init];
    nameContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameContainer];
    [nameContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WIDTH(80));
        make.right.equalTo(self.view).offset(-WIDTH(80));
        make.top.equalTo(IdContainer.mas_bottom).offset(HEIGHT(40));
        make.height.mas_equalTo(HEIGHT(120));
    }];
    UITextField *nameField = [[UITextField alloc] init];
    nameField.placeholder = @"真实姓名（必填）";
    nameField.font = [UIFont systemFontOfSize:14];
    self.nameField = nameField;
    [nameContainer addSubview:nameField];
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(nameContainer);
    }];
    UIView *nameLine = [[UIView alloc] init];
    nameLine.backgroundColor = [UIColor lightGrayColor];
    [nameContainer addSubview:nameLine];
    [nameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(nameContainer);
        make.height.mas_equalTo(0.5);
    }];
    UIView *phoneContainer = [[UIView alloc] init];
    phoneContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneContainer];
    [phoneContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WIDTH(80));
        make.right.equalTo(self.view).offset(-WIDTH(80));
        make.top.equalTo(nameContainer.mas_bottom).offset(HEIGHT(40));
        make.height.mas_equalTo(HEIGHT(120));
    }];
    UITextField *phoneField = [[UITextField alloc] init];
    phoneField.placeholder = @"手机号（必填）";
    phoneField.font = [UIFont systemFontOfSize:14];
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneField = phoneField;
    [phoneContainer addSubview:phoneField];
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(phoneContainer);
    }];
    UIView *phoneLine = [[UIView alloc] init];
    phoneLine.backgroundColor = [UIColor lightGrayColor];
    [phoneContainer addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(phoneContainer);
        make.height.mas_equalTo(0.5);
    }];
    UIView *codeContainer = [[UIView alloc] init];
    codeContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:codeContainer];
    [codeContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WIDTH(80));
        make.right.equalTo(self.view).offset(-WIDTH(80));
        make.top.equalTo(phoneContainer.mas_bottom).offset(HEIGHT(40));
        make.height.mas_equalTo(HEIGHT(120));
    }];
    UITextField *codeField = [[UITextField alloc] init];
    codeField.placeholder = @"验证码（必填）";
    codeField.keyboardType = UIKeyboardTypeNumberPad;
    codeField.font = [UIFont systemFontOfSize:14];
    self.codeField = codeField;
    [codeContainer addSubview:codeField]; 
    [codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(codeContainer);
    }];
    UIButton *codeBtn = [[UIButton alloc] init];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [codeBtn setBackgroundColor:ThemeColor];
    [codeBtn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    LRViewBorderRadius(codeBtn, 10, 0, [UIColor whiteColor]);
    self.codeBtn = codeBtn;
    [codeContainer addSubview:codeBtn];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(codeContainer);
        make.height.mas_equalTo(HEIGHT(120));
        make.width.mas_equalTo(100);
    }];
    UIView *codeLine = [[UIView alloc] init];
    codeLine.backgroundColor = [UIColor lightGrayColor];
    [codeContainer addSubview:codeLine];
    [codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(codeContainer);
        make.height.mas_equalTo(0.5);
    }];
    UIView *pwdContainer = [[UIView alloc] init];
    pwdContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pwdContainer];
    [pwdContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WIDTH(80));
        make.right.equalTo(self.view).offset(-WIDTH(80));
        make.top.equalTo(codeContainer.mas_bottom).offset(HEIGHT(40));
        make.height.mas_equalTo(HEIGHT(120));
    }];
    UITextField *pwdField = [[UITextField alloc] init];
    pwdField.placeholder = @"密码（必填）";
    pwdField.font = [UIFont systemFontOfSize:14];
    pwdField.secureTextEntry = YES;
    self.pwdField = pwdField;
    [pwdContainer addSubview:pwdField];
    [pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(pwdContainer);
    }];
    UIView *pwdLine = [[UIView alloc] init];
    pwdLine.backgroundColor = [UIColor lightGrayColor];
    [pwdContainer addSubview:pwdLine];
    [pwdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(pwdContainer);
        make.height.mas_equalTo(0.5);
    }];
    UIView *surePwdContainer = [[UIView alloc] init];
    surePwdContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:surePwdContainer];
    [surePwdContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WIDTH(80));
        make.right.equalTo(self.view).offset(-WIDTH(80));
        make.top.equalTo(pwdContainer.mas_bottom).offset(HEIGHT(40));
        make.height.mas_equalTo(HEIGHT(120));
    }];
    UITextField *surePwdField = [[UITextField alloc] init];
    surePwdField.placeholder = @"确认密码（必填）";
    surePwdField.font = [UIFont systemFontOfSize:14];
    surePwdField.secureTextEntry = YES;
    self.surePwdField = surePwdField;
    [surePwdContainer addSubview:surePwdField];
    [surePwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(surePwdContainer);
    }];
    UIView *surePwdLine = [[UIView alloc] init];
    surePwdLine.backgroundColor = [UIColor lightGrayColor];
    [surePwdContainer addSubview:surePwdLine];
    [surePwdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(surePwdContainer);
        make.height.mas_equalTo(0.5);
    }];
    UIView *communityContainer = [[UIView alloc] init];
    communityContainer.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *communityTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseCommunity)];
    [communityContainer addGestureRecognizer:communityTap];
    [self.view addSubview:communityContainer];
    [communityContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WIDTH(80));
        make.right.equalTo(self.view).offset(-WIDTH(80));
        make.top.equalTo(surePwdContainer.mas_bottom).offset(HEIGHT(40));
        make.height.mas_equalTo(HEIGHT(120));
    }];
    UITextField *communityField = [[UITextField alloc] init];
    communityField.placeholder = @"选择社区（必选）";
    communityField.font = [UIFont systemFontOfSize:14];
    communityField.userInteractionEnabled = NO;
    self.commiField = communityField;
    [communityContainer addSubview:communityField];
    [communityField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(communityContainer);
    }];
    UIImageView *jtImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_right_arrow"]];
    jtImage.contentMode = UIViewContentModeScaleAspectFit;
    [communityContainer addSubview:jtImage];
    [jtImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(communityContainer).offset(-10);
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(communityContainer.mas_centerY);
    }];
    UIView *communityLine = [[UIView alloc] init];
    communityLine.backgroundColor = [UIColor lightGrayColor];
    [communityContainer addSubview:communityLine];
    [communityLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(communityContainer);
        make.height.mas_equalTo(0.5);
    }];
    UIButton *selectBtn = [[UIButton alloc] init];
    [selectBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [selectBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectChange:) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.selected = YES;
    self.selectBtn  = selectBtn;
    [self.view addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WIDTH(90));
        make.top.equalTo(communityContainer.mas_bottom).offset(10);
        make.width.height.mas_equalTo(20);
    }];
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.text = @"我已阅读并同意";
    textLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectBtn.mas_right).offset(5);
        make.centerY.equalTo(selectBtn.mas_centerY);
    }];
    UIButton *textBtn = [[UIButton alloc] init];
    textBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [textBtn setTitle:@"《用户注册协议》" forState:UIControlStateNormal];
    [textBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    [textBtn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:textBtn];
    [textBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textLabel.mas_right);
        make.centerY.equalTo(selectBtn.mas_centerY);
    }];
    
    UIButton *registerBtn = [[UIButton alloc] init];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:ThemeColor];
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    LRViewBorderRadius(registerBtn, HEIGHT(50), 0, [UIColor whiteColor]);
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WIDTH(80));
        make.right.equalTo(self.view).offset(-WIDTH(80));
        make.top.equalTo(selectBtn.mas_bottom).offset(30);
        make.height.mas_equalTo(HEIGHT(120));
    }];
    
}

- (void)selectChange:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)getCode:(UIButton *)sender{
    if (![self cheakPhoneNumber:self.phoneField.text]) {
        [self showHUDWithText:@"手机号格式不对"];
    }
    else{
        NSDictionary *params = @{@"phone":self.phoneField.text};
        [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"phoneMessage/getCode" params:params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
            if (showdata) {
                self.codeBtn.enabled = NO;
                [self.codeBtn setTitle:@"获取成功" forState:UIControlStateNormal];
                [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeRefresh:) userInfo:nil repeats:YES];
            }
        }];
    }
    
}

- (void)timeRefresh:(NSTimer *)sender{
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%ldS",self.time --] forState:UIControlStateNormal];
    if (self.time == 0) {
        [self.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        self.codeBtn.enabled = YES;
        [sender invalidate];
        sender = nil;
    }
}

- (void)chooseCommunity{
    CommuntyViewController *communityVC = [CommuntyViewController new];
    [self.navigationController pushViewController:communityVC animated:YES];
}

- (void)show{
    
}

- (void)registerAction:(UIButton *)sender{
    if (!self.selectBtn.selected) {
        [self showHUDWithText:@"请勾选用户注册协议"];
        return;
    }
    else if (!self.nameField.text || [self.nameField.text isEqualToString:@""]) {
        [self showHUDWithText:@"请输入姓名"];
        return;
    }
    else if (![self cheakPhoneNumber:self.phoneField.text]) {
        [self showHUDWithText:@"手机号格式不对"];
        return;
    }
    else if (!self.codeField.text || [self.codeField.text isEqualToString:@""]) {
        [self showHUDWithText:@"请输入验证码"];
        return;
    }
    else if (!self.pwdField.text || [self.pwdField.text isEqualToString:@""]) {
        [self showHUDWithText:@"请输入密码"];
        return;
    }
    else if (!self.surePwdField.text || [self.surePwdField.text isEqualToString:@""] || ![self.pwdField.text isEqualToString:self.surePwdField.text]) {
        [self showHUDWithText:@"两次密码不一致"];
        return;
    }
    else if (!self.commiField.text || [self.commiField.text isEqualToString:@""]) {
        [self showHUDWithText:@"请选择社区"];
        return;
    }
    else{
        NSDictionary *params = @{@"phone":self.phoneField.text,@"code":self.codeField.text};
        [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"phoneMessage/validateCode" params:params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
            if (showdata) {
                NSDictionary *reParams = @{@"idcardNo":self.IDField.text,@"username":self.nameField.text,@"cid":self.communityId,@"pwd":self.pwdField.text,@"phone":self.phoneField.text};
                [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appMain/register" params:reParams withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                    if (showdata) {
                        [self showHUDWithText:@"注册成功"];
                        [self performSelector:@selector(popOutAction) withObject:nil afterDelay:1.0];
                    }
                }];
            }
        }];
    }

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
