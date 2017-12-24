//
//  SignUpViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/24.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "SignUpViewController.h"
#import "KRMyTextView.h"
@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) UIScrollView *mainScroll;
@property (nonatomic, strong) NSMutableDictionary *param;
@property (nonatomic, strong) KRMyTextView *textView;
@end

@implementation SignUpViewController
- (NSMutableDictionary *)param {
    if (!_param) {
        _param = [NSMutableDictionary dictionary];
    }
    return _param;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我要报名";

    [self setUp];
}
- (void)setUp {
    self.mainScroll = [[UIScrollView alloc]init];
    self.mainScroll.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainScroll];
    [self.mainScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    UIView *contans = [[UIView alloc]init];
    contans.backgroundColor = [UIColor clearColor];
    [self.mainScroll addSubview:contans];
    [contans mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainScroll);
        make.width.equalTo(self.mainScroll.mas_width);
    }];
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [contans addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contans.mas_top).with.offset(10);
        make.left.equalTo(contans.mas_left);
        make.right.equalTo(contans.mas_right);
        make.height.equalTo(@50);
    }];
    UILabel *nameLabel = [[UILabel alloc]init];
    [topView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).with.offset(10);
        make.centerY.equalTo(topView.mas_centerY);
    }];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.text = self.name;
    UIView *firstView = [[UIView alloc]init];
    firstView.backgroundColor = [UIColor whiteColor];
    [contans addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contans);
        make.top.equalTo(topView.mas_bottom).with.offset(10);
        make.height.equalTo(@100);
    }];
    UIView *temp = firstView;
    NSArray *leftArray = @[@"预约人：",@"联系电话："];
    NSArray *placeHolder = @[@"请输入预约人姓名",@"请输入联系电话"];
    for (int i = 0; i < 2; i ++) {
        UIView *inputView = [[UIView alloc]init];
        [firstView addSubview:inputView];
        [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(firstView);
            make.height.equalTo(@50);
            if (i == 0) {
                make.top.equalTo(temp.mas_top);
            } else {
                make.top.equalTo(temp.mas_bottom);
            }
            
        }];
        temp = inputView;
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
        leftLabel.textColor = LRRGBColor(140, 140, 140);
        leftLabel.font = [UIFont systemFontOfSize:14];
        leftLabel.text = leftArray[i];
        UITextField *textf = [[UITextField alloc]init];
        if (i == 0) {
            textf.text = [KRUserInfo sharedKRUserInfo].name;
        } else {
            textf.text = [KRUserInfo sharedKRUserInfo].phone;
        }
        textf.font = [UIFont systemFontOfSize:14];
        [inputView addSubview:textf];
        textf.placeholder = placeHolder[i];
        [textf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(inputView.mas_left).with.offset(10);
            make.height.equalTo(@30);
            make.centerY.equalTo(inputView.mas_centerY);
            make.right.equalTo(inputView.mas_right);
        }];
        textf.leftViewMode = UITextFieldViewModeAlways;
        textf.leftView = leftLabel;
        textf.tag = 100 + i;
        [textf addTarget:self action:@selector(textInpu:) forControlEvents:UIControlEventEditingChanged];
        
    }
    UIView *secondView = [[UIView alloc]init];
    secondView.backgroundColor = [UIColor whiteColor];
    [contans addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contans);
        make.top.equalTo(firstView.mas_bottom).with.offset(10);
        make.height.equalTo(@100);
    }];
    UIView *temp1 = secondView;
    NSArray *rightArray = @[@"紧急联系人：",@"紧急联系电话："];
    NSArray *rightPlaceHolder = @[@"紧急联系人",@"紧急联系电话"];
    for (int i = 0; i < 2; i ++) {
        UIView *inputView = [[UIView alloc]init];
        [secondView addSubview:inputView];
        [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(secondView);
            make.height.equalTo(@50);
            if (i == 0) {
                make.top.equalTo(temp1.mas_top);
            } else {
                make.top.equalTo(temp1.mas_bottom);
            }
            
        }];
        temp1 = inputView;
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
        leftLabel.textColor = LRRGBColor(140, 140, 140);
        leftLabel.font = [UIFont systemFontOfSize:14];
        leftLabel.text = rightArray[i];
        UITextField *textf = [[UITextField alloc]init];
        [inputView addSubview:textf];
        textf.placeholder = rightPlaceHolder[i];
        textf.font = [UIFont systemFontOfSize:14];
        [textf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(inputView.mas_left).with.offset(10);
            make.height.equalTo(@30);
            make.centerY.equalTo(inputView.mas_centerY);
            make.right.equalTo(inputView.mas_right);
        }];
        textf.leftViewMode = UITextFieldViewModeAlways;
        textf.leftView = leftLabel;
        textf.tag = 102 + i;
        [textf addTarget:self action:@selector(textInpu:) forControlEvents:UIControlEventEditingChanged];
    }
    UIView *thirdView = [[UIView alloc]init];
    thirdView.backgroundColor = [UIColor whiteColor];
    [contans addSubview:thirdView];
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_bottom).with.offset(10);
        make.left.right.equalTo(contans);
        make.height.equalTo(@120);
        make.bottom.equalTo(contans.mas_bottom);
    }];
    UILabel *titleLabel = [[UILabel alloc]init];
    [thirdView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(thirdView.mas_left).with.offset(10);
        make.height.equalTo(@50);
        make.top.equalTo(thirdView.mas_top);
        
    }];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = @"备注";
    UIView *lineView = [[UIView alloc]init];
    [thirdView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(thirdView);
        make.height.equalTo(@1);
        make.top.equalTo(titleLabel.mas_bottom);
    }];
    lineView.backgroundColor = LRRGBColor(246, 246, 246);
    KRMyTextView *textView = [[KRMyTextView alloc]init];
    [thirdView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(thirdView.mas_left).with.offset(10);
        make.right.equalTo(thirdView.mas_right).with.offset(-10);
        make.top.equalTo(lineView.mas_bottom).with.offset(5);
        make.bottom.equalTo(thirdView.mas_bottom).with.offset(5);
    }];
    _textView = textView;
    textView.myPlaceholder = @"请填写备注信息";
    
}
- (void)textInpu:(UITextField *)input {
    switch (input.tag) {
        case 100:
        {
            
        }
            break;
        case 101:
        {
            
        }
            break;
        case 102:
        {
            self.param[@"emergencyContact"] = input.text;
        }
            break;
        case 103:
        {
            self.param[@"emergencyPhone"] = input.text;
        }
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancleClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)aplyeClick:(id)sender {
    if (self.textView.text.length > 0) {
        self.param[@"note"] = self.textView.text;
    }
    self.param[@"id"] = self.ID;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appPublicService/YYBMPublicService" params:self.param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        [self showHUDWithText:@"操作成功"];
        [self.navigationController popViewControllerAnimated:YES];
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
