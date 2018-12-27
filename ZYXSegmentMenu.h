//
//  ZYXSegmentMenu.h
//  MrStock
//
//  Created by LStrong on 2018/11/2.
//  Copyright © 2018年 Mr.Stock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZYXSegmentMenuDelegate <NSObject>

@optional
- (void)menuDidClicked:(NSInteger)index;

@end

@interface ZYXSegmentMenu : UIView

/** 选中menu颜色*/
@property (strong, nonatomic) UIColor *selectColor;
/** 未选中menu颜色*/
@property (strong, nonatomic) UIColor *nomalColor;
/** menu底部线条颜色*/
@property (strong, nonatomic) UIColor *bottomLineColor;
/** menu选中底部的线条颜色*/
@property (strong, nonatomic) UIColor *seletedLineColor;
/** 菜单背景颜色*/
@property (strong, nonatomic) UIColor *menuBackgroundColor;
/** 菜单字体颜色*/
@property (strong, nonatomic) UIFont *titleFont;

/** 是否需要在点击按钮的时候让视图自动计算偏移 默认为NO*/
@property (assign, nonatomic) BOOL isNotNeedScrollView;

@property (assign, nonatomic) id<ZYXSegmentMenuDelegate> delegate;


- (instancetype)initWithTiles:(NSArray *)titles btnWidth:(CGFloat)btnWidth;
- (void)updateView:(NSArray *)titles;

@end


NS_ASSUME_NONNULL_END
