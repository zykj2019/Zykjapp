//
//  BaseViewController.m
//  SuperMama
//
//  Created by macbook on 15/7/7.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import "BaseViewController.h"
#import "TipView.h"
#import "BaseEmptyView.h"

@interface BaseViewController (){
    UIImageView *navBarHairlineImageView;
}

@end

@implementation BaseViewController

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    [self setNavTitle:title];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    // 0xff6e8d   0xf8f8f8
    
    //    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:UIColorFromRGB(0xffffff)] forBarMetrics:UIBarMetricsDefault];
    //
    //    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configRequestData {
    [super configRequestData];
    [self removeEmptyView];
}


#pragma mark - private
#pragma mark -
- (UIBarButtonItem *)emptyBarButtonItem {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}
- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

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
#pragma mark -

//转换导航栏下的rect
- (CGRect)visiblerRect:(CGRect)rect {
    
    CGFloat height = rect.size.height;
    if ((height == ScreenHeight) || (height == ScreenHeight - HT_TabbarHeight)) {
        if (self.edgesForExtendedLayout != UIRectEdgeNone) {
            rect.origin.y += HT_StatusBarAndNavigationBarHeight;
            rect.size.height -= HT_StatusBarAndNavigationBarHeight;
        }
    }
    
    return rect;
}

- (void)setNavTitleView:(UIView *)view {
    if (self.customNav && self.hiddenNav) {
        self.customNav.titleView = view;
    } else {
        self.navigationItem.titleView = view;
    }
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
    
    UIButton *leftButton = [self setleftBarButtonItem:normalImg withSelectedImage:selectedImage withFrame:CGRectMake(0, 0, 24.0, 42.0) withBlock:blocks];
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

@end

@implementation BaseRelativeViewController

- (MyRelativeLayout *)myContentView {
    return (MyRelativeLayout *)[super myContentView];
}
- (UIView *)addMyContentView {
    MyRelativeLayout *myRelativeLayout = [[MyRelativeLayout alloc] initWithFrame:self.view.bounds];
    myRelativeLayout.insetsPaddingFromSafeArea = UIRectEdgeAll;
    return myRelativeLayout;
}
@end

@implementation BaseLinearViewController

- (MyLinearLayout *)myContentView {
    return (MyLinearLayout *)[super myContentView];
}
- (UIView *)addMyContentView {
    MyLinearLayout *myLinearLayout = [[MyLinearLayout alloc] initWithFrame:self.view.bounds];
    myLinearLayout.insetsPaddingFromSafeArea = UIRectEdgeTop | UIRectEdgeBottom;
    return myLinearLayout;
}

@end

