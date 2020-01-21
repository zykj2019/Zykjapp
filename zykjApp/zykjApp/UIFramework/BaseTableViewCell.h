//
//  BaseTableViewCell.h
//  zykjApp
//
//  Created by DeerClass on 2020/1/19.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineView.h"

@interface BaseTableViewCell : UITableViewCell

@property (strong, nonatomic) LineView *bottomLine;

@property (weak, nonatomic) UITableView *tableView;


///增加bottom线条并加入约束
- (void)addTBottomLine;

/**
  创建lbl

 @param name 属性名
 @param font 字体
 @param color 颜色
 */
- (void)createLblName:(NSString *)name font:(UIFont *)font color:(UIColor *)color  text:(NSString *)text;


/**
 创建lbl

 @param name 属性名
 @param equallyLblName 样式一样的属性名
 */
- (void)createLblName:(NSString *)name text:(NSString *)text styleEquallyLblName:(NSString *)equallyLblName;

@end

