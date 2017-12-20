//
//  AddItemsViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/17.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "AddItemsViewController.h"
#import "SelectCell.h"
@interface AddItemsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *allImage;
@property (weak, nonatomic) IBOutlet UIImageView *InvertImage;
@property (nonatomic, strong) NSArray *allData;
@property (nonatomic, strong) NSMutableArray *selectData;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation AddItemsViewController
- (NSArray *)allData{
    if (!_allData) {
        if ([self.naviTitle isEqualToString:@"选择部门"]) {
            _allData = [[NSUserDefaults standardUserDefaults] objectForKey:@"allDepartments"];
        }
        else{
            _allData = [[NSUserDefaults standardUserDefaults] objectForKey:@"allThemes"];
        }
    }
    return _allData;
}

- (NSMutableArray *)selectData{
    if (!_selectData) {
        NSArray *arr;
        if ([self.naviTitle isEqualToString:@"选择部门"]) {
            arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectDepartments"];
        }
        else{
            arr =[[NSUserDefaults standardUserDefaults] objectForKey:@"selectThemes"];
        }
        _selectData = arr.mutableCopy;
    }
    return _selectData;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        NSMutableArray *nameArr = [NSMutableArray array];
        for (NSDictionary *dic in self.selectData) {
            [nameArr addObject:dic[@"name"]];
        }
        for (NSDictionary *dic in self.allData) {
            NSMutableDictionary *Mudic = [NSMutableDictionary dictionary];
            Mudic[@"title"] = dic[@"name"];
            if ([nameArr containsObject:dic[@"name"]]) {
                Mudic[@"select"] = @(YES);
            }
            else{
                Mudic[@"select"] = @(NO);
            }
            [_dataArr addObject:Mudic];
        }
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self popOut];
    self.navigationItem.title = self.naviTitle;
    self.tableView.rowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SelectCell"];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCell" forIndexPath:indexPath];
    NSMutableDictionary *muDic = self.dataArr[indexPath.row];
    cell.titleLabel.text = muDic[@"title"];
    cell.selectImage.highlighted = [muDic[@"select"] boolValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectImage.highlighted = !cell.selectImage.highlighted;
    NSMutableDictionary *muDic = self.dataArr[indexPath.row];
    muDic[@"select"] = @(cell.selectImage.highlighted);
}

- (IBAction)downAction:(UIButton *)sender {
    [self.selectData removeAllObjects];
    for (int i = 0; i < self.dataArr.count; i ++) {
        NSMutableDictionary *Mudic = self.dataArr[i];
        if ([Mudic[@"select"] boolValue]) {
            [self.selectData addObject:self.allData[i]];
        }
    }
    if ([self.naviTitle isEqualToString:@"选择部门"]) {
        [[NSUserDefaults standardUserDefaults] setObject:self.selectData forKey:@"selectDepartments"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setObject:self.selectData forKey:@"selectThemes"];
    }
    self.block(self.selectData);
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)allSelect:(id)sender {
    self.allImage.highlighted = !self.allImage.highlighted;
    if (self.allImage.highlighted) {
        for (NSMutableDictionary *muDic in self.dataArr) {
            muDic[@"select"] = @(YES);
        }
    }
    else{
        for (NSMutableDictionary *muDic in self.dataArr) {
            muDic[@"select"] = @(NO);
        }
    }
    [self.tableView reloadData];
}
- (IBAction)InvertSelect:(id)sender {
    self.InvertImage.highlighted = !self.InvertImage.highlighted;
    for (NSMutableDictionary *muDic in self.dataArr) {
        BOOL select = [muDic[@"select"] boolValue];
        muDic[@"select"] = @(!select);
    }
    [self.tableView reloadData];
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
