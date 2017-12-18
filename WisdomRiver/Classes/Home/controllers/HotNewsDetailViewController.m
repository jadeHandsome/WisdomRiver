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
    self.navigationItem.rightBarButtonItems = @[rightItem2,rightItem1] ;
    self.titleLabel.text = self.dic[@"title"];
    self.typeLabel.text = self.naviTitle;
    NSString *str1 = [self htmlEntityDecode:self.dic[@"content"]];
    NSAttributedString *str2 = [self attributedStringWithHTMLString:str1];
    self.content.attributedText = str2;
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
    
}

- (void)fontItem{
    SelectionView *selectionView = [[SelectionView alloc] initWithDataArr:@[@"特大号字",@"大号字",@"中号字",@"小号字"] title:@"字体设置" currentIndex:self.currentIndex seleted:^(NSInteger index, NSString *selectStr) {
        self.currentIndex = index;
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
