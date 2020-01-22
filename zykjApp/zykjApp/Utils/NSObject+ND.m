//
//  NSObject+ND.m
//  zykjApp
//
//  Created by DeerClass on 2020/1/22.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "NSObject+ND.h"

@implementation NSObject (ND)

/**
  创建lbl

 @param name 属性名
 @param font 字体
 @param color 颜色
  @param view 加入哪个view
 */
- (void)createLblName:(NSString *)name font:(UIFont *)font color:(UIColor *)color  text:(NSString *)text inView:(UIView *)view {

    UILabel *lbl = [[UILabel alloc] init];
    [view addSubview:lbl];
    [self setValue:lbl forKey:name];
    
    lbl.font = font;
    lbl.textColor = color;
    lbl.text = text;
}

/**
 创建lbl

 @param name 属性名
 @param equallyLblName 样式一样的属性名
  @param view 加入哪个view
 */
- (void)createLblName:(NSString *)name text:(NSString *)text styleEquallyLblName:(NSString *)equallyLblName inView:(UIView *)view {
    
    UILabel *lbl = [[UILabel alloc] init];
    [view addSubview:lbl];
    [self setValue:lbl forKey:name];
    
    UILabel *tlbl = [self valueForKey:equallyLblName];
    lbl.font = tlbl.font;
    lbl.textColor = tlbl.textColor;
    lbl.text = text;
}

/// 创建imgview
/// @param name 属性名
/// @param img img
- (void)createImgView:(NSString *)name img:(UIImage *)img inView:(UIView *)view {
    UIImageView *imgView = [[UIImageView alloc] init];
    [view addSubview:imgView];
    [self setValue:imgView forKey:name];
    
    imgView.image = img;
}
@end
