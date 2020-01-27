//
//  UIViewController+ND.m
//  ZykjAppWork
//
//  Created by zoulixiang on 2018/7/19.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "UIViewController+ND.h"
#import "UILabel+ND.h"
#import "BaseEmptyView.h"

static NSString *const kHiddenNav = @"kHiddenNav";
static NSString *const kOnlyHiddenNav = @"kOnlyHiddenNav";
static NSString *const kCustomNav = @"kCustomNav";
static NSString *const kNavLbl = @"kNavLbl";
@implementation UIViewController (ND)
#pragma mark - nav

- (UIView *)myContentView {
    return self.view;
}

- (void)setMyContentView:(UIView *)myContentView {
    
}

- (UILabel *)navLbl {
    UILabel *t_lable = objc_getAssociatedObject(self, (__bridge const void *)kNavLbl);
    if (!t_lable) {
        t_lable = [UILabel navLbl];
         [t_lable setAdjustsFontSizeToFitWidth:YES];
        objc_setAssociatedObject(self, (__bridge const void *)kNavLbl, t_lable, OBJC_ASSOCIATION_RETAIN);
    }
    
    return t_lable;
}

- (void)setNavLbl:(UILabel *)navLbl {
    objc_setAssociatedObject(self, (__bridge const void *)kNavLbl, navLbl, OBJC_ASSOCIATION_RETAIN);
}

- (UIButton *)getBarButton:(UIColor *)textColor {
    
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.backgroundColor = [UIColor clearColor];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    //[button.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:15]];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:kHighlightedColor forState:UIControlStateHighlighted];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [button setBackgroundColor:[UIColor clearColor]];
    return button;
}

- (void)setNavTitle:(NSString *)title{
    
    [self setNavTitle:title withColor:NAV_TEXT_COLOR];
}

- (void)setNavTitle:(NSString *)title withColor:(UIColor *)color
{
    UILabel *t_lable = [self navLbl];
    [t_lable setText:title];
    [t_lable setTextColor:color];
    
    //self.navigationItem.titleView 会把view给移除在添加
    if (self.hiddenNav && self.customNav) {
        self.customNav.titleView = t_lable;
    } else {
        self.navigationItem.titleView = t_lable;
    }
   
    
}

- (void)setHiddenNav:(BOOL)hiddenNav {
    objc_setAssociatedObject(self, (__bridge const void *)kHiddenNav, [NSNumber numberWithBool:hiddenNav], OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)hiddenNav {
    NSNumber *num = objc_getAssociatedObject(self, (__bridge const void *)kHiddenNav);
    return [num boolValue];
}

/// 仅仅隐藏系统nav 为了跟hiddenNav防止冲突
/// @param onlyHiddenNav 是否隐藏系统nav
- (void)setOnlyHiddenNav:(BOOL)onlyHiddenNav {
    objc_setAssociatedObject(self, (__bridge const void *)kOnlyHiddenNav, [NSNumber numberWithBool:onlyHiddenNav], OBJC_ASSOCIATION_RETAIN);
}
- (BOOL)onlyHiddenNav {
    NSNumber *num = objc_getAssociatedObject(self, (__bridge const void *)kOnlyHiddenNav);
    return [num boolValue];
}

- (CustomNav *)customNav {
    return  objc_getAssociatedObject(self, (__bridge const void *)kCustomNav);
}
- (void)setCustomNav:(CustomNav *)customNav {
    objc_setAssociatedObject(self, (__bridge const void *)kCustomNav, customNav, OBJC_ASSOCIATION_RETAIN);
}

- (void)showLoading:(NSString *)message {
    [self showLoading:message inView:self.view];
}

- (void)showLoading:(NSString *)message inView:(UIView *)view {
     [[HUDHelper sharedInstance] syncLoading:message inView:view];
}

- (void)setNavTitleView:(UIView *)view {
   self.navigationItem.titleView = view;
}

- (void)setBackAciton:(void(^)(id sender))block{
    [self setBackAciton:block NormalImage:kIconRetun SelectedImage:kIconRetun];
    
}

- (void)setBackAciton:(void(^)(id sender))block NormalImage:(UIImage *)normalImg SelectedImage:(UIImage *)selectedImage {
    
    WS(ws);
    __block CommonBlock tblock = block;
    CommonBlock blocks = ^(id sender){
        if ([ws respondsToSelector:@selector(returnHandle)]) {
            [ws returnHandle];
        }
        if (tblock) {
            tblock(sender);
        }
    };
    
    UIButton *leftButton = [self setleftBarButtonItem:normalImg withSelectedImage:selectedImage withFrame:Appconfig.navBackFrame withBlock:blocks];
    leftButton.tag = kIconReturnTag;

}

- (UIButton *)setleftBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withBlock:(void(^)(id sender))block {
    return [self setleftBarButtonItem:image withSelectedImage:selectedImage withFrame:CGRectNull withBlock:block];
}


- (UIButton *)setleftBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withFrame:(CGRect)frame withBlock:(void(^)(id sender))block{
    
    UIButton *leftButton = [self getBarButton:BTN_TEXT_COLOR];
    //    leftButton.backgroundColor = kRedColor;
    
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton setImage:selectedImage forState:UIControlStateHighlighted];
    [leftButton handleControlEvent:UIControlEventTouchUpInside withBlock:block];
    
    if (!CGRectEqualToRect(frame, CGRectNull)) {
        UIEdgeInsets imgInsets = UIEdgeInsetsMake(0, -((frame.size.width - image.size.width) / 2.0), 0, (frame.size.width - image.size.width) / 2.0);
        leftButton.imageEdgeInsets = imgInsets;
        [leftButton setFrame:frame];
    } else {
        [leftButton sizeToFit];
    }

    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [self configLeftBarItems:@[leftButtonItem]];
    return leftButton;
}

