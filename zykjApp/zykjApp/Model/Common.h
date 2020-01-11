//
//  Common.h
//  ZykjAppWork
//
//  Created by zoulixiang on 2018/7/19.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

@property (copy, nonatomic) NSString *key;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *placeholder;

@property (copy, nonatomic) NSString *detail;

@property (copy, nonatomic) NSString *selectItemTitle;

@property (assign, nonatomic) BOOL isSelect;

@property (assign, nonatomic) BOOL canEmpty;

@property (assign, nonatomic) BOOL enabled;

@property (assign, nonatomic) NSInteger maxTextLength;

@property (copy, nonatomic) NSString *orginValue;

@property (copy, nonatomic) NSString *tag;
//位置
@property (assign, nonatomic) CGFloat left;

@property (assign, nonatomic) CGFloat top;

@property (assign, nonatomic) CGFloat right;

@property (assign, nonatomic) CGFloat bottom;

@property (assign, nonatomic) CGFloat percent;

//view
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *backGroundColor;
@property (strong, nonatomic) UIImage *img;
@property (assign, nonatomic) NSInteger numberOfLines;
@property (assign, nonatomic) CGFloat cellHeight;

//array
@property (strong, nonatomic) NSArray *arrays;


//action
@property (assign, nonatomic) CommonBlock selectBlock;

@end
