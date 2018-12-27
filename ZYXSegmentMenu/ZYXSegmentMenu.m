//
//  ZYXSegmentMenu.m
//  MrStock
//
//  Created by LStrong on 2018/11/2.
//  Copyright © 2018年 Mr.Stock. All rights reserved.
//

#import "ZYXSegmentMenu.h"

#define TITLE_MENU_HEIGHT 40
#define TITLE_MENU_WIDTH  70
#define DEFAULT_TAG 999
@interface ZYXSegmentMenu ()

@property (strong, nonatomic) UIScrollView *contentView;
@property (strong, nonatomic) UIView *seletedLine;
@property (strong, nonatomic) UIView *bottomLine;

@property (strong, nonatomic) NSArray *titles;
@property (assign, nonatomic) NSInteger seletedMenuIndex;

/** 按钮宽度设置，默认为0，如果没有设置，则宽度为 TITLE_MENU_WIDTH */
@property (assign, nonatomic) CGFloat btnWidth;

@end

@implementation ZYXSegmentMenu
#pragma mark - life cycle
- (instancetype)initWithTiles:(NSArray *)titles btnWidth:(CGFloat)btnWidth {
    if (self = [super init]) {
        self.titles = titles;
        self.seletedMenuIndex = 0;
        self.btnWidth = btnWidth;
        [self setupView];
        [self setupContent];
    }
    return self;
}

- (void)dealloc {
    DLog(@"%s",__func__);
}

#pragma mark - public method
// 删除或者添加了menu后更新视图
- (void)updateView:(NSArray *)titles {
    NSString *beforeSelectTitle = self.titles[self.seletedMenuIndex];
    
    self.titles = titles;
    [self setupContent];
    
    BOOL isBeforeSeletedTitleExist = NO;
    for (int i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        if ([title isEqualToString:beforeSelectTitle]) {
            isBeforeSeletedTitleExist = YES;
            self.seletedMenuIndex = i;
            break;
        }
    }
    if (!isBeforeSeletedTitleExist) {
        self.seletedMenuIndex = 0;
    }
    
    UIButton *seletedBtn = [self.contentView viewWithTag:self.seletedMenuIndex + DEFAULT_TAG];
    [self clickMenu:seletedBtn];
    
    CGFloat contentWidth = 0;
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            contentWidth += view.frame.size.width;
        }
    }
    self.contentView.contentSize = CGSizeMake(contentWidth, TITLE_MENU_HEIGHT);
}

#pragma mark - private method
- (void)setupView {
    UIScrollView *contentView = [[UIScrollView alloc] init];
    [self addSubview:contentView];
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.showsVerticalScrollIndicator = NO;
    
    contentView.backgroundColor = [UIColor whiteColor]; // 默认背景颜色
    self.contentView = contentView;
    
    UIView *bottomLine= [[UIView alloc] init];
    [self addSubview:bottomLine];
    bottomLine.backgroundColor = [UIColor clearColor];
    self.bottomLine = bottomLine;
    
    NSString *title = self.titles[0];
    UIFont *font = self.titleFont ? self.titleFont : [UIFont systemFontOfSize:16];;
    CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName : font}];
    CGFloat textWidth = textSize.width + 10;
    CGFloat btnWidth = ((self.btnWidth < TITLE_MENU_WIDTH) ? TITLE_MENU_WIDTH : self.btnWidth);
    
    UIView *selectedLine = [[UIView alloc] initWithFrame:CGRectMake((btnWidth-textWidth)/2, TITLE_MENU_HEIGHT - 2, textWidth, 2)];
    [self.contentView addSubview:selectedLine];
    selectedLine.backgroundColor = [UIColor blueColor];
    self.seletedLine = selectedLine;
}

