//
//  MyTextView.h
//  coreText-Label
//
//  Created by zoulixiang on 16/7/23.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContantHead.h"

@protocol MyCoretextDelegate <NSObject>

@optional
- (void)clickMyCoretext:(int)clickIndex object:(NSObject *)object;

- (void)clickMyCoretextLink:(NSString *)link;

- (void)clickMycoretextAll:(NSObject *)object;
@end

@interface MyTextView : UIView

@property (nonatomic,strong) NSAttributedString *attrEmotionString;

@property (strong, nonatomic) NSArray *linkArray;                       //存link

@property (nonatomic,assign) BOOL isDraw;

@property (nonatomic,assign) BOOL canClickAll;  //是否可点击整段文字

@property (nonatomic,assign) BOOL isFold;//是否折叠

@property (nonatomic,assign) NSInteger replyIndex;  //默认为-1 代表点击的是说说的整块区域

@property (nonatomic,assign) CFIndex limitCharIndex;//限制行的最后一个char的index

@property (strong, nonatomic) UIColor *defaultColor;

@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic,assign) id<MyCoretextDelegate>delegate;

@property (copy, nonatomic) NSString *strTag; //标记

@property (strong, nonatomic) NSMutableDictionary *rangeDict;

@property (strong, nonatomic) NSObject *object;

@property (assign, nonatomic) int type;                                 //0:不含有图文   1:含有图文的

//图片富文本

@property (strong, nonatomic) NSMutableArray *sizeArray;                //图片大小

@property (strong, nonatomic) NSMutableArray *imgRanges;                //图片占位符位置

@property (strong, nonatomic) NSMutableArray *picViewArray;             //存图片view


- (void)setNewString:(NSString *)newString;

- (CGFloat )getTextHeight;

- (int)getTextLines;                    //获得行数
@end
