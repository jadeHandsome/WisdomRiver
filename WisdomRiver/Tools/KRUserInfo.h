//
//  KRUserInfo.h
//  Dntrench
//
//  Created by kupurui on 16/10/18.
//  Copyright © 2016年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface KRUserInfo : NSObject
singleton_interface(KRUserInfo)
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *sex;//性别id
@property (nonatomic, strong) NSString *phone;//联系电话
@property (nonatomic, strong) NSNumber *sort;//排序
@property (nonatomic, strong) NSString *userid;//最后操作人id
@property (nonatomic, strong) NSString *maritalStatus;//婚姻状况
@property (nonatomic, strong) NSString *type;//职位id
@property (nonatomic, strong) NSString *date;//最后操作时间
@property (nonatomic, strong) NSString *smindexUrl;
@property (nonatomic, strong) NSString *username;//用户名
@property (nonatomic, strong) NSString *name;//真实姓名
@property (nonatomic, strong) NSString *card;//身份证
@property (nonatomic, strong) NSString *isreg;//是否前台注册
@property (nonatomic, strong) NSString *note;//备注
@property (nonatomic, strong) NSString *attruser;
@property (nonatomic, strong) NSString *nickname;//昵称
@property (nonatomic, assign) BOOL status;//true表示删除
@property (nonatomic, strong) NSString *pid;//用户部门
@property (nonatomic, strong) NSString *code;//代码
@property (nonatomic, strong) NSString *oaindexUrl;
@property (nonatomic, strong) NSString *pwd;//密码
@property (nonatomic, strong) NSString *email;//邮箱
@property (nonatomic, assign) BOOL userstatus;//用户状态 true表示锁定
@property (nonatomic, strong) NSString *address;//地址
@property (nonatomic, strong) NSString *attrpwd;
@property (nonatomic, strong) NSString *micon;//图片
@property (nonatomic, strong) NSString *indexUrl;//后台首页链接


@property (nonatomic, assign) BOOL show;//开关
@end
