//
//  BaseTableVC.h
//  SuperMama
//
//  Created by macbook on 15/7/7.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableVC : UITableViewController

- (void)setNavTitle:(NSString *)title;

- (void)setBackAciton:(void(^)(id sender))block;

- (void)setleftBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withFrame:(CGRect)frame withBlock:(void(^)(id sender))block;

- (void)setRightBarButtonItem:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withFrame:(CGRect)frame withBlock:(void(^)(id sender))block;


- (void)showRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

- (void)showEmptyView:(NSString *)title;

@end
