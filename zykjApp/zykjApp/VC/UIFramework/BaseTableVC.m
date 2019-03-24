//
//  BaseTableVC.m
//  SuperMama
//
//  Created by macbook on 15/7/7.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import "BaseTableVC.h"
#import "UIControl+Block.h"

#define TEXT_COLOR    UIColorFromRGB(0x191919)

@interface BaseTableVC (){
    UIImageView *navBarHairlineImageView;
}

@end

@implementation BaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:UIColorFromRGB(0xffffff)] forBarMetrics:UIBarMetricsDefault];
    
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - nav
#pragma mark -

- (void)setNavTitle:(NSString *)title{
    
    UILabel *t_lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    [t_lable setBackgroundColor:[UIColor clearColor]];
    [t_lable setText:title];
    [t_lable setTextAlignment:NSTextAlignmentCenter];
    [t_lable setFont:[UIFont systemFontOfSize:17.0]];
    //[t_lable setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:17]];
    [t_lable setTextColor:TEXT_COLOR];
    self.navigationItem.titleView = t_lable;
    
}

- (void)setBackAciton:(void(^)(id sender))block{
    
    [self setleftBarButtonItem:[UIImage imageNamed:@"return"] withSelectedImage:nil withFrame:CGRectMake(0, 14, 15.f, 15.f) withBlock:block];
    
}

- (void)setleftBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withFrame:(CGRect)frame withBlock:(void(^)(id sender))block{
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:frame];
    
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton setImage:selectedImage forState:UIControlStateHighlighted];
    [leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [leftButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    [leftButton handleControlEvent:UIControlEventTouchUpInside withBlock:block];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,leftButtonItem, nil] animated:NO];
}

- (void)setRightBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withFrame:(CGRect)frame withBlock:(void(^)(id sender))block{
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButton setFrame:frame];
    
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton setImage:selectedImage forState:UIControlStateHighlighted];
    [rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [rightButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [rightButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [rightButton handleControlEvent:UIControlEventTouchUpInside withBlock:block];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,rightButtonItem, nil] animated:NO];
}

- (void)setRightBarButtonTitle:(NSString *)title  withFrame:(CGRect)frame withBlock:(void(^)(id sender))block{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButton setFrame:frame];
    
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton setTitle:title  forState:UIControlStateNormal];
    [rightButton setTitle:title forState:UIControlStateHighlighted];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    //[rightButton.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:15]];
    [rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [rightButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    [rightButton handleControlEvent:UIControlEventTouchUpInside withBlock:block];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,rightButtonItem, nil] animated:NO];
}

- (void)showRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    CGRect buttonFrame = CGRectMake(0, 6.f, 40.f, 26.f);
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.backgroundColor = [UIColor clearColor];
    button.frame = buttonFrame;
    [button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    //[button.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:15]];
    [button setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,rightButtonItem, nil] animated:NO];
}


- (void)showEmptyView:(NSString *)title
{
    UIImageView *empImgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - 45, ScreenHeight / 2 - 40 - 85, 90, 80)];
    [empImgView setImage:[UIImage imageNamed:@"emptyPic"]];
    [self.view addSubview:empImgView];
    
    if (!title || !title.length)
    {
        title = @"哎呀，这个页面没有东西";
    }
    
    CGRect empImgFrame = empImgView.frame;
    CGFloat lblWidth = [IMichUtil calcLabelWidth:title fontSize:19 height:20];
    CGFloat x = (ScreenWidth - lblWidth) / 2;
    
    UILabel *empLbl = [[UILabel alloc] initWithFrame:CGRectMake(x, empImgFrame.origin.y + 90, lblWidth, 20)];
    empLbl.text = title;
    empLbl.textAlignment = NSTextAlignmentCenter;
    empLbl.textColor = [UIColor lightGrayColor];
    empLbl.numberOfLines = 1;
    [empLbl setFont:[UIFont fontWithName:@"Helvetica" size:19]];
    empLbl.userInteractionEnabled = NO;
    [self.view addSubview:empLbl];
}

@end
