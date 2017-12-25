//
//  CommuntyViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/25.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "CommuntyViewController.h"
#import "CommunityDetailViewController.h"
@interface CommuntyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation CommuntyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"街道选择";
    [self popOut];
    [self requestData];
    // Do any additional setup after loading the view from its nib.
}

- (void)requestData{
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appMain/getStreet" params:nil withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata) {
            self.dataArr = showdata[@"streets"];
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.dataArr[indexPath.row][@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommunityDetailViewController *detailVC = [CommunityDetailViewController new];
    detailVC.ids = self.dataArr[indexPath.row][@"id"];
    [self.navigationController pushViewController:detailVC animated:YES];
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
