//
//  TestViewController.m
//  zykjApp
//
//  Created by DeerClass on 2020/1/21.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return YES;
}
// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)configParams {
    self.hiddenNav = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)addOwnViews {
    [super addOwnViews];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self showEmptyView:@"房贷废了肯定就付了定金付了定金付了定金付了定金付了定金付了定金付了定金了发的垃圾分类等级分类的会计法律的街坊邻居" emptyImage:[UIImage imageNamed:@"empty_img1"] contentInset:UIEdgeInsetsMake(0, 0, 0, 0) resetRequestBlock:^{
        
    }];
}
@end
