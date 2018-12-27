//
//  UILabel+ZYXLabel.h
//  AppFramework
//
//  Created by zyx on 2018/12/19.
//  Copyright © 2018年 gxs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (ZYXLabel)
// 居中对齐
- (NSAttributedString *)setAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace;
// 获取自定义样式label的消息
- (CGSize)szieAdaptiveWithText:(NSString *)text andTextFont:(UIFont *)font andTextMaxSzie:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
