//
//  BaseTableView.m
//  ZykjAppClient
//
//  Created by zoulixiang on 2018/4/19.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "BaseTableView.h"
#import "Common.h"

@implementation BaseTableView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (IsIOS11Later && self.rightSlideConfig) {
        NSDictionary *dict = self.rightSlideConfig;
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]) {
                for (UIView *subViews in view.subviews) {
                    if ([subViews isKindOfClass:[UIButton class]]) {
                        UIButton *btn = (UIButton *)subViews;
//                        NSString *key = [btn titleForState:UIControlStateNormal];
//                        if (key) {
//                            Common *common = dict[key];
//                            btn.titleLabel.font = common.font ? common.font : BaesFont(13.0);
//                            UIImage *img = common.img;
//                            if (img) {
//                                [btn setTitle:nil forState:UIControlStateNormal];
//                                [btn setImage:img forState:UIControlStateNormal];
//                            }
//                        }
                        [self adjuestRightSlide:btn commonDict:dict];
                    }
                }
            }
        }
    }
}

#pragma mark - private
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

@end
