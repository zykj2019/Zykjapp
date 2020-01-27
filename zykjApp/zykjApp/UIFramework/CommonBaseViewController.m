//
//  CommonBaseViewController.m
//  CommonLibrary
//
//  Created by Alexi Chen on 2/28/13.
//  Copyright (c) 2013 AlexiChen. All rights reserved.
//

#import "CommonBaseViewController.h"

#import "UIViewController+Layout.h"

#import "IOSDeviceConfig.h"

#import "UIView+Extension.h"

@interface CommonBaseViewController () {
     BOOL _isPortrait;
}

@end

@implementation CommonBaseViewController

- (UIView *)myContentView {
    if (_myContentView == nil) {
       _myContentView = [self addMyContentView];
        _myContentView.backgroundColor = kClearColor;
        [self.view addSubview:_myContentView];
    }
    return _myContentView;
}

- (void)setMyContentView:(UIView *)myContentView {
    _myContentView = myContentView;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self configParams];
    }
    
    return  self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self configParams];
    }
     return  self;
}

- (void)configParams
{
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (@available(iOS 13.0, *)) {
        if (viewControllerToPresent.modalPresentationStyle == UIModalPresentationPageSheet || viewControllerToPresent.modalPresentationStyle == UIModalPresentationAutomatic) {
            
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationOverFullScreen;
        }
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    
}


//- (CGFloat)topToViewMargin {
//    if ((self.customNav && self.hiddenNav) || self.edgesForExtendedLayout != UIRectEdgeNone) {
//        return [CustomNav navBarBottom];
//    }
//     return 0.0;
//}
//
//- (CGFloat)tableViewTopToViewMargin {
//    if ((self.customNav && self.hiddenNav)) {
//        return [CustomNav navBarBottom];
//    }
//    return 0.0;
//}


- (UIView *)navBottomLine {
    if ([self.navigationController isKindOfClass:[NavigationViewController class]]) {
        NavigationViewController *nav = (NavigationViewController *)self.navigationController;
        return nav.navBottomLine;
    }
    return nil;
    
}

#pragma mark -
#pragma Rotate Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.hiddenNavBottmLine && [self.navigationController isKindOfClass:[NavigationViewController class]]) {
        ((NavigationViewController *)self.navigationController).navBottomLine.hidden = YES;
    }
    if (self.customNav) {
        [self.view bringSubviewToFront:self.customNav];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.hiddenNavBottmLine && [self.navigationController isKindOfClass:[NavigationViewController class]]) {
        ((NavigationViewController *)self.navigationController).navBottomLine.hidden = NO;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self layoutOnViewWillAppear];
}

- (BOOL)sameWithIOS6
{
    return YES;
}

