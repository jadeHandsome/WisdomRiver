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
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation AddItemsViewController

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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (IBAction)downAction:(UIButton *)sender {
    
}
- (IBAction)allSelect:(id)sender {
    self.allImage.highlighted = !self.allImage.highlighted;
}
- (IBAction)InvertSelect:(id)sender {
    self.InvertImage.highlighted = !self.InvertImage.highlighted;
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
