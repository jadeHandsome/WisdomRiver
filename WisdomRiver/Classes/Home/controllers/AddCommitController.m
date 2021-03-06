//
//  AddCommitController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/16.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "AddCommitController.h"
#import "SelectionView.h"
@interface AddCommitController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UILabel *textNum;
@property (nonatomic, strong) NSArray *typeArr;
@property (nonatomic, strong) NSArray *typeTextArr;
@property (nonatomic, assign) NSInteger selectIndex;
@end

@implementation AddCommitController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self popOut];
    self.navigationItem.title = @"诉求提交";
    self.view.backgroundColor = COLOR(245, 245, 245, 1);
    LRViewBorderRadius(self.submitBtn, 20, 0, ThemeColor);
    self.textView.delegate = self;
    [self getTypeData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getTypeData{
    [KRMainNetTool sharedKRMainNetTool].isShaBiHouTai = YES;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appGovernmentFront/appealManagementType" params:nil withModel:nil complateHandle:^(id showdata, NSString *error) {
        if (showdata) {
            self.typeArr = showdata[@"list"];
            NSMutableArray *muArr = [NSMutableArray array];
            for (NSDictionary *dic in self.typeArr) {
                NSString *text = dic[@"name"];
                [muArr addObject:text];
            }
            self.typeTextArr = muArr;
        }
    }];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 300) {
        textView.text = [textView.text substringToIndex:300];
    }
    self.textNum.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.placeholderLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.placeholderLabel.hidden = NO;
    }
}

- (IBAction)chooseType:(id)sender {
    SelectionView *selectionView = [[SelectionView alloc] initWithDataArr:self.typeTextArr title:@"请选择类型" currentIndex:0 seleted:^(NSInteger index, NSString *selectStr) {
        self.typeLabel.text = selectStr;
        self.selectIndex = index;
    }];
    [self.view.window addSubview:selectionView];
}
- (IBAction)submit:(UIButton *)sender {
    if (self.titleField.text.length == 0) {
        [self showHUDWithText:@"请输入标题"];
    }
    else if ([self.typeLabel.text isEqualToString:@"类型"]){
        [self showHUDWithText:@"请选择类型"];
    }
    else if (self.textView.text.length == 0) {
        [self showHUDWithText:@"请输入内容"];
    }
    else{
        NSDictionary *params = @{@"title":self.titleField.text,@"type":self.typeArr[self.selectIndex][@"id"],@"content":self.textView.text};
        [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appGovernmentFront/appealManagement" params:params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
            if (showdata) {
                [self showHUDWithText:showdata[@"mess"]];
                [self performSelector:@selector(popOutAction) withObject:nil afterDelay:1.0];
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
