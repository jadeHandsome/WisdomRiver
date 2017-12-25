//
//  CommondPic.m
//  WisdomRiver
//
//  Created by 曾洪磊 on 2017/12/24.
//  Copyright © 2017年 曾洪磊. All rights reserved.
//

#import "CommondPic.h"
@interface CommondPic()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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
        }
        
    }
    [self replayLayout];
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
        [KRBaseTool showAlert:@"选择头像" with_Controller:self.superVC with_titleArr:@[@"相机",@"相册"] withShowType:UIAlertControllerStyleActionSheet with_Block:^(int index) {
            if (index == 0) {
                //打开相机
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
                    pickerController.delegate = self;
                    pickerController.allowsEditing = YES;
                    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [weakSelf.superVC presentViewController:pickerController animated:YES completion:nil];
                }
            } else {
                //相册
                UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
                pickerController.delegate = self;
                pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                pickerController.allowsEditing = YES;
                [weakSelf.superVC presentViewController:pickerController animated:YES completion:nil];
            }
        }];
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
@end
