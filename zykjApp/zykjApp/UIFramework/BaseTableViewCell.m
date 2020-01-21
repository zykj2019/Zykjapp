//
//  BaseTableViewCell.m
//  zykjApp
//
//  Created by DeerClass on 2020/1/19.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [self findTableView:self];
    }
    return _tableView;
}

//增加bottom线条并加入约束
- (void)addTBottomLine {
    
    [_bottomLine removeFromSuperview];
    
    LineView *bottomLine =  [[LineView alloc] init];
    [self.contentView addSubview:bottomLine];
    _bottomLine = bottomLine;
    
   
}

#pragma mark - public
/**
 创建lbl
 
 @param name 属性名
 @param font 字体
 @param color 颜色
 */
- (void)createLblName:(NSString *)name font:(UIFont *)font color:(UIColor *)color  text:(NSString *)text {
    UILabel *lbl = [[UILabel alloc] init];
    [self.contentView addSubview:lbl];
     [self setValue:lbl forKey:name];
    
    lbl.font = font;
    lbl.textColor = color;
    lbl.text = text;
   
}

/**
 创建lbl
 
 @param name 属性名
 @param equallyLblName 样式一样的属性名
 */
- (void)createLblName:(NSString *)name text:(NSString *)text styleEquallyLblName:(NSString *)equallyLblName {
    UILabel *lbl = [[UILabel alloc] init];
    [self.contentView addSubview:lbl];
    [self setValue:lbl forKey:name];
    
    UILabel *tlbl = [self valueForKey:equallyLblName];
    lbl.font = tlbl.font;
    lbl.textColor = tlbl.textColor;
    lbl.text = text;
}


#pragma mark - private
- (UITableView *)findTableView:(UIView *)view {
   
    if (view == nil) {
        return nil;
    }
    
    if ([view isKindOfClass:[UIWindow class]]) {
        return nil;
    }
    
    if ([view isKindOfClass:[UITableView class]]) {
        return (UITableView *)view;
    }
    
     return [self findTableView:view.superview];
  
}

//调整tableview右滑按钮自定义
- (void)adjuestRightSlide:(UIButton *)btn commonDict:(NSDictionary *)dict {
    NSString *key = [btn titleForState:UIControlStateNormal];
    if (key) {
        Common *common = dict[key];
        btn.titleLabel.font = common.font ? common.font : BaesFont(14.0);
        UIImage *img = common.img;
        if (img) {
            [btn setTitle:nil forState:UIControlStateNormal];
            [btn setImage:img forState:UIControlStateNormal];
        }
    } else {
        btn.titleLabel.font = BaesFont(13.0);
    }
}

#pragma mark -
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!IsIOS11Later) {
        UITableView *tableView = self.tableView;
        NSDictionary *dict = tableView.rightSlideConfig;
        if (dict) {
            for (UIView *view in self.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
                    for (UIView *subViews in view.subviews) {
                        if ([subViews isKindOfClass:[UIButton class]]) {
                            UIButton *btn = (UIButton *)subViews;
                            [self adjuestRightSlide:btn commonDict:dict];
                        }
                    }
                }
            }
        }
    }
}


@end
