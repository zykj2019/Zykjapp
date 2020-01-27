//
//  BaseViewController.m
//  SuperMama
//
//  Created by macbook on 15/7/7.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import "BaseViewController.h"
#import "TipView.h"


@interface BaseViewController (){
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
    
}


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

