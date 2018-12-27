//
//  UIButton+ZYXButton.h
//  AppFramework
//
//  Created by zyx on 2018/12/19.
//  Copyright © 2018年 gxs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ZYXButton)

// 图片在上文字在下
- (void)verticalImageUpAndTitleDown:(CGFloat)spacing;
// 图片在下文字在上
- (void)verticalTitleTopAndImageDown:(CGFloat)spacing;
// 图片在右文字在左
- (void)horizontalTitleLeftAndImageRight:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
