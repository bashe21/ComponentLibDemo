//
//  UIImage+ZYXImage.h
//  AppFramework
//
//  Created by zyx on 2018/12/19.
//  Copyright © 2018年 gxs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZYXImage)
// 绘制特定颜色的图片
+ (UIImage *)imageWithColor: (UIColor *)color;
// 绘制特定颜色并且指定大小的图片
+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