- (void)configContainer
{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.extendedLayoutIncludesOpaqueBars = NO;
        //        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)viewDidLoad
{
    
    if ([self.view constraints].count) {
         self.myContentView.translatesAutoresizingMaskIntoConstraints = NO;

        for (UIView *subView in self.view.subviews) {
            if (subView != self.myContentView) {
                [self.myContentView addSubview:subView];
            }

        }

        for (NSLayoutConstraint *con in self.view.constraints) {
            if (con.firstItem == self.view ) {
                NSLayoutConstraint *tcon = [NSLayoutConstraint constraintWithItem:self.myContentView attribute:con.firstAttribute relatedBy:con.relation toItem:con.secondItem attribute:con.secondAttribute multiplier:con.multiplier constant:con.constant];

                [self.myContentView addConstraint:tcon];
                [self.view removeConstraint:con];

            } else if (con.secondItem == self.view){
                NSLayoutConstraint *tcon = [NSLayoutConstraint constraintWithItem:con.firstItem attribute:con.firstAttribute relatedBy:con.relation toItem:self.myContentView attribute:con.secondAttribute multiplier:con.multiplier constant:con.constant];

                 [self.myContentView addConstraint:tcon];
                  [self.view removeConstraint:con];
            }



        }

    }
    
    [super viewDidLoad];
    
    [self configContainer];
    
    if (self.hiddenNav) {
        [self addCustomNav];
    }
    
    self.view.backgroundColor = WCVIEWCOLOR;
    
    if ([self isAutoLayout])
    {
        [self autoLayoutOwnViews];
    }
    else
    {
        if ([self hasBackgroundView])
        {
            [self addBackground];
            
            [self configBackground];
        }
        // 在此外添加界面的各个控件
        [self addOwnViews];
        
        // 在此设置各个控件的值
        [self configOwnViews];
        
        // 对自身的控件进行设置区域
        [self layoutSubviewsFrame];
        
         [self configRequestData];
    }
}

- (BOOL)hasBackgroundView
{
    return NO;
}

- (void)addBackground
{
    _backgroundView = [[UIImageView alloc] init];
    [self.view addSubview:_backgroundView];
}

- (void)configBackground
{
    IOSDeviceConfig *ios = [IOSDeviceConfig sharedConfig];
    if (ios.isIPhone5)
    {
//        UIImage *bg = UIImageNamed(kAppBgImg);
//        _backgroundView.image = bg;
    }
    else
    {
        _backgroundView.backgroundColor = [UIColor flatWhiteColor];
    }
}

- (void)addCustomNav {
    
    self.customNav = [[CustomNav alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    [self.view addSubview:self.customNav];
    
    NSArray *leftBarItems = self.navigationItem.leftBarButtonItems;
    self.customNav.leftBarButtonItems = leftBarItems;
    //防止view被移除
    self.navigationItem.leftBarButtonItems = nil;
    
    UIView *titleView = self.navigationItem.titleView;
    self.customNav.titleView = titleView;
    self.navigationItem.titleView = nil;
    
    NSArray *rightBarItems = self.navigationItem.rightBarButtonItems;
    self.customNav.rightBarButtonItems = rightBarItems;
    self.navigationItem.rightBarButtonItems = nil;
}

///
- (UIView *)addMyContentView {
    return [[UIView alloc] initWithFrame:self.view.bounds];
}

//透明nav
- (void)navIsTransparent:(BOOL)isTransparent {
    self.hiddenNavBottmLine = YES;
//    BOOL isRootVc = self.navigationController.viewControllers.firstObject == self;
    if (isTransparent) {
        //透明
        if (@available(iOS 13.0, *)) {
//            if (isRootVc) {
//                //ios13特殊处理 不然push 底部线条会隐藏
//                [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//                [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//            } else {
//                [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//                [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//                self.navigationController.navigationBar.translucent = YES;
//            }
               [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0]];
            
        } else {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
            self.navigationController.navigationBar.translucent = YES;
        }
    } else {
        //不透明
        if (@available(iOS 13.0, *)) {
//            if (isRootVc) {
//                //ios13特殊处理 不然push 底部线条会隐藏
//                [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//                [self.navigationController.navigationBar setShadowImage:nil];
//            } else {
//                [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//                [self.navigationController.navigationBar setShadowImage:nil];
//
//                self.navigationController.navigationBar.translucent = NO;
//            }
            [self.navigationController.navigationBar lt_reset];
            
        } else {
            [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:nil];
            
            self.navigationController.navigationBar.translucent = NO;
        }
    }
}

//屏幕大小改变
- (void)changeDeviceScreenSizeHandle:(BOOL)isPortrait {
    
}

#pragma mark -
#pragma Layout Methods

- (void)layoutBackground
{
    _backgroundView.frame = self.view.bounds;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
     _myContentView.translatesAutoresizingMaskIntoConstraints = NO;
    //如果nav是自定义需要设置宽度
    if (self.customNav) {
        self.customNav.width = self.view.width;
        self.customNav.height = [CustomNav navBarBottom];
        
       
//        _myContentView.frame = CGRectMake(0, CGRectGetMaxY(self.customNav.frame), self.view.width, self.view.height - self.customNav.height);
    
        [_myContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.view).mas_offset([CustomNav navBarBottom]);
            make.left.bottom.right.mas_equalTo(self.view);
        }];
        
    } else {
        [_myContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(self.view);
        }];
//         _myContentView.frame = self.view.bounds;
    }
    
    BOOL isPortrait = UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) ||  (ScreenWidth < ScreenHeight);
    if (_isPortrait != isPortrait)  {
        _isPortrait = isPortrait;
        [self changeDeviceScreenSizeHandle:_isPortrait];
    }

    
//    NSLog(@"%@",NSStringFromCGRect(self.tContentView.frame));
}

//- (void)viewDidLayoutSubviews {
//   NSLog(@"%@",NSStringFromCGRect(self.tContentView.frame));
//}
- (void)layoutSubviewsFrame
{
    if ([self isAutoLayout])
    {
        return;
    }
    
    if ([self hasBackgroundView])
    {
        [self layoutBackground];
    }
    [super layoutSubviewsFrame];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


@end

@implementation CommonBaseViewController (AutoLayout)

// 是否支持autoLayout
- (BOOL)isAutoLayout
{
    return NO;
}

// 添加自动布局相关的constraints
- (void)autoLayoutOwnViews
{
    // 添加自动布局相关的内容
}

//- (void)setHiddenNav:(BOOL)hiddenNav {
//    _hiddenNav = hiddenNav;
//    hiddenNav == YES ? [self addCustomNav] : [self.customNav removeFromSuperview];
//}

@end
