//
//  NSObject+ND.h
//  zykjApp
//
//  Created by DeerClass on 2020/1/22.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (ND)

/**
  创建lbl

 @param name 属性名
 @param font 字体
 @param color 颜色
  @param view 加入哪个view
 */
- (void)createLblName:(NSString *)name font:(UIFont *)font color:(UIColor *)color  text:(NSString *)text inView:(UIView *)view;


/**
 创建lbl

 @param name 属性名
 @param equallyLblName 样式一样的属性名
  @param view 加入哪个view
 */
- (void)createLblName:(NSString *)name text:(NSString *)text styleEquallyLblName:(NSString *)equallyLblName inView:(UIView *)view;

/// 创建imgview
/// @param name 属性名
/// @param img img
- (void)createImgView:(NSString *)name img:(UIImage *)img inView:(UIView *)view;

@end

