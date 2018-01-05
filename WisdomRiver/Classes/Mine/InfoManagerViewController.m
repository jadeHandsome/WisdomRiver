//
//  InfoManagerViewController.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/19.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "InfoManagerViewController.h"
#import "LoginViewController.h"
#import "BaseNaviViewController.h"
#import "NSDictionary+deletNull.h"
@interface InfoManagerViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *infoParam;
@property (nonatomic, strong) NSArray *sexArray;
@end

@implementation InfoManagerViewController

- (NSMutableDictionary *)infoParam {
    if (!_infoParam) {
        _infoParam = [NSMutableDictionary dictionary];
    }
    return _infoParam;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTab];
    [self getSec];

    self.navigationItem.title = @"个人信息";
    self.infoParam = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] mutableCopy];
    
}
- (void)loadData {
    NSArray *array = [NSArray array];
    if (self.infoParam[@"headImg"]) {
        array = @[self.infoParam[@"headImg"]];
    }
    if (self.infoParam[@"sexId"]) {
        self.infoParam[@"sex"] = self.infoParam[@"sexId"];
    }
    NSLog(@"修改前 --> %@",[KRUserInfo sharedKRUserInfo].micon);
    [[KRMainNetTool sharedKRMainNetTool]upLoadData:@"appPersonalCenter/updatePersonal" params:self.infoParam andData:array waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata) {
            self.infoParam = [[showdata[@"user"] deleteNull] mutableCopy];
            [[KRUserInfo sharedKRUserInfo] setValuesForKeysWithDictionary:[showdata[@"user"] deleteNull]];
            [[NSUserDefaults standardUserDefaults] setObject:[showdata[@"user"] deleteNull] forKey:@"userInfo"];
            for (NSDictionary *dic in self.sexArray) {
                if ([dic[@"id"] isEqualToString:self.infoParam[@"sex"]]) {
                    self.infoParam[@"sex"] = dic[@"name"];
                }
            }
            NSLog(@"修改后 --> %@",[KRUserInfo sharedKRUserInfo].micon);
            [self showHUDWithText:@"修改成功"];
            [self.tableView reloadData];
        }
        else{
            [self showHUDWithText:@"服务器异常，请稍后再试"];
        }
        
    }];
    
}
- (void)setTab {
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@100);
    }];
    bottomView.backgroundColor = LRRGBColor(240, 240, 240);
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.backgroundColor = LRRGBColor(240, 240, 240);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(bottomView.mas_top);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    UIButton *repareBtn = [[UIButton alloc]init];
    [bottomView addSubview:repareBtn];
    [repareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top);
        make.left.equalTo(bottomView.mas_left).with.offset(15);
        make.right.equalTo(bottomView.mas_right).with.offset(-15);
        make.height.equalTo(@40);
    }];
    repareBtn.backgroundColor = LRRGBColor(0, 165, 244);
    [repareBtn setTitle:@"修改" forState:UIControlStateNormal];
    [repareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *logOutBtn = [[UIButton alloc]init];
    [bottomView addSubview:logOutBtn];
    [logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.bottom.equalTo(bottomView.mas_bottom).with.offset(-10);
        make.left.equalTo(bottomView.mas_left).with.offset(15);
        make.right.equalTo(bottomView.mas_right).with.offset(-15);
        make.height.equalTo(@40);
    }];
    logOutBtn.backgroundColor = LRRGBColor(255, 0, 86);
    [logOutBtn setTitle:@"注销登录" forState:UIControlStateNormal];
    [logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    LRViewBorderRadius(logOutBtn, 20, 0, [UIColor clearColor]);
    LRViewBorderRadius(repareBtn, 20, 0, [UIColor clearColor]);
    [logOutBtn addTarget:self action:@selector(logOutClick) forControlEvents:UIControlEventTouchUpInside];
    [repareBtn addTarget:self action:@selector(repareClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)logOutClick {
    //退出登录
    [KRBaseTool showAlert:@"注销登录将会清空本地账号信息，是否注销？" with_Controller:self with_titleArr:@[@"确定"] withShowType:UIAlertControllerStyleAlert with_Block:^(int index) {
        if (index == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"logOut" object:nil];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phone"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pwd"];
            
            //    [[KRUserInfo sharedKRUserInfo] setValuesForKeysWithDictionary:showdata[@"user"]];
            LoginViewController *loginVC = [LoginViewController new];
            BaseNaviViewController *navi = [[BaseNaviViewController alloc] initWithRootViewController:loginVC];
            self.view.window.rootViewController = navi;
        }
    }];
    
}
- (void)repareClick {
    //确认修改
    [self loadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([KRUserInfo sharedKRUserInfo].card) {
        return 7;
    } else {
        return 8;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"headCell"];
        }
        for (UIView *sub in cell.subviews) {
            if ([sub isKindOfClass:[UIImageView class]]) {
                [sub removeFromSuperview];
            }
        }
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = @"头像";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        UIView *subView = [[UIView alloc]init];
//        [cell addSubview:subView];
//        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(cell.mas_right).with.offset(-30);
//            make.top.equalTo(cell.mas_top).with.offset(10);
//            make.bottom.equalTo(cell.mas_bottom).with.offset(-10);
//            make.height.with.equalTo(@30);
//            make.width.equalTo(@30);
//        }];
        UIImageView *headImageView = [[UIImageView alloc]init];
        [cell addSubview:headImageView];
        [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.mas_right).with.offset(-30);
            make.top.equalTo(cell.mas_top).with.offset(10);
            make.bottom.equalTo(cell.mas_bottom).with.offset(-10);
            make.height.with.equalTo(@50);
            make.width.equalTo(@50);
        }];
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        LRViewBorderRadius(headImageView, 25, 0, [UIColor clearColor]);
        if (self.infoParam[@"headImg"]) {
            headImageView.image = [UIImage imageWithData:self.infoParam[@"headImg"][@"data"]];
        } else {
        if ([KRUserInfo sharedKRUserInfo].micon) {
            [headImageView sd_setImageWithURL:[NSString stringWithFormat:@"http://182.151.204.201/gfile/show?id=%@",[KRUserInfo sharedKRUserInfo].micon] placeholderImage:_zhanweiImageData];
        } else {
            [headImageView sd_setImageWithURL:@"http://182.151.204.201/static/wjzhfwpt/img/headSculpture.png" placeholderImage:_zhanweiImageData];
        }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        UITableViewCell *baseCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!baseCell) {
            baseCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        baseCell.textLabel.font = [UIFont systemFontOfSize:14];
        UITextField *input = nil;
        
        BOOL has = NO;
        for (UIView *sub in baseCell.subviews) {
            if ([sub isKindOfClass:[UITextField class]]) {
                has = YES;
                input = (UITextField *)sub;
            }
        }
        
        if (!has) {
            input = [[UITextField alloc]init];
            [baseCell addSubview:input];
            [input mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(baseCell.mas_right).with.offset(-15);
                make.height.equalTo(@30);
                make.centerY.equalTo(baseCell.mas_centerY);
                make.width.equalTo(@200);
            }];
            input.font = [UIFont systemFontOfSize:14];
            input.textAlignment = NSTextAlignmentRight;
        }
        input.tag = 100 + indexPath.row;
        [input addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        if (indexPath.row == 3) {
            [input mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(baseCell.mas_right).with.offset(-30);
                make.height.equalTo(@30);
                make.centerY.equalTo(baseCell.mas_centerY);
                make.width.equalTo(@200);
            }];
        } else {
            [input mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(baseCell.mas_right).with.offset(-15);
                make.height.equalTo(@30);
                make.centerY.equalTo(baseCell.mas_centerY);
                make.width.equalTo(@200);
            }];
        }
        switch (indexPath.row) {
            case 1:
            {
                //昵称
                baseCell.accessoryType = UITableViewCellAccessoryNone;
                baseCell.textLabel.text = @"昵称";
                input.text = self.infoParam[@"nickname"];
                input.placeholder = @"输入昵称";
            }
                break;
            case 2:
            {
                //姓名
                baseCell.accessoryType = UITableViewCellAccessoryNone;
                baseCell.textLabel.text = @"姓名";
                input.text = self.infoParam[@"name"];
                input.placeholder = @"请输入姓名";
            }
                break;
            case 3:
            {
                //性别
                baseCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                baseCell.textLabel.text = @"性别";
                input.text = self.infoParam[@"sex"];
                input.placeholder = @"选择性别";
                input.userInteractionEnabled = NO;
            }
                break;
            case 4:
            {
                //邮箱
                baseCell.accessoryType = UITableViewCellAccessoryNone;
                baseCell.textLabel.text = @"邮箱";
                input.text = self.infoParam[@"email"];
                input.placeholder = @"请输入邮箱";
            }
                break;
            case 5:
            {
                if ([KRUserInfo sharedKRUserInfo].card) {
                    //手机号
                    baseCell.accessoryType = UITableViewCellAccessoryNone;
                    baseCell.textLabel.text = @"手机号";
                    input.text = @"";
                    if (self.infoParam[@"phone"]) {
                        NSString *str1 = [self.infoParam[@"phone"] substringToIndex:3];
                        NSString *str2 = [self.infoParam[@"phone"] substringFromIndex:[self.infoParam[@"phone"] length] - 4];
                        input.placeholder = [NSString stringWithFormat:@"%@****%@",str1,str2];
                    } else {
                        input.placeholder = self.infoParam[@"phone"];
                        
                    }
                    input.userInteractionEnabled = NO;
                } else {
                    //身份证
                    baseCell.accessoryType = UITableViewCellAccessoryNone;
                    baseCell.textLabel.text = @"身份证";
                    input.text = self.infoParam[@"card"];
                    input.placeholder = @"请输入身份证";
//                    input.userInteractionEnabled = NO;
                }
                
            }
                break;
            case 6:
            {
                if ([KRUserInfo sharedKRUserInfo].card) {
                    //居住地
                    baseCell.accessoryType = UITableViewCellAccessoryNone;
                    baseCell.textLabel.text = @"居住地";
                    input.text = self.infoParam[@"address"];
                    input.placeholder = @"请输入居住地";
                } else {
                    //手机号
                    baseCell.accessoryType = UITableViewCellAccessoryNone;
                    baseCell.textLabel.text = @"手机号";
                    input.text = @"";
                    if (self.infoParam[@"phone"]) {
                        NSString *str1 = [self.infoParam[@"phone"] substringToIndex:3];
                        NSString *str2 = [self.infoParam[@"phone"] substringFromIndex:[self.infoParam[@"phone"] length] - 4];
                        input.placeholder = [NSString stringWithFormat:@"%@****%@",str1,str2];
                    } else {
                        input.placeholder = self.infoParam[@"phone"];
                        
                    }
                    input.userInteractionEnabled = NO;
                }
                
            }
                break;
            case 7:
            {
                //居住地
                baseCell.accessoryType = UITableViewCellAccessoryNone;
                baseCell.textLabel.text = @"居住地";
                input.text = self.infoParam[@"address"];
                input.placeholder = @"请输入居住地";
            }
                break;
                
            default:
                break;
        }
        baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return baseCell;
    }
    
}
- (void)textChange:(UITextField *)input {
    switch (input.tag) {
        case 101:
        {
            //昵称
            self.infoParam[@"nickname"] = input.text;
            
        }
            break;
        case 102:
        {
            //姓名
            self.infoParam[@"name"] = input.text;
        }
            break;
        case 103:
        {
            //性别
            
        }
            break;
        case 104:
        {
            //邮箱
            self.infoParam[@"email"] = input.text;
        }
            break;
        case 105:
        {
            //手机号
            if (![KRUserInfo sharedKRUserInfo].card) {
                self.infoParam[@"card"] = input.text;
            }
            
        }
            break;
        case 106:
        {
            if ([KRUserInfo sharedKRUserInfo].card) {
                //居住地
                self.infoParam[@"address"] = input.text;
            }
            
        }
            break;
        case 107:
        {
            self.infoParam[@"address"] = input.text;
        }
            break;
        default:
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //头像
        __weak typeof(self) weakSelf = self;
        [KRBaseTool showAlert:@"选择头像" with_Controller:self with_titleArr:@[@"相机",@"相册"] withShowType:UIAlertControllerStyleActionSheet with_Block:^(int index) {
            if (index == 0) {
                //打开相机
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
                    pickerController.delegate = self;
                    pickerController.allowsEditing = YES;
                    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [weakSelf presentViewController:pickerController animated:YES completion:nil];
                }
            } else {
                //相册
                UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
                pickerController.delegate = self;
                pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                pickerController.allowsEditing = YES;
                [weakSelf presentViewController:pickerController animated:YES completion:nil];
            }
        }];
    }
    if (indexPath.row == 3) {
        //性别
        [KRBaseTool showAlert:@"选择性别" with_Controller:self with_titleArr:@[@"男",@"女"] withShowType:UIAlertControllerStyleAlert with_Block:^(int index) {
            if (index == 0) {
                self.infoParam[@"sex"] = @"男";
//                self.infoParam[@""]
            } else {
                self.infoParam[@"sex"] = @"女";
            }
            for (NSDictionary *dic in self.sexArray) {
                if ([dic[@"name"] isEqualToString:self.infoParam[@"sex"]]) {
                    self.infoParam[@"sexId"] = dic[@"id"];
                }
            }
            [self.tableView reloadData];
        }];
    }
}
- (void)getSec {
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:@"appPersonalCenter/getSexs" params:nil withModel:nil complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        NSLog(@"%@",showdata);
        self.sexArray = [showdata[@"sexs"] copy];
        for (NSDictionary *dic in showdata[@"sexs"]) {
            if ([dic[@"id"] isEqualToString:self.infoParam[@"sex"]]) {
                self.infoParam[@"sex"] = dic[@"name"];
            }
        }
        [self.tableView reloadData];
    }];
}
#pragma -- imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    //UIImage *newImage = [self thumbnaiWithImage:image size:CGSizeMake(170, 110)];
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    NSDictionary *imageDic = @{@"name":@"file",@"data":data};
    self.infoParam[@"headImg"] = imageDic;
    
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
