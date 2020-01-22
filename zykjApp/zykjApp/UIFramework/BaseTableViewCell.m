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

+(instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass([self class]);
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        [self addOwnViews];
        [self configOwnViews];
        [self addConstConstraints];
    }
    return self;
}

- (void)addOwnViews {
    [super addOwnViews];
    [self createRootLayout];
    _rootLayout.backgroundColor = kClearColor;
}

#pragma mark - public

- (void)createRootLayout {
//    _rootLayout = [MyBaseLayout new];
//    _rootLayout.widthSize.equalTo(self.contentView.widthSize);
//    _rootLayout.heightSize.equalTo(self.contentView.heightSize);
//     [self.contentView addSubview:_rootLayout];
}

- (void)addBottomLine {
    UIView *rootLayout = self.myContentView;
    
    [_bottomLine removeFromSuperview];
    
    LineView *bottomLine =  [[LineView alloc] init];
    [rootLayout addSubview:bottomLine];
    _bottomLine = bottomLine;
}

//增加bottom线条并加入约束
- (void)addTBottomLine {
    
     UIView *rootLayout = self.myContentView;
    
    [_bottomLine removeFromSuperview];
    
    LineView *bottomLine =  [[LineView alloc] init];
    [rootLayout addSubview:bottomLine];
    _bottomLine = bottomLine;

    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(rootLayout);
        make.height.mas_equalTo(BottomLineHeight);
    }];
}
- (void)layouts {
    [self setNeedsUpdateConstraints];
//    [self layoutIfNeeded];
}


/**
 创建lbl
 
 @param name 属性名
 @param font 字体
 @param color 颜色
 */
- (void)createLblName:(NSString *)name font:(UIFont *)font color:(UIColor *)color  text:(NSString *)text {
     UIView *rootLayout = self.myContentView;
//    UILabel *lbl = [[UILabel alloc] init];
//    [rootLayout addSubview:lbl];
//     [self setValue:lbl forKey:name];
//
//    lbl.font = font;
//    lbl.textColor = color;
//    lbl.text = text;
    [self createLblName:name font:font color:color text:text inView:rootLayout];
   
}

/**
 创建lbl
 
 @param name 属性名
 @param equallyLblName 样式一样的属性名
 */
- (void)createLblName:(NSString *)name text:(NSString *)text styleEquallyLblName:(NSString *)equallyLblName {
     UIView *rootLayout = self.myContentView;
//    UILabel *lbl = [[UILabel alloc] init];
//    [rootLayout addSubview:lbl];
//    [self setValue:lbl forKey:name];
//
//    UILabel *tlbl = [self valueForKey:equallyLblName];
//    lbl.font = tlbl.font;
//    lbl.textColor = tlbl.textColor;
//    lbl.text = text;
    
    [self createLblName:name text:text styleEquallyLblName:equallyLblName inView:rootLayout];
}

/// 创建imgview
/// @param name 属性名
/// @param img img
- (void)createImgView:(NSString *)name img:(UIImage *)img {
     UIView *rootLayout = self.myContentView;
    [self createImgView:name img:img inView:rootLayout];
}

#pragma mark - private
- (UIView *)myContentView {
    UIView *rootLayout = self.rootLayout ? : self.contentView;
    return rootLayout;
}

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


///
@implementation BaseHLinearTableViewCell

- (MyLinearLayout *)rootLayout {
    return (MyLinearLayout *)_rootLayout;
}

- (void)createRootLayout {
    _rootLayout= [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    _rootLayout.cacheEstimatedRect = YES;
    _rootLayout.myHorzMargin = MyLayoutPos.safeAreaMargin;
    _rootLayout.myHeight = MyLayoutSize.wrap;
    [self.contentView addSubview:_rootLayout];
}

- (void)addOwnViews {
    [super addOwnViews];
    
}

@end

@implementation BaseVLinearTableViewCell

- (MyLinearLayout *)rootLayout {
    return (MyLinearLayout *)_rootLayout;
}

- (void)createRootLayout {
    _rootLayout= [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    _rootLayout.cacheEstimatedRect = YES;
    _rootLayout.myHorzMargin = MyLayoutPos.safeAreaMargin;
    _rootLayout.myHeight = MyLayoutSize.wrap;
    [self.contentView addSubview:_rootLayout];
}

@end

@implementation BaseRelativeTableViewCell

- (MyRelativeLayout *)rootLayout {
    return (MyRelativeLayout *)_rootLayout;
}

- (void)createRootLayout {
    _rootLayout= [MyRelativeLayout new];
    _rootLayout.cacheEstimatedRect = YES;
    _rootLayout.myHorzMargin = MyLayoutPos.safeAreaMargin;
     _rootLayout.widthSize.equalTo(self.contentView.widthSize);
     _rootLayout.heightSize.equalTo(@(MyLayoutSize.wrap));
    [self.contentView addSubview:_rootLayout];
}

@end


