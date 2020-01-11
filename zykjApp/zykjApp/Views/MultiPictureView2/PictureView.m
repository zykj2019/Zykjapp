//
//  PictureView.m
//  Hdys
//
//  Created by air on 15/7/15.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import "PictureView.h"
#import "UIView+Extension.h"

@interface PictureStatusView : UIView

@property (strong, nonatomic) UILabel *progressLbl;

@property (strong, nonatomic) UIImageView *sendFailed;

//状态
@property (assign, nonatomic) PictureStatus status;

@end


@implementation PictureStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addOwnViews];
        [self configOwnViews];
        [self addConstConstraints];
    }
    return self;
}
- (void)addOwnViews {
    [super addOwnViews];
    
    _sendFailed = [[UIImageView alloc] init];
    _sendFailed.image = [UIImage imageNamed:@"sending_failed"];
    _sendFailed.hidden = YES;
    [self addSubview:_sendFailed];
    
    UILabel *progressLbl = [[UILabel alloc] init];
    [self addSubview:progressLbl];
    _progressLbl = progressLbl;
    _progressLbl.font = BaesFont(13.0);
    _progressLbl.textColor = kWhiteColor;
    
    self.backgroundColor = RGBA(0, 0, 0, 0.7);
    
}

- (void)setStatus:(PictureStatus)status {
    _status = status;
    
    switch (status) {
        case PictureStatusWillSending:
        case PictureStatusSending:
            _progressLbl.hidden = NO;
            _sendFailed.hidden = YES;
            break;
         case PictureStatusFail:
            _progressLbl.hidden = YES;
            _sendFailed.hidden = NO;
            break;
        default:
            break;
    }
}

- (void)addConstConstraints {
    WS(ws);
    [super addConstConstraints];
    
    [_progressLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.mas_centerX);
        make.centerY.mas_equalTo(ws.mas_centerY);
    }];
    
    [_sendFailed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.mas_centerX);
        make.centerY.mas_equalTo(ws.mas_centerY);
        make.size.mas_equalTo(ws.sendFailed.image.size);
    }];
}
@end

@interface PictureView ()

@property (strong, nonatomic) UIButton *videoStatusBtn;

@property (strong, nonatomic) PictureStatusView *pictureStatusView;

@end

@implementation PictureView

- (void)dealloc {
    if (_msgKVO) {
        [_msgKVO unobserveAll];
    }
}


