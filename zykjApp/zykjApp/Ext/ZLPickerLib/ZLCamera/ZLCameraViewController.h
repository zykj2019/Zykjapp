//
//  BQCamera.h
//  BQCommunity
//
//  Created by ZL on 14-9-11.
//  Copyright (c) 2014年 beiqing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^codeBlock)(void);
typedef void(^ZLComplate)(id object);
typedef void(^ZLParseAssetComplate)(id object,UIImage *image,ALAsset *asset);

@interface ZLCameraViewController : UIViewController

@property (assign, nonatomic) NSInteger minCount;

// 是否显示原图发送
@property (nonatomic , assign) BOOL isShowOriginalFileSend;

/**
 *  打开相机
 *
 *  @param viewController 控制器
 *  @param complate       成功后的回调
 */
- (void)startCameraOrPhotoFileWithViewController:(UIViewController*)viewController complate : (ZLComplate ) complate;

/**
 *  打开相机 (不会调用sheet)
 *
 *  @param viewController 控制器
 *  @param complate       成功后的回调
 */
- (void)startWithViewController:(UIViewController*)viewController complate : (ZLComplate ) complate;

// 完成后回调
@property (copy, nonatomic) ZLComplate complate;

//开始拍照1
- (void)openCamera;

//开始拍照
-(void)takePhoto;

//打开本地相册
-(void)LocalPhoto;



/**
 //打开本地相册
 
 @param status status
 */
-(void)LocalPhotoWithStatus:(PickerViewShowStatus)status;


/**
 拍照与录像
 */
- (void)openCameraAndVideo;

/**
 选完资源后解析成UIImage *image,ALAsset *asset

 @param obj
 @param parseAssetComplate 
 */
+(void)parseAsset:(id)obj complate:(ZLParseAssetComplate)parseAssetComplate;

@end
