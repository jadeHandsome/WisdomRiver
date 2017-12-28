//
//  CommondPic.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/24.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "CommondPic.h"
#import "ZLPickPhotoViewController.h"
#import "SDPhotoBrowser.h"
@interface CommondPic()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,SDPhotoBrowserDelegate>

@end
@implementation CommondPic
- (NSMutableArray *)allImage {
    if (!_allImage) {
        _allImage = [NSMutableArray array];
        if (!self.isShow) {
            UIImage *image = [UIImage imageNamed:@"线圈"];
            [_allImage addObject:image];
        }
        
    }
    return _allImage;
}
- (void)setImageArray {
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
//    [self.allImage addObjectsFromArray:imageArray];
    for (int i = 0; i < self.allImage.count; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        if ([self.allImage[i] isKindOfClass:[NSString class]]) {
            [imageView sd_setImageWithURL:self.allImage[i] placeholderImage:[UIImage new]];
        } else {
            imageView = [[UIImageView alloc]initWithImage:self.allImage[i]];
        }
        [self addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        imageView.tag = 100 + i;
        if (!self.isShow) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
        } else {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:tap];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
        }
        
    }
    [self replayLayout];
}
- (void)tapImageView:(UITapGestureRecognizer *)tap {
    
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    //NSLog(@"%ld",self.scrollView.subviews.count);
    browser.imageCount = self.subviews.count;
    browser.delegate = self;
    [browser show];
}
- (void)replayLayout {
    NSMutableArray *allSubview = [NSMutableArray array];
    for (UIView *sub in self.subviews) {
        if (sub != self) {
            [allSubview addObject:sub];
        }
    }
    UIView *temp = self;
    UIView *temp1 = self;
    for (int i = 0; i < allSubview.count; i ++) {
        UIView *sub = allSubview[i];
        [sub mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@((SCREEN_WIDTH - 40) / 3.0));
            make.height.equalTo(@100);
            if (self.isShow) {
                if (i == allSubview.count - 1) {
                    make.bottom.equalTo(self.mas_bottom);
                }
            }

            if (temp == self) {
                make.top.equalTo(temp.mas_top).with.offset(10);
            } else {
                make.top.equalTo(temp.mas_bottom).with.offset(10);
            }
            
            if (temp1 == self) {
                make.left.equalTo(temp1.mas_left).with.offset(10);
            } else {
                make.left.equalTo(temp1.mas_right).with.offset(10);
            }
            
        }];
        if (i % 3 == 2) {
            temp = sub;
            temp1 = self;
        } else {
            temp1 = sub;
        }
        
    }
}
- (void)imageClick:(UITapGestureRecognizer *)tap {
    if (tap.view.tag == 100) {
        //选择
        __weak typeof(self) weakSelf = self;
        ZLPickPhotoViewController *pickVC = [[ZLPickPhotoViewController alloc] initWithCompleteHandle:^(NSArray *images) {
            [weakSelf.allImage addObjectsFromArray:images];
            
            [weakSelf setImageArray];
//            [weakSelf.clickBtn setTitle:[NSString stringWithFormat:@"%ld/4",self.allImage.count] forState:UIControlStateNormal];
        }];
        pickVC.limitCount = 4;
        [self.superVC.navigationController pushViewController:pickVC animated:YES];
    } else {
        //点了照片
        [KRBaseTool showAlert:@"编辑" with_Controller:self.superVC with_titleArr:@[@"删除"] withShowType:UIAlertControllerStyleActionSheet with_Block:^(int index) {
            if (index == 0) {
                //打开相机
                [self.allImage removeObject:self.allImage[tap.view.tag - 100]];
                [self setImageArray];
            }
        }];
    }
}
#pragma -- imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    //UIImage *newImage = [self thumbnaiWithImage:image size:CGSizeMake(170, 110)];
    if (self.allImage.count == 5) {
        [self.superVC showHUDWithText:@"最多选择五张照片"];
        
    } else {
        [self.allImage addObject:image];
        [self setImageArray];
    }
    
    [self.superVC dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    //NSString *imageName = self.imagsArray[index];
    NSURL *url = [NSURL URLWithString:self.allImage[index]];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}
@end
