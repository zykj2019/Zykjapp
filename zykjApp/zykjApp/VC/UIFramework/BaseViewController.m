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
    UIImageView *navBarHairlineImageView;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    
    // Do any additional setup after loading the view.
    // 0xff6e8d   0xf8f8f8
    
    //    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:UIColorFromRGB(0xffffff)] forBarMetrics:UIBarMetricsDefault];
    //
    //    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
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
    [t_lable setAdjustsFontSizeToFitWidth:YES];
    [t_lable setMinimumScaleFactor:0.5];
    self.navigationItem.titleView = t_lable;
}

- (void)setNavTitle:(NSString *)title withColor:(UIColor *)color
{
    UILabel *t_lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    [t_lable setBackgroundColor:[UIColor clearColor]];
    [t_lable setText:title];
    [t_lable setTextAlignment:NSTextAlignmentCenter];
    //[t_lable setFont:[UIFont systemFontOfSize:17.0]];
    [t_lable setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:17]];   // 华文细黑
    [t_lable setTextColor:color];
    [t_lable setAdjustsFontSizeToFitWidth:YES];
    [t_lable setMinimumScaleFactor:0.5];
    self.navigationItem.titleView = t_lable;
}

- (void)setBackAciton:(void(^)(id sender))block{
    
    [self setleftBarButtonItem:[UIImage imageNamed:@"nav_return_press"] withSelectedImage:[UIImage imageNamed:@"nav_return_press"] withFrame:CGRectMake(0, 14, 22.f, 41.f) withBlock:block];
    
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
    //[rightButton.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:15]];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [rightButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [rightButton setTitleColor: BTN_TEXT_COLOR forState:UIControlStateNormal];
    [rightButton handleControlEvent:UIControlEventTouchUpInside withBlock:block];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,rightButtonItem, nil] animated:NO];
}

- (void)showRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    CGRect buttonFrame = CGRectMake(0, 6.f, 80.f, 26.f);
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.backgroundColor = [UIColor clearColor];
    button.frame = buttonFrame;
    [button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    //[button.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:15]];
    [button setTitleColor: BTN_TEXT_COLOR forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,rightButtonItem, nil] animated:NO];
}

- (void)showEmptyView:(NSString *)title
{
    if ([self.view viewWithTag:1701]) {
        return;
    }
    UIImageView *empImgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - 45, ScreenHeight / 2 - 40 - 115 - 20, 90, 114)];
    [empImgView setImage:[UIImage imageNamed:@"com_emptyPic"]];
    empImgView.tag = 1701;
    [self.view addSubview:empImgView];
    
    if (!title || !title.length)
    {
        title = @"哎呀，这个页面没有东西";
    }
    
    CGRect empImgFrame = empImgView.frame;
    CGFloat lblWidth = [IMichUtil calcLabelWidth:title fontSize:16 height:20];
    CGFloat x = (ScreenWidth - lblWidth) / 2;
    
    UILabel *empLbl = [[UILabel alloc] initWithFrame:CGRectMake(x, empImgFrame.origin.y + 150, lblWidth, 20)];
    empLbl.text = title;
    empLbl.textAlignment = NSTextAlignmentCenter;
    empLbl.textColor = [UIColor blackColor];
    empLbl.numberOfLines = 1;
    [empLbl setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    empLbl.userInteractionEnabled = NO;
    empLbl.tag = 1702;
    [self.view addSubview:empLbl];
}

- (void)removeEmptyView
{
    UIImageView *empImgView = (UIImageView *)[self.view viewWithTag:1701];
    if (empImgView)
    {
        [empImgView removeFromSuperview];
        empImgView = nil;
    }
    
    UILabel *empLbl = (UILabel *)[self.view viewWithTag:1702];
    if (empLbl)
    {
        [empLbl removeFromSuperview];
        empLbl = nil;
    }
}

- (void)showErrorView:(NSString *)error {
    
    [TipView showTipView:error];
}

- (void)addTapBlankToHideKeyboardGesture;
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBlankToHideKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}


- (void)onTapBlankToHideKeyboard:(UITapGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateEnded)
    {
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    }
}

- (void)callImagePickerActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    actionSheet.cancelButtonIndex = 2;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    if (buttonIndex == 0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if (buttonIndex == 1 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    self.logoImageView.image = info[UIImagePickerControllerEditedImage];
    //    isHasLogo = YES;
    //    [picker dismissViewControllerAnimated:YES completion:nil];
    //    //显示在最上方
    //    [self.view bringSubviewToFront:_HUD];
}

@end
