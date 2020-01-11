//
//  MultiPictureView.h
//  ZykjAppClient
//
//  Created by zoulixiang on 2018/6/14.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MulitVideoView.h"

@protocol MultiPicDelegate

@optional


/**
 当MultiPictureView 高度变化的代理
 */
- (void)didAddPicEnd;

/**
 当MultiPictureView 高度变化的代理
 */
- (void)didDelPic;


/**
 删除每一项的代理

 @param pictureView pictureView
 */
- (void)delPic:(PictureView *)pictureView;

- (void)didShowPic:(PictureView *)pictureView;

@end


@interface MultiPictureView : UIView

//PictureView
@property (strong, nonatomic) NSMutableArray<PictureView *> *picViews;

//最多图片数
@property (assign, nonatomic) int allPicCount;

/**
 当前资源类型
 */
@property (assign, nonatomic,readonly) PictureResource resourceType;


- (void)createMultiPicView:(UIViewController *)viewCtrl delegate:(id<MultiPicDelegate>)delegate;

/**
 上传完毕后调用此方法增加图片展示

 @param pictures Picture数组
 */
- (void)addNewPic:(NSArray *)pictures;

//获取当前图片组的Picture
- (NSArray *)getPictures;

/**
 //检查是否可以继续添加资源
 
 @param pictureResource 需要添加的资源类型
 @param currentResource 当前资源类型
 @param isShowTip 是否需要弹出提示
 @return 是否可以继续添加
 */
+ (BOOL)checkCanSelectResource:(PictureResource)pictureResource currentResource:(PictureResource)currentResource isShowTip:(BOOL)isShowTip;

//显示图片增加到上限信息
- (void)showLimitingMessage;

/**
 图片类型index

 @param pictureView 要返回index的pictureView
 @return index
 */
- (NSInteger)indexOfOnlyImgPics:(PictureView *)pictureView;

@end
