//
//  UIImage+ZYXImage.m
//  AppFramework
//
//  Created by zyx on 2018/12/19.
//  Copyright © 2018年 gxs. All rights reserved.
//

#import "UIImage+ZYXImage.h"

@implementation UIImage (ZYXImage)
+ (UIImage *)imageWithColor: (UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size {
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //绘制颜色区域
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [color setFill];
    [path fill];
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    CGContextSetFillColorWithColor(ctx, color.CGColor);
    //    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    //从图形上下文获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
