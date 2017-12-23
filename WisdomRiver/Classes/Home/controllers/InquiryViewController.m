//
//  InquiryViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "InquiryViewController.h"

@interface InquiryViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *placehorderLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIView *dateContainer;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) NSString *dateStr;

@end

@implementation InquiryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self popOut];
    self.navigationItem.title = @"申请代办";
    self.view.backgroundColor = COLOR(245, 245, 245, 1);
    LRViewBorderRadius(self.submitBtn, 20, 0, [UIColor whiteColor]);
    self.phoneField.text = [KRUserInfo sharedKRUserInfo].phone;
    self.nameLabel.text = [KRUserInfo sharedKRUserInfo].name;
    self.textView.delegate = self;
    NSDate *theDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm";
    self.dateStr = [dateFormatter stringFromDate:theDate];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)selectTime:(id)sender {
    self.dateContainer.hidden = NO;
}
- (IBAction)submitAction:(id)sender {
    if (![self cheakPhoneNumber:self.phoneField.text]) {
        [self showHUDWithText:@"手机号格式不对"];
    }
    else if (!self.timeLabel.text || [self.timeLabel.text isEqualToString:@""]){
        [self showHUDWithText:@"请选择时间"];
    }
    else if (!self.textView.text || [self.textView.text isEqualToString:@""]){
        [self showHUDWithText:@"请输入备注"];
    }
    else if (!self.addressField.text || [self.addressField.text isEqualToString:@""]){
        [self showHUDWithText:@"请输入地址"];
    }
    else{
        NSDictionary *params = @{@"id":self.dic[@"id"],@"auditPickupDate":self.timeLabel.text,@"auditPickupMap":self.addressField.text,@"note":self.textView.text};
        [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"appGovernmentFront/serviceDaiban" params:params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
            if (showdata) {
                [self showHUDWithText:@"申请成功"];
                [self performSelector:@selector(popOutAction) withObject:nil afterDelay:1.0];
            }
        }];
    }
}
- (IBAction)cancelDate:(id)sender {
    self.dateContainer.hidden = YES;
}
- (IBAction)sureDate:(id)sender {
    self.dateContainer.hidden = YES;
    self.timeLabel.text = self.dateStr;
}
- (IBAction)dateChange:(UIDatePicker *)sender {
    NSDate *theDate = _datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm";
    self.dateStr = [dateFormatter stringFromDate:theDate];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 300) {
        textView.text = [textView.text substringToIndex:300];
    }
    self.limitLabel.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.placehorderLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.placehorderLabel.hidden = NO;
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
