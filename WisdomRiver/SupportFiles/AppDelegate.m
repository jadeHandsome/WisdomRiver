//
//  AppDelegate.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/14.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "BaseNaviViewController.h"
#import "IQKeyboardManager.h"
#import "BaseTabbarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setIQKeyboardManager];
    [self judesFirstView];
    NSURLSessionDataTask *data = [[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:@"http://restapi.amap.com/v3/weather/weatherInfo?key=546a2a0139a40efc3a2e3f87e21f5ca7&city=101270101"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      
        NSDictionary *data1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@",data1);
    }];
    [data resume];
    // Override point for customization after application launch.
    return YES;
}

- (void)judesFirstView{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    NSString *isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
    UIViewController *firstVC = nil;
//    if ([isLogin isEqualToString:@"1"]) {
//        NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
//        [[KRUserInfo sharedKRUserInfo] setValuesForKeysWithDictionary:userInfo];
//        BaseTabbarViewController *tab = [[BaseTabbarViewController alloc] init];
//        firstVC = tab;
//    }
//    else{
        LoginViewController *loginVC = [LoginViewController new];
        BaseNaviViewController *navi = [[BaseNaviViewController alloc] initWithRootViewController:loginVC];
        firstVC = navi;
//    }
    self.window.rootViewController = firstVC;
    [self.window makeKeyAndVisible];
}

//配置键盘管理
- (void)setIQKeyboardManager{
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:20];
    
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
    
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    

    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
