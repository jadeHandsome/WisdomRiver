//
//  HotNewsDetailViewController.m
//  WisdomRiver
//
//  Created by 周春仕 on 2017/12/16.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "HotNewsDetailViewController.h"
#import "SelectionView.h"
@interface HotNewsDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableAttributedString *MuAttrString;
@property (nonatomic, assign) CGFloat titleFontSize;
@property (nonatomic, assign) CGFloat detailFontSize;
@property (nonatomic, assign) CGFloat contentFontSize;
@end

@implementation HotNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self popOut];
    [self setUp];
    // Do any additional setup after loading the view from its nib.
}




- (void)setUp{
    self.navigationItem.title = self.naviTitle;
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareItem)];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"font_set"] style:UIBarButtonItemStylePlain target:self action:@selector(fontItem)];
    self.navigationItem.rightBarButtonItems = @[rightItem2] ;
    self.titleLabel.text = self.dic[@"title"];
    self.typeLabel.text = self.naviTitle;
    self.currentIndex = 3;
    NSString *str1 = [self htmlEntityDecode:self.dic[@"content"]];
    NSAttributedString *str2 = [self attributedStringWithHTMLString:str1];
    self.content.attributedText = str2;
    self.MuAttrString = str2.mutableCopy;
    self.titleFontSize = 18.0;
    self.detailFontSize = 15.0;
    self.contentFontSize = 18.0;
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SIZEWIDTH, SIZEHEIGHT - navHight)];
//    [webView loadHTMLString:str1 baseURL:nil];
//    [self.view addSubview:webView];
}

//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}

//将HTML字符串转化为NSAttributedString富文本字符串
- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}


- (void)shareItem{
    //分享的标题
    NSString *textToShare = @"分享的标题。";
    //分享的图片
    UIImage *imageToShare = [UIImage imageNamed:@"312.jpg"];
    //分享的url
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancled");
            //分享 取消
        }
    };
}

- (void)fontItem{
    SelectionView *selectionView = [[SelectionView alloc] initWithDataArr:@[@"特大号字",@"大号字",@"中号字",@"小号字"] title:@"字体设置" currentIndex:self.currentIndex seleted:^(NSInteger index, NSString *selectStr) {
        self.currentIndex = index;
        [self.MuAttrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:self.contentFontSize + (3 - index) * 2] range:NSMakeRange(0,  self.MuAttrString.length - 1)];
        self.content.attributedText = self.MuAttrString;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:self.titleFontSize + (3 - index) * 2];
        self.timeLabel.font = [UIFont systemFontOfSize:self.detailFontSize + (3 - index) * 2];
        self.typeLabel.font = [UIFont systemFontOfSize:self.detailFontSize + (3 - index) * 2];
    }];
    [self.view.window addSubview:selectionView];
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