/// 为了适应浏览多图适配
- (UIImage *)image {
    return _imgView.image;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
     PictureResource pictureResource = _picture.pictureResource;
    
     CGRect frame = self.bounds;
    _imgView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _imgView.layer.cornerRadius = self.layer.cornerRadius;
    
    if (MultiPicture_isShowProgress) {
        _pictureStatusView.layer.cornerRadius = self.layer.cornerRadius;
    }

    if (pictureResource == PictureResourceAudio) {
        //
        _messageVoiceStatusImageView.size = CGSizeMake(60.0, 60.0);
        _messageVoiceStatusImageView.center = _imgView.center;
        
        [_timeLbl sizeToFit];
        _timeLbl.x = 5.0;
        _timeLbl.y = 5.0;
        
    } else if (pictureResource == PictureResourceVideo) {
         self.beginVideoBtn.frame = CGRectMake(CGRectGetMidX(self.bounds) -  30.0 , CGRectGetMidY(self.bounds) - 30.0, 60.0, 60.0);
    } else if (pictureResource == PictureResourceImg)  {
        
    }
   
    CGPoint delBtnCenter = CGPointMake(self.width - 8.0, 8.0);
    self.delImgView.center = delBtnCenter;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //图片
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        _imgView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImgTap:)];
        [_imgView addGestureRecognizer:tapGestureRecognizer];
        
        UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveAction:)];
        longPressRecognizer.minimumPressDuration = 1.0;
        [_imgView addGestureRecognizer:longPressRecognizer];
        [tapGestureRecognizer requireGestureRecognizerToFail:longPressRecognizer];
        
        [self addSubview:_imgView];
        _delImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        [_delImgView setImage:[UIImage imageNamed:@"del"]];
        _delImgView.userInteractionEnabled = YES;
        _delImgView.contentMode = UIViewContentModeScaleToFill;
        UITapGestureRecognizer *delTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(delImgTap:)];
        [_delImgView addGestureRecognizer:delTapGestureRecognizer];
        [self addSubview:_delImgView];
        
        CGPoint delBtnCenter = CGPointMake(self.width - 8.0, 8.0);
        self.delImgView.center = delBtnCenter;
        
        
        //配置视频view
        UIButton *beginVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:beginVideoBtn];
        _beginVideoBtn = beginVideoBtn;
        [_beginVideoBtn setImage:[UIImage imageNamed:@"mulit_video_play"] forState:UIControlStateNormal];
        //        [_beginVideoBtn addTarget:self action:@selector(playVideoAction:) forControlEvents:UIControlEventTouchUpInside];
        _beginVideoBtn.frame = CGRectMake(CGRectGetMidX(self.bounds) -  30.0 , CGRectGetMidY(self.bounds) - 30.0, 60.0, 60.0);
        _beginVideoBtn.userInteractionEnabled = NO;
        _beginVideoBtn.hidden = YES;
        
        //配置音频view
        _messageVoiceStatusImageView = [[UIImageView alloc] init];
        _messageVoiceStatusImageView.image = [UIImage imageNamed:@"mulit_trumpet3"] ;
        UIImage *image1 = [UIImage imageNamed:@"mulit_trumpet1"];
        UIImage *image2 = [UIImage imageNamed:@"mulit_trumpet2"];
        UIImage *image3 = [UIImage imageNamed:@"mulit_trumpet3"];
        _messageVoiceStatusImageView.highlightedAnimationImages = @[image1,image2,image3];
        _messageVoiceStatusImageView.animationDuration = 1.5f;
        _messageVoiceStatusImageView.animationRepeatCount = NSUIntegerMax;
        [self addSubview:_messageVoiceStatusImageView];
        _messageVoiceStatusImageView.hidden = YES;
        
        //语音图片
        _timeLbl = [[UILabel alloc] init];
        _timeLbl.textAlignment = kCTTextAlignmentLeft;
        [_timeLbl setFont:BaesFont(14.0)];
        [_timeLbl setTextColor:kWhiteColor];
        [self addSubview:_timeLbl];
        _timeLbl.hidden = YES;
        
        //状态
        if (MultiPicture_isShowProgress) {
            PictureStatusView *pictureStatusView = [[PictureStatusView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            [self addSubview:pictureStatusView];
            _pictureStatusView = pictureStatusView;
            _pictureStatusView.userInteractionEnabled = NO;
            
            [self bringSubviewToFront:pictureStatusView];
            
            [self bringSubviewToFront:_delImgView];
        }
        
        
    }
    
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super  hitTest:point withEvent:event];
    if (!view) {
        if (CGRectContainsPoint(self.delImgView.frame, point) && !self.delImgView.hidden) {
            return self.delImgView;
        }
    }
    return view;
}

- (void)setPicture:(Picture *)picture {
    _picture = picture;
    [self configKVO];
    
    [self configInfo];
    
}

#pragma mark - private

- (void)configKVO
{
    @weakify(self);
    [_msgKVO unobserveAll];
    
    if (!_msgKVO)
    {
        _msgKVO = [FBKVOController controllerWithObserver:self];
    }
    
    PictureResource pictureResource = _picture.pictureResource;
    
    if (MultiPicture_isShowProgress) {
        [_msgKVO observe:_picture keyPath:@"status" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
            @strongify(self);
            [self configInfo];
        }];
        
        [_msgKVO observe:_picture keyPath:@"progress" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
            @strongify(self);
            [self configInfo];
//            NSLog(@"%.2f",self.picture.progress);
        }];
    }
   
    
    if (pictureResource == PictureResourceAudio) {
        [_msgKVO observe:_picture keyPath:@"audioStatus" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
            @strongify(self);
            [self configInfo];
        }];
    }
    
}

