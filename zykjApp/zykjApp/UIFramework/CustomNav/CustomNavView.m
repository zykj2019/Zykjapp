//
//  CustomNavView.m
//  ZykjAppWork
//
//  Created by zoulixiang on 2018/8/5.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "CustomNavView.h"

@implementation CustomNavView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addOwnViews];
        [self configOwnViews];
        [self addConstConstraints];
    }
    return self;
}

- (void)addOwnViews {
    [super addOwnViews];
    self.customNav = [[CustomNav alloc] init];
    [self addSubview:self.customNav];
    
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
}

- (void)addConstConstraints {
    [super addConstConstraints];
    WS(ws);
    [self.customNav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(ws);
        make.height.mas_equalTo([CustomNav navBarBottom]);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.customNav);
        make.left.bottom.right.mas_equalTo(ws);
    }];
    
}
@end
