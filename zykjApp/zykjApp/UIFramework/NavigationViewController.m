//
//  NavigationViewController.m
//
//  Created by Alexi on 13-7-3.
//  Copyright (c) 2013年 . All rights reserved.
//

#import "NavigationViewController.h"

#import "UINavigationController+Transition.h"

#import "UIViewController+Layout.h"

@interface NavigationViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

// 用户自定义的返回事件监听
// pop的时候执行，其他时候置空不处理
// 暂时无法使用，需要调研
//@property (nonatomic, copy) CommonVoidBlock backAction;

@end

@implementation NavigationViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController])
    {
        //        self.navigationBar.tintColor = kNavBarThemeColor;
        //        self.navigationBar.barTintColor = kNavBarThemeColor;
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    return self;
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (@available(iOS 13.0, *)) {
        if (viewControllerToPresent.modalPresentationStyle == UIModalPresentationPageSheet || viewControllerToPresent.modalPresentationStyle == UIModalPresentationAutomatic) {
            
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationOverFullScreen;
        }
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    
}

- (UIView *)navBottomLine {
    if (_navBottomLine == nil) {
        _navBottomLine = [self findHairlineImageViewUnder:self.navigationBar];
        _navBottomLine.tag = 1008;
    }
    return _navBottomLine;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [self setNavigationBarAppearance];
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    
//    _navBottomLine = [self findHairlineImageViewUnder:self.navigationBar];
    
//    [self.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[ServerInfo sharedInstance].navGradientImg]];
}

#pragma mark -
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)setNavigationBarAppearance
{
    
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSForegroundColorAttributeName:kNavBarThemeColor,
                                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:16]
                                                 }];
}

//ios5.0 横竖屏
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    return [self shouldAutorotate];
//}

- (void)viewWillLayoutSubviews
{
    if (![self asChild])
    {
        [super viewWillLayoutSubviews];
    }
    else
    {
        if (CGSizeEqualToSize(self.childSize, CGSizeZero)) {
            [super viewWillLayoutSubviews];
        }
        else
        {
            CGSize size = self.childSize;
            self.view.bounds = CGRectMake(0, 0, size.width, size.height);
        }
    }
}

- (void)pushAnimation:(UIViewController *)viewController
{
    [self.view.layer addAnimation:[self pushAnimation] forKey:kCATransition];
}

- (void)popAnimation:(UIViewController *)viewController
{
    [self.view.layer addAnimation:[self popAnimation] forKey:kCATransition];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        if ([viewController isKindOfClass:[BaseViewController class]]) {
            BaseViewController *dst = (BaseViewController *)viewController;
            __weak typeof(self) weakSelf = self;
            [dst setBackAciton:^(id sender) {
                [weakSelf popViewControllerAnimated:YES];
            }];
        }
          viewController.hidesBottomBarWhenPushed = YES;
        
    } else {
          viewController.hidesBottomBarWhenPushed = NO;
    }
    
    [self pushViewController:viewController withBackTitle:nil action:nil animated:animated];
}


- (void)pushViewController:(UIViewController *)viewController withBackTitle:(NSString *)backTitle animated:(BOOL)animated
{
    [self pushViewController:viewController withBackTitle:backTitle action:nil animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController withBackTitle:(NSString *)backTitle action:(CommonVoidBlock)backAction animated:(BOOL)animated
{
    if (backTitle.length != 0 )
    {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = backTitle;
        self.topViewController.navigationItem.backBarButtonItem = backItem;
    }
    
    if (animated)
    {
        [super pushViewController:viewController animated:YES];
        return;
    }
    
    UIViewController *pushV = (UIViewController *) self.topViewController;
    if ([pushV respondsToSelector:@selector(pushAnimation:)])
    {
        [pushV performSelector:@selector(pushAnimation:) withObject:viewController];
        [super pushViewController:viewController animated:NO];
    }
    else
    {
        [super pushViewController:viewController animated:NO];
        [self pushAnimation:pushV];
    }
}

- (void)popAnimationOver
{
    [super popViewControllerAnimated:NO];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
//    if (self.backAction)
//    {
//        self.backAction();
//        return nil;
//    }
    
    if (animated)
    {
        return [super popViewControllerAnimated:YES];
    }
    
    UIViewController *popV = (UIViewController *) self.topViewController;
    if ([popV respondsToSelector:@selector(popAnimation:)])
    {
        [popV performSelector:@selector(popAnimation:) withObject:popV];
        return [super popViewControllerAnimated:NO];
    }
    else
    {
        [self popAnimation:popV];
        return [super popViewControllerAnimated:NO];
    }
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
//    self.backAction = nil;
    if (animated)
    {
        return [super popToRootViewControllerAnimated:animated];
    }
    [self.view.layer addAnimation:[self popAnimation] forKey:kCATransition];
    return [super popToRootViewControllerAnimated:NO];
}

- (void)pushViewControllerFromBottom:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:NO];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.autoreverses = NO;
    
    
    [self.view.layer addAnimation:transition forKey:kCATransition];
    
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    self.backAction = nil;
    if (!animated)
    {
        return [super popToViewController:viewController animated:animated];
    }
    
    UIViewController *popV = (UIViewController *) self.topViewController;
    if ([popV respondsToSelector:@selector(popAnimation:)])
    {
        [popV performSelector:@selector(popAnimation:) withObject:popV];
        return [super popToViewController:viewController animated:NO];
    }
    else
    {
        [self popAnimation:popV];
        return [super popToViewController:viewController animated:NO];
    }
}

- (void)layoutSubviewsFrame
{
    [super layoutSubviewsFrame];
    [self.topViewController layoutSubviewsFrame];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.presentedViewController) {
        return UIStatusBarStyleDefault;
    }
    return [self.topViewController preferredStatusBarStyle];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer{
    //判断是否为rootViewController
    if (self && self.viewControllers.count == 1) {
        return NO;
    }
    return YES;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[BaseViewController class]]) {
        BaseViewController *dst = (BaseViewController *)viewController;
        if (dst.onlyHiddenNav) {
            [self setNavigationBarHidden:YES animated:YES];
        } else {
           [self setNavigationBarHidden:dst.hiddenNav animated:YES];
        }
        
    }
        
}
@end
