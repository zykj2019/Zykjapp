//
//  Picture.h
//  ZykjAppClient
//
//  Created by zoulixiang on 2018/6/14.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyAudioViewController.h"


#define ROW_NUM                3           // 每行显示多少张
#define ROW_MARGIN             15          // 距离父视图的间距
#define ROW_SPACE              5          // 图片之前的间距
#define ALL_ROWS_SPACE         (((ROW_NUM - 1) * ROW_SPACE) + ROW_MARGIN * 2)    // 所有间距总和
#define GET_SCREEN_WIDTH       ([UIScreen mainScreen].bounds).size.width       // 屏幕宽
#define GET_SCREEN_HEIGHT      ([UIScreen mainScreen].bounds).size.height      // 屏幕宽

#define ITEM_WIDTH             ((GET_SCREEN_WIDTH - ALL_ROWS_SPACE) / ROW_NUM) // 图片宽
#define ITEM_HEIGHT            ((GET_SCREEN_WIDTH - ALL_ROWS_SPACE) / ROW_NUM) // 图片高

typedef enum : NSInteger {
    PictureResourceNone,
    PictureResourceImg,
    PictureResourceVideo,
    PictureResourceAudio,
}PictureResource;

typedef enum : NSInteger {
    PictureStatusSucc,
    PictureStatusWillSending,
    PictureStatusSending,
    PictureStatusFail,
}PictureStatus;

@class PictureView;
//@class Media;


@interface Picture : NSObject <MyAudioPlayHelpDelegate>


/**
 本地或者网络url
 */
@property (strong, nonatomic) NSURL *fileUrl;

@property (strong, nonatomic) UIImage *imge;

@property (assign, nonatomic) NSInteger audioTime;

@property (assign, nonatomic) PictureResource pictureResource;

@property (strong, nonatomic) NSURL *imgeUrl;

//传图片所用
@property (assign, nonatomic) NSInteger index;

//后缀
@property (copy, nonatomic) NSString *pathExtension;

@property (assign, nonatomic) MyAudioBtnStatus audioStatus;

//状态
@property (assign, nonatomic) PictureStatus status;

/**
 * The progress of the export on a scale from 0 to 1.
 *
 *
 * A value of 0 means the export has not yet begun, 1 means the export is complete.
 *
 * Unlike Apple provided `AVAssetExportSession`, this property can be observed using key-value observing.
 */
@property (nonatomic, assign) float progress;

/**
 图片
 pathExtension:默认jpg
 @param imge img
 @return 实例
 */
- (instancetype)initWithImge:(UIImage *)imge;


/**
 视频
 pathExtension:默认mp4
 @param imge 缩略图
 @param url 视频文件url
 @return 实例
 */
- (instancetype)initVideoWithImge:(UIImage *)imge fileUrl:(NSURL *)url;

/**
 音频
 pathExtension:默认wav
 @param audioTime 音频时间
 @param url 音频文件url
 @return 实例
 */
- (instancetype)initVideoWithAudioTime:(NSInteger)audioTime fileUrl:(NSURL *)url;

///普通的样式
- (PictureView *)getPictureView;

///得到微信语音样式
- (PictureView *)getWechatStyleAudioView;

- (CGSize)showSize;

- (CGSize)showSizeMaxWidth:(CGFloat)maxWidth;

@end
