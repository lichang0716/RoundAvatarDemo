//
//  ViewController.m
//  RoundAvatarDemo
//
//  Created by Chang Li on 2017/9/29.
//  Copyright © 2017年 Chang Li. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
         关于圆形头像的三种表现方式：
         1.CALayer
         2.Duartz2D
         3.Storyboard/Xib Setting
     */
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100)/2, 100, 100, 100)];
//    [avatarImageView setImage:[UIImage imageNamed:@"somePic.jpg"]];
//
//    // 设置 layer 以外的区域不显示
//    avatarImageView.layer.masksToBounds = YES;
//    // 设置 layer 的圆角
//    avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.height/2;
//    // 设置 layer 边框颜色和宽度
//    avatarImageView.layer.borderWidth = 3.0;
//    avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [avatarImageView setImage:[self getRoundAvatar:[UIImage imageNamed:@"somePic.jpg"]
                                       borderWidth:3.0 
                                       borderColor:[UIColor whiteColor]]];
    
    [self.view addSubview:avatarImageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 获取圆形图片

 @param originImage 原图
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 返回圆形图片
 */
- (UIImage *)getRoundAvatar:(UIImage *)originImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    // 定义新图片的尺寸
    CGFloat bigImageWidth = originImage.size.width + 2 * borderWidth;
    CGFloat bigImageHeight = originImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(bigImageWidth, bigImageHeight);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    // 取得当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置边框颜色
    [borderColor set];
    // 设置边框
    CGFloat bigRadius = bigImageWidth / 2.0;
    CGFloat centerX = bigRadius;
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    // 设置小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerY, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪
    CGContextClip(ctx);
    // 画图
    [originImage drawInRect:CGRectMake(borderWidth, borderWidth, originImage.size.width, originImage.size.height)];
    // 获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}

@end
