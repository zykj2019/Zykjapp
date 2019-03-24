//
//  UIImage+MJ.h
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ND)
/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/**
 *将UIColor转换成UIImage
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 *改变图片颜色
 */
- (UIImage*)rt_tintedImageWithColor:(UIColor*)color;

-(UIImage*)getSubImage:(CGRect)rect;

+(UIImage*)imageCache:(UIView*)view;
@end