- (void)setupContent {
    // 清空contentView
    for (UIView *subView in self.contentView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [subView removeFromSuperview];
        }
    }
    
    CGFloat contentWidth = 0;
    UIButton *beforeBtn = nil;
    for (int index = 0; index < self.titles.count; index++) {
        CGRect frame = CGRectMake(index * ((self.btnWidth < TITLE_MENU_WIDTH) ? TITLE_MENU_WIDTH : self.btnWidth), 0, ((self.btnWidth < TITLE_MENU_WIDTH) ? TITLE_MENU_WIDTH : self.btnWidth), TITLE_MENU_HEIGHT);
        
        NSString *title = self.titles[index];
        
        UIFont *font = self.titleFont ? self.titleFont : [UIFont systemFontOfSize:16];;
        CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName : font}];
        if (textSize.width > frame.size.width) {
            frame.size.width = textSize.width + 10;
        }
        if (beforeBtn) {
            frame.origin.x = beforeBtn.maxX;
        }
        
        UIButton *btn = [[UIButton alloc] initWithFrame:frame];
        btn.tag = index + DEFAULT_TAG;
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = self.titleFont ? self.titleFont : [UIFont systemFontOfSize:16];
        if (index == 0) { // 默认选中第一个
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        } else {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        [btn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
        beforeBtn = btn;
        [self.contentView addSubview:btn];
        
        contentWidth += frame.size.width;
    }
    
    self.contentView.contentSize = CGSizeMake(contentWidth, TITLE_MENU_HEIGHT);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = self.frame;
    self.bottomLine.frame = CGRectMake(0, TITLE_MENU_HEIGHT - 1, self.width, 1);
}

#pragma mark - response method
- (void)clickMenu:(UIButton *)sender {
    self.seletedMenuIndex = sender.tag - DEFAULT_TAG;
    [self resetMenuColor];
    [self setupTitleCenter:sender];
    [UIView animateWithDuration:0.2 animations:^{
        NSString *title = self.titles[self.seletedMenuIndex];
        UIFont *font = self.titleFont ? self.titleFont : [UIFont systemFontOfSize:16];;
        CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName : font}];
        CGFloat textWidth = textSize.width + 10;
        CGFloat btnWidth = sender.width;//((self.btnWidth < TITLE_MENU_WIDTH) ? TITLE_MENU_WIDTH : self.btnWidth);
        
        CGRect frame = self.seletedLine.frame;
        frame.origin.x = sender.x + (btnWidth-textWidth)/2;
        frame.size.width = textWidth;
        self.seletedLine.frame = frame;
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuDidClicked:)]) {
        [self.delegate menuDidClicked:sender.tag - DEFAULT_TAG];
    }
}

#pragma mark - 重置菜单标题颜色
- (void)resetMenuColor {
    for (UIView *subView in self.contentView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            if (btn.tag-DEFAULT_TAG == self.seletedMenuIndex) {
                if (_selectColor) {
                    [btn setTitleColor:_selectColor forState:UIControlStateNormal];
                }
            } else {
                if (_nomalColor) {
                    [btn setTitleColor:_nomalColor forState:UIControlStateNormal];
                }
            }
        }
    }
}

// 重置选中菜单的位置
- (void)setupTitleCenter:(UIButton *)button {
    if (!self.isNotNeedScrollView) {
        CGFloat offsetX = button.center.x - SCREEN_WIDTH * 0.5;
        if (offsetX < 0) {
            offsetX = 0;
        }
        CGFloat maxOffsetX = self.contentView.contentSize.width - self.contentView.width;
        if (maxOffsetX < 0) {
            maxOffsetX = 0;
        }
        if (offsetX > maxOffsetX) {
            offsetX = maxOffsetX;
        }
        
        [self.contentView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}
#pragma mark - getter and setter
- (void)setSelectColor:(UIColor *)selectColor {
    _selectColor = selectColor;
    [self resetMenuColor];
}

- (void)setNomalColor:(UIColor *)nomalColor {
    _nomalColor = nomalColor;
    [self resetMenuColor];
}

- (void)setSeletedLineColor:(UIColor *)seletedLineColor {
    _seletedLineColor = seletedLineColor;
    self.seletedLine.backgroundColor = seletedLineColor;
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    _bottomLineColor = bottomLineColor;
    self.bottomLine.backgroundColor = bottomLineColor;
}

- (void)setMenuBackgroundColor:(UIColor *)menuBackgroundColor {
    _menuBackgroundColor = menuBackgroundColor;
    self.contentView.backgroundColor = menuBackgroundColor;
    self.backgroundColor = menuBackgroundColor;
}
@end