- (void)setRightBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withFrame:(CGRect)frame withBlock:(void(^)(id sender))block{
    
    UIButton *rightButton = [self getBarButton:BTN_TEXT_COLOR];
    
    [rightButton setFrame:frame];
    
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton setImage:selectedImage forState:UIControlStateHighlighted];
    
    [rightButton handleControlEvent:UIControlEventTouchUpInside withBlock:block];
    
    if (!CGRectEqualToRect(frame, CGRectNull)) {
        UIEdgeInsets imgInsets = UIEdgeInsetsMake(0, ((frame.size.width - image.size.width) / 2.0), 0, -((frame.size.width - image.size.width) / 2.0));
        rightButton.imageEdgeInsets = imgInsets;
        [rightButton setFrame:frame];
    } else {
        [rightButton sizeToFit];
    }
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

      [self configRightBarItems:@[rightButtonItem]];
}

- (void)setRightBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withBlock:(void(^)(id sender))block {
    [self setRightBarButtonItem:image withSelectedImage:selectedImage withFrame:CGRectNull withBlock:block];
}

- (void)setLeftBarView:(NSArray *)views {
      NSMutableArray *barItems = @[].mutableCopy;
    for (int i = 0; i < views.count; i++) {
        UIView *view = views[i];
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        [barItems addObject:rightButtonItem];
        if (i != (views.count - 1) && !IsIOS11Later && !self.hiddenNav) {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer.width = 14.0;
            [barItems addObject:negativeSpacer];
        }
    }
    
    [self configLeftBarItems:barItems];
}

- (void)setRightBarView:(NSArray *)views {
    NSMutableArray *barItems = @[].mutableCopy;
    for (int i = 0; i < views.count; i++) {
        UIView *view = views[i];
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        [barItems addObject:rightButtonItem];
        if (i != (views.count - 1) && !IsIOS11Later && !self.hiddenNav) {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer.width = 14.0;
            [barItems addObject:negativeSpacer];
        }
    }
//    [self.navigationItem setRightBarButtonItems:barItems animated:NO];
    [self configRightBarItems:barItems];
}

- (void)setRightBarButtonTitle:(NSString *)title  withFrame:(CGRect)frame withBlock:(void(^)(id sender))block{
    UIButton *rightButton = [self getBarButton:BTN_TEXT_COLOR];
    
    [rightButton setFrame:frame];
    
    [rightButton setTitle:title  forState:UIControlStateNormal];
    [rightButton setTitle:title forState:UIControlStateHighlighted];
    [rightButton handleControlEvent:UIControlEventTouchUpInside withBlock:block];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:rightButtonItem, nil] animated:NO];
     [self configRightBarItems:@[rightButtonItem]];
}

