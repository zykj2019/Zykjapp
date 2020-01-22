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


