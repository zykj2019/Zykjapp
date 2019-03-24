//
//  MultiPictureView.h
//  Hdys
//
//  Created by air on 15/7/16.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ROW_NUM                4           // 每行显示多少张
#define ROW_MARGIN             10          // 距离父视图的间距
#define ROW_SPACE              10          // 图片之前的间距
#define ALL_ROWS_SPACE         ((4 + 1) * ROW_SPACE)   // 所有间距总和
#define GET_SCREEN_WIDTH       ([UIScreen mainScreen].bounds).size.width       // 屏幕宽
#define GET_SCREEN_HEIGHT      ([UIScreen mainScreen].bounds).size.height      // 屏幕宽

#define ITEM_WIDTH             ((GET_SCREEN_WIDTH - ALL_ROWS_SPACE) / ROW_NUM) // 图片宽
#define ITEM_HEIGHT            ((GET_SCREEN_WIDTH - ALL_ROWS_SPACE) / ROW_NUM) // 图片高

@protocol MultiPicDelegate

//- (void)didAddPicBegin;

- (void)didAddPicEnd;

- (void)didDelPic;

@end

@interface MultiPictureView : UIView


@property (nonatomic, strong) NSMutableArray *imageArray;

- (void)createMultiPicView:(UIViewController *)viewCtrl delegate:(id<MultiPicDelegate>)delegate;
- (void)addNewPic:(UIImage *)img;

@end
