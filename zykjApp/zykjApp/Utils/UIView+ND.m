//
//  UIView+GACommon.m
//  zykjApp
//
//  Created by zoulixiang on 2018/3/31.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "UIView+ND.h"
#import "LineView.h"

static NSString *const kBottomLine = @"kBottomLine";
static NSString *const kTopLine = @"kTopLine";

@implementation UIView (ND)

- (void)setTbottomLine:(LineView *)tbottomLine {
      objc_setAssociatedObject(self, (__bridge const void *)kBottomLine, tbottomLine, OBJC_ASSOCIATION_RETAIN);
}

- (LineView *)tbottomLine {
    return  objc_getAssociatedObject(self, (__bridge const void *)kBottomLine);
}

- (void)setTtopLine:(LineView *)ttopLine {
    objc_setAssociatedObject(self, (__bridge const void *)kTopLine, ttopLine, OBJC_ASSOCIATION_RETAIN);
}

- (LineView *)ttopLine {
    return objc_getAssociatedObject(self, (__bridge const void *)kTopLine);
}

- (void)addRoundBorder{
    CAShapeLayer *aCircle = [CAShapeLayer layer];
    aCircle.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.frame.size.height/2].CGPath;
    aCircle.fillColor = [UIColor blackColor].CGColor;
    self.layer.mask = aCircle;
}

+ (CGFloat)showHeight {
    return 0.0;
}

- (CGFloat)showHeight {
    return 0.0;
}

- (void)huggingPriority:(UILayoutConstraintAxis)layoutConstraintAxis {
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired
                                          forAxis:layoutConstraintAxis];
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:layoutConstraintAxis];
}

- (void)removeHuggingPriority:(UILayoutConstraintAxis)layoutConstraintAxis {
    [self setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                          forAxis:layoutConstraintAxis];
    [self setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:layoutConstraintAxis];
}

//增加bottom线条并加入约束
- (void)addTBottomLine {
    WS(ws);
    LineView *line = [[LineView alloc] init];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(ws);
        make.height.mas_equalTo(BottomLineHeight);
    }];
     [self setTbottomLine:line];
}

//增加深色bottom线条并加入约束
- (void)addDarkTBottomLine {
    WS(ws);
    LineView *line = [[LineView alloc] init];
    line.backgroundColor = WCLINECOLOR1;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(ws);
        make.height.mas_equalTo(BottomLineHeight);
    }];
    [self setTbottomLine:line];
}

//增加top线条并加入约束
- (void)addTTopLine {
    WS(ws);
    LineView *line = [[LineView alloc] init];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(ws);
        make.height.mas_equalTo(BottomLineHeight);
    }];
    [self setTtopLine:line];
}

//增加深色top线条并加入约束
- (void)addDarkTTopLine {
    WS(ws);
    LineView *line = [[LineView alloc] init];
    line.backgroundColor = WCLINECOLOR1;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(ws);
        make.height.mas_equalTo(BottomLineHeight);
    }];
    [self setTtopLine:line];
}

//增加阴影
- (void)addCommonShadow {
    self.layer.shadowColor = RGBA(0, 0, 0, 1.0).CGColor;
    self.layer.shadowOffset = CGSizeMake(-3, 5);//width表示阴影与x的便宜量,height表示阴影与y值的偏移量
    self.layer.shadowOpacity = 0.1;//阴影透明度,默认为0则看不到阴影
    self.layer.shadowRadius = 5.0;
    self.layer.cornerRadius = 8.0;
}

- (void)createLblName:(NSString *)name font:(UIFont *)font color:(UIColor *)color  text:(NSString *)text {
    
}
@end