- (void)showLeftBarButtonItemWithTitle:(NSString *)title withBlock:(void(^)(id sender))block {
    [self showLeftBarButtonItemWithTitle:title btnColor:BTN_TEXT_COLOR showAnimated:NO withBlock:block];
}

- (void)showLeftBarButtonItemWithTitle:(NSString *)title btnColor:(UIColor *)color showAnimated:(BOOL)showAnimated withBlock:(void(^)(id sender))block {
    UIButton *button= [self getBarButton:color];
    [button setTitle:title forState:UIControlStateNormal];
    [button sizeToFit];
    [button handleControlEvent:UIControlEventTouchUpInside withBlock:block];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self configLeftBarItems:@[rightButtonItem]];
}

- (void)showRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    [self showRightBarButtonItemWithTitle:title btnColor:BTN_TEXT_COLOR target:target action:action];
}

- (void)showRightBarButtonItemWithTitle:(NSString *)title btnColor:(UIColor *)color target:(id)target action:(SEL)action {
    
    UIButton *button= [self getBarButton:color];
    [button setTitle:title forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//  [button handleControlEvent:UIControlEventTouchUpInside withBlock:blocks];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
     [self configRightBarItems:@[rightButtonItem]];
}

- (void)showRightBarButtonItemWithTitle:(NSString *)title withBlock:(void(^)(id sender))block {
    [self showRightBarButtonItemWithTitle:title btnColor:BTN_TEXT_COLOR showAnimated:NO withBlock:block];
}

- (void)showRightBarButtonItemWithTitle:(NSString *)title btnColor:(UIColor *)color showAnimated:(BOOL)showAnimated withBlock:(void(^)(id sender))block {
    WS(ws);
    __block CommonBlock tblock = block;
    CommonBlock blocks = ^(id sender){
        [ws.view endEditing:YES];
        if (tblock) {
            tblock(sender);
        }
    };
    
    UIButton *button= [self getBarButton:color];
    [button setTitle:title forState:UIControlStateNormal];
    [button sizeToFit];
    [button handleControlEvent:UIControlEventTouchUpInside withBlock:blocks];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self configRightBarItems:@[rightButtonItem] animated:showAnimated];
}

- (UIView *)showEmptyView:(NSString *)title resetRequestBlock:(CommonVoidBlock)resetRequestBlock {
   return [self showEmptyView:title emptyImage:nil contentInset:UIEdgeInsetsZero resetRequestBlock:resetRequestBlock];
}

- (UIView *)showEmptyView:(NSString *)title emptyImage:(UIImage *)emptyImage contentInset:(UIEdgeInsets)contentInset resetRequestBlock:(CommonVoidBlock)resetRequestBlock {
    [self removeEmptyView];
    BaseEmptyItem *baseEmptyItem = [[BaseEmptyItem alloc] initWithTitle:title emptyImage:emptyImage resetRequestBlock:resetRequestBlock];
    BaseEmptyView *empImgView = [BaseEmptyView initWithBaseEmptyItem:baseEmptyItem];
    [self.myContentView addSubview:empImgView];
    [empImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.myContentView).with.insets(contentInset).priorityHigh();
    }];
    return empImgView;
}

- (void)removeEmptyView
{
    UIView *empImgView = (UIView *)[self.myContentView viewWithTag:EMPTYVIEWTAG];
    [empImgView removeFromSuperview];
}

#pragma mark - private
- (void)returnHandle {
    
}

- (void)configLeftBarItems:(NSArray *)array {
    //
    [self configLeftBarItems:array animated:NO];
    
}

- (void)configLeftBarItems:(NSArray *)array animated:(BOOL)animated {
    if (self.hiddenNav && self.customNav) {
        self.customNav.leftBarButtonItems = array;
    } else {
        array = array.count ? array : @[[self emptyBarButtonItem]];
        [self.navigationItem setLeftBarButtonItems:array animated:animated];
    }
}

- (void)configRightBarItems:(NSArray *)array {
    
    [self configRightBarItems:array animated:NO];
    
}

- (void)configRightBarItems:(NSArray *)array animated:(BOOL)animated{
    
    
    if (self.hiddenNav && self.customNav) {
        self.customNav.rightBarButtonItems = array;
    } else {
        array = array.count ? array : @[[self emptyBarButtonItem]];
        [self.navigationItem setRightBarButtonItems:array animated:animated];
    }
    
}

- (UIBarButtonItem *)emptyBarButtonItem {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}
@end
