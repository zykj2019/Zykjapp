//
//  BaseTableViewCell.h
//  zykjApp
//
//  Created by DeerClass on 2020/1/19.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineView.h"

@interface BaseTableViewCell : UITableViewCell {
    @protected
    MyBaseLayout *_rootLayout;
}

@property (strong, nonatomic) LineView *bottomLine;

@property (weak, nonatomic) UITableView *tableView;

//对于需要动态评估高度的UITableViewCell来说可以把布局视图暴露出来。用于高度评估和边界线处理。以及事件处理的设置。
@property(nonatomic, strong, readonly) MyBaseLayout *rootLayout;

+(instancetype)cellWithTableView:(UITableView *)tableView;

//bottom线条
- (void)addBottomLine;

///增加bottom线条并加入约束
- (void)addTBottomLine;

- (void)createRootLayout;

///要加入view的内容view
- (UIView *)myContentView;

- (void)layouts;


/// myLayouts在这里面更新
- (void)updateMyLayouts;

///  cell赋值模型 (用于高度计算)
/// @param name 赋值模型的属性名
/// @param proItem 模型数据
///@param isClearCacheHeight 是否清理模型里的缓存高度
- (void)setProName:(NSString *)name proItem:(NSObject *)proItem isClearCacheHeight:(BOOL)isClearCacheHeight;


/// cell赋值模型
/// @param name 赋值模型的属性名
/// @param proItem 模型数据
/// @param isUpdateMyLayouts 是否需要重新布局myLayouts
- (void)setModelName:(NSString *)name modelItem:(NSObject *)proItem isUpdateMyLayouts:(BOOL)isUpdateMyLayouts;


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


/// 创建imgview
/// @param name 属性名
/// @param img img
- (void)createImgView:(NSString *)name img:(UIImage *)img;

@end


/// <#Description#>
@interface BaseHLinearTableViewCell : BaseTableViewCell

@end


@interface BaseVLinearTableViewCell : BaseTableViewCell

@end

@interface BaseRelativeTableViewCell : BaseTableViewCell

@end


