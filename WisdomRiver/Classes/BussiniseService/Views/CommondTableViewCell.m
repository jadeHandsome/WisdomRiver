//
//  CommondTableViewCell.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/23.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "CommondTableViewCell.h"
#import "CommondPic.h"
#import "SDPhotoBrowser.h"
@interface CommondTableViewCell()<SDPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIView *countView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *CONTENvIEW;
@property (weak, nonatomic) IBOutlet UIView *centerImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerHeight;
@property (nonatomic, strong) NSDictionary *myData;
@end
@implementation CommondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataWith:(NSDictionary *)data {
    for (UIView *sub in self.centerImageView.subviews) {
        [sub removeFromSuperview];
    }
    self.myData = [data copy];
    if (data[@"fileName"]) {
        if ([data[@"fileName"] count] == 0) {
            self.centerHeight.constant = 0;
        } else {
            NSInteger count = [data[@"fileName"] count];
            self.centerHeight.constant = (count / 3 + (count % 3 == 0 ? 0 : 1)) * 100 ;
            UIView *temp ;
            for (int i = 0; i < [data[@"fileName"] count]; i ++) {
                UIImageView *contenImage = [[UIImageView alloc]init];
                contenImage.tag = i;
                contenImage.clipsToBounds = YES;
                contenImage.contentMode = UIViewContentModeScaleAspectFill;
                [self.centerImageView addSubview:contenImage];
                [contenImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (i % 3 == 0) {
                        make.left.equalTo(self.centerImageView);
                    } else {
                        make.left.equalTo(temp.mas_right);
                    }
                    make.width.equalTo(@((SCREEN_WIDTH - 100)/3.0));
                    make.height.equalTo(@100);
                    if (i == 0 ) {
                        make.top.equalTo(self.centerImageView);
                    }
                    else if (i % 3 == 0){
                        make.top.equalTo(temp.mas_bottom);
                    }
                    else{
                        make.top.equalTo(temp.mas_top);
                    }
                    if (i == count - 1) {
                        make.bottom.equalTo(self.centerImageView);
                    }
                }];
                [contenImage sd_setImageWithURL:[baseImage stringByAppendingString:data[@"fileName"][i][@"id"]] placeholderImage:[UIImage new]];
                temp = contenImage;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
                contenImage.userInteractionEnabled = YES;
                [contenImage addGestureRecognizer:tap];
            }
            
        }
    } else {
        self.centerHeight.constant = 0;
    }
    NSString *str = nil;
    
    if ([data[@"uid"] length] > 0) {
        str = [data[@"uid"] substringToIndex:1];
    }
    self.nameLabel.text = [NSString stringWithFormat:@"%@**",str];
    self.timeLabel.text = data[@"date"];
    self.CONTENvIEW.text = data[@"note"];
    for (UIView *sub in self.countView.subviews) {
        [sub removeFromSuperview];
    }
    NSInteger f = [data[@"evaluate"] integerValue];
    UIView *temp = self.countView;
    for (int i = 0; i < 5; i ++) {
        UIImageView *imageView = nil;
        if (f > 0) {
            imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star_y"]];
            
        } else {
            imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star_empty"]];
        }
        [self.countView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(temp.mas_left);
            } else {
                make.left.equalTo(temp.mas_right);
            }
            make.centerY.equalTo(_countView.mas_centerY);
            make.width.height.equalTo(@20);
        }];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        temp = imageView;
        f --;
    }
    
}
- (void)tapImage:(UITapGestureRecognizer *)tap {
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self.centerImageView;
    //NSLog(@"%ld",self.scrollView.subviews.count);
    browser.imageCount = [self.myData[@"fileName"] count];
    browser.delegate = self;
    [browser show];
}
#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    //NSString *imageName = self.imagsArray[index];
    NSURL *url = [NSURL URLWithString:[baseImage stringByAppendingString:self.myData[@"fileName"][index][@"id"]]];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    
    UIImageView *imageView = self.centerImageView.subviews[index];
    return imageView.image;
}
@end