- (void)configInfo {
    
    @weakify(self);
    PictureResource pictureResource = _picture.pictureResource;
    PictureStatus status = _picture.status;
    
    //先隐藏
    for (UIView *subView in self.subviews) {
        if (subView == _delImgView) {
            continue;
        }
        subView.hidden = YES;
    }
    
    if (pictureResource == PictureResourceAudio) {
        _imgView.image = nil;
        _imgView.hidden = NO;
        _imgView.backgroundColor = RGB(78, 156, 211);
        switch (_picture.audioStatus) {
            case MyAudioBtnStatusStarting:
            {
                self.messageVoiceStatusImageView.highlighted = YES;
                [self.messageVoiceStatusImageView startAnimating];
            }
                
                break;
                
            default:
            {
                self.messageVoiceStatusImageView.highlighted = NO;
                [self.messageVoiceStatusImageView stopAnimating];
            }
                break;
        }
        _timeLbl.hidden = NO;
        _messageVoiceStatusImageView.hidden = NO;
        NSInteger audioTime = _picture.audioTime;
        if (audioTime >= 60) {
            self.timeLbl.text = [NSString stringWithFormat:@"%ld'%ld''",(long)(audioTime / 60), (long)(audioTime % 60)];
        } else {
            self.timeLbl.text = [NSString stringWithFormat:@"%ld''",(long)audioTime];
        }
    } else if (pictureResource == PictureResourceImg) {
        //图片
        _imgView.hidden = NO;
        if (_picture.imge) {
            _imgView.image = _picture.imge;
        } else {
            [_imgView sd_setImageWithURL:_picture.imgeUrl placeholderImage:kIconPicImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                @strongify(self);
                self.picture.imge = image;
            }];
        }
    } else if (pictureResource == PictureResourceVideo) {
        //视频
        _imgView.hidden = NO;
        _beginVideoBtn.hidden = NO;
        if (_picture.imge) {
            _imgView.image = _picture.imge;
        } else {
            [_imgView sd_setImageWithURL:_picture.imgeUrl placeholderImage:kIconPicImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                @strongify(self);
                self.picture.imge = image;
            }];
        }
        
    }
    
    //
    if (status == PictureStatusWillSending || status == PictureStatusFail || status == PictureStatusSending) {
        _pictureStatusView.hidden = NO;
        _pictureStatusView.status = status;
        NSString *progressText = (status == PictureStatusWillSending) ? [NSString stringWithFormat:@"转码中:%d%@",(int)(_picture.progress*100),@"%"] : [NSString stringWithFormat:@"上传中:%d%@",(int)(_picture.progress*100),@"%"];
        _pictureStatusView.progressLbl.text = progressText;
//        NSLog(@"picture.exportSession.status:%ld-----%ld",(long)_picture.exportSession.status,(long)status);
//        NSLog(@"%.2f",_picture.progress);

    }
   
    
}

#pragma mark - target

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
////    [super touchesBegan:touches withEvent:event];
//    if (self.delegate && [(NSObject *)self.delegate respondsToSelector:@selector(showPicture:)])
//    {
//        [self.delegate showPicture:self];
//    }
//}

// 点击图片
- (void)showImgTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"点击图片");
    
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(showPicture:)])
    {
        [_delegate showPicture:self];
    }
}

// 长按图片
- (void)saveAction:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
         NSLog(@"saveAction");
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(longPressPicture:)]) {
            [_delegate longPressPicture:self];
        }
    }
}


// 点击图片
- (void)addImgTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"点击图片");

    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(addPicture)])
    {
        [_delegate addPicture];
    }
}

// 删除图片
- (void)delImgTap:(UITapGestureRecognizer *)recognizer
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(delPicture:)])
    {
        [_delegate delPicture:self];
    }
}


@end
