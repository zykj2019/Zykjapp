//
//  CustomNav.m
//  CustomNav
//
//  Created by zoulixiang on 2018/7/22.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "CustomNav.h"
#import "sys/utsname.h"
#import "UIView+Extension.h"
#import "UIView+ND.h"
#import "LineView.h"

@implementation CustomNav

+ (CGSize)navBarSize {
    return CGSizeMake(kWRScreenWidth, [self navBarBottom]);
}
+ (int)navBarBottom {
    return 44 + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
}
+ (BOOL)isIphoneX {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) {
        // judgment by height when in simulators
        return (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) ||
                CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)));
    }
    BOOL isIPhoneX = [platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"];
    return isIPhoneX;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.backgroundColor = [UIColor colorWithPatternImage:[ServerInfo sharedInstance].navGradientImg];
        self.clipsToBounds = YES;
        self.frame = CGRectMake(0, 0, kWRScreenWidth, [CustomNav navBarBottom]);
        [self addOwnViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kNavColor;
        self.clipsToBounds = YES;
        self.height = [CustomNav navBarBottom];
        [self addOwnViews];
    }
    return self;
}

- (void)addOwnViews {
    [super addOwnViews];
    
    _leftView = [[UIView alloc] init];
    [self addSubview:_leftView];
    _leftView.backgroundColor = [UIColor clearColor];
    _leftView.clipsToBounds = YES;
    
    _middleView = [[UIView alloc] init];
    [self addSubview:_middleView];
    _middleView.backgroundColor = [UIColor clearColor];
    _middleView.clipsToBounds = YES;
    
    _rightView = [[UIView alloc] init];
    [self addSubview:_rightView];
    _rightView.backgroundColor = [UIColor clearColor];
    _rightView.clipsToBounds = YES;
    
    [self addTBottomLine];
    LineView *bottomLine = [self tbottomLine];
    bottomLine.backgroundColor = RGB(220, 220, 220);
}


- (void)setLeftBarButtonItems:(NSArray *)leftBarButtonItems {
    _leftBarButtonItems = leftBarButtonItems;
    
    [_leftView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (UIBarButtonItem *item in leftBarButtonItems) {
          UIView *view = item.customView;
        if (item.width == 0 && view) {
            [_leftView addSubview:view];
        }
       
    }
    
}

- (void)setTitleView:(UIView *)titleView {
    _titleView = titleView;
    [_middleView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_middleView addSubview:titleView];
}

- (void)setRightBarButtonItems:(NSArray *)rightBarButtonItems {
    _rightBarButtonItems = rightBarButtonItems;
     [_rightView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (UIBarButtonItem *item in rightBarButtonItems) {
         UIView *view = item.customView;
        if (item.width == 0 && view) {
            [_rightView addSubview:view];
        }
    }
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat y = HT_StatusBarHeight + 2.0;
    CGFloat centerX = self.width / 2.0;
    CGFloat height = 40.0;
    //leftView
    CGFloat leftWidth;
    CGFloat leftHeigh = 0;
    CGFloat leftSubx = 0;
    CGFloat kwrRight = kWRRight;
    CGFloat kwrLeft = kWRLeft;
    
    for (UIView *subView in _leftView.subviews) {
        subView.frame = CGRectMake(leftSubx, height / 2.0 - subView.height / 2.0, subView.width, subView.height);
        leftSubx += subView.width + objMargin;
        leftHeigh = MAX(leftHeigh, subView.height);
    }
    leftWidth = MAX(0, leftSubx - objMargin);
    _leftView.frame = CGRectMake(kwrLeft, y, leftWidth, height);
    
    //rightView
    CGFloat rightWidth;
    CGFloat rightHeigh = 0;
    CGFloat rightSubx = 0;
     CGFloat rightx = 0;
    for (UIView *subView in _rightView.subviews) {
        subView.frame = CGRectMake(rightSubx, height / 2.0 - subView.height / 2.0, subView.width, subView.height);
        rightSubx += subView.width + objMargin;
        rightHeigh = MAX(rightHeigh, subView.height);
    }
     rightWidth = MAX(0, rightSubx - objMargin);
     rightx = self.width - kwrRight - rightWidth;
     _rightView.frame = CGRectMake(rightx, y, rightWidth, height);
    
    //titleView
    CGFloat titleViewMarginLeft = self.leftBarButtonItems.count ? 3.0 : 0;
    CGFloat titleViewMarginRight = self.rightBarButtonItems.count ? 3.0 : 0;
    CGFloat middleX = CGRectGetMaxX(_leftView.frame) + titleViewMarginLeft;
    CGFloat middleWidth = self.width - (kwrLeft) - leftWidth - rightWidth - (kwrRight) - titleViewMarginLeft - titleViewMarginRight;
    
    _middleView.frame = CGRectMake(middleX, y, middleWidth, height);
    if (_titleView) {
//        _titleView.width = MIN(_titleView.width, _middleView.width);
         CGFloat titleX = centerX - middleX - _titleView.width / 2.0;
        if (titleX < 0) {
            _titleView.frame = CGRectMake(0, height / 2.0 - _titleView.height / 2.0, _titleView.width, _titleView.height);
        } else {
            _titleView.frame = CGRectMake(titleX, height / 2.0 - _titleView.height / 2.0, _titleView.width, _titleView.height);
        }
        
    }

}

- (void)elementViewAlpha:(CGFloat)alpha {
    _leftView.alpha = alpha;
    _middleView.alpha = alpha;
    _rightView.alpha = alpha;
}
- (void)layoutIfNeeded {
    [super layoutIfNeeded];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
}
@end
