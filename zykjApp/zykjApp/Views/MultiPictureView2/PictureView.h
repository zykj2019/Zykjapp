//
//  PictureView.h
//  Hdys
//
//  Created by air on 15/7/15.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Picture.h"

//是否需要异步显示进度条 就是是否异步上传
#define MultiPicture_isShowProgress       1

@class PictureView;
@protocol PictureDelegate

@optional;
- (void)addPicture;
- (void)delPicture:(PictureView *)pictureView;
- (void)showPicture:(PictureView *)pictureView;
- (void)longPressPicture:(PictureView *)pictureView;
- (void)playVideoAction:(PictureView *)pictureView;

@end

@interface PictureView : UIView {
    Picture *_picture;
    @protected
    FBKVOController                         *_msgKVO;
     UIImageView *_messageVoiceStatusImageView;
}

//图片
@property (nonatomic, weak) id<PictureDelegate> delegate;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *delImgView;

//视频
@property (strong, nonatomic) UIButton *beginVideoBtn;

//音频
@property (strong, nonatomic) UIImageView *messageVoiceStatusImageView;
@property (strong, nonatomic) UILabel *timeLbl;

@property (strong, nonatomic) UIActivityIndicatorView *waitView;

@property (strong, nonatomic) Picture *picture;

//配置信息
- (void)configInfo;

@end
