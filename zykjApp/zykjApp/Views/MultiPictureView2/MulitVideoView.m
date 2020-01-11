//
//  MulitVideoView.m
//  ZykjAppClient
//
//  Created by jsl on 2019/3/19.
//  Copyright © 2019 zoulixiang. All rights reserved.
//

#import "MulitVideoView.h"
#import "UIView+Extension.h"

@implementation MulitAudioView

- (void)dealloc {
    if (_msgKVO) {
        [_msgKVO unobserveAll];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _messageVoiceStatusImageView = [[UIImageView alloc] init];
        _messageVoiceStatusImageView.image = [UIImage imageNamed:@"mulit_voice3"] ;
        UIImage *image1 = [UIImage imageNamed:@"mulit_voice1"];
        UIImage *image2 = [UIImage imageNamed:@"mulit_voice2"];
        UIImage *image3 = [UIImage imageNamed:@"mulit_voice3"];
        _messageVoiceStatusImageView.highlightedAnimationImages = @[image1,image2,image3];
        _messageVoiceStatusImageView.animationDuration = 1.5f;
        _messageVoiceStatusImageView.animationRepeatCount = NSUIntegerMax;
        [self addSubview:_messageVoiceStatusImageView];
        
        self.backgroundColor = UIColorFromRGB(0xF4F4F4);
        self.clipsToBounds = NO;
        
        self.timeLbl.textColor = [UIColor blackColor];
        
    }
    return self;
}

- (void)setPicture:(Picture *)picture {
    [super setPicture:picture];
}

- (void)configInfo {
    [super configInfo];
      self.imgView.backgroundColor = UIColorFromRGB(0xF4F4F4);
}
#pragma mark -

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.picture.pictureResource == PictureResourceAudio) {
         self.messageVoiceStatusImageView.size = self.messageVoiceStatusImageView.image.size;
           self.messageVoiceStatusImageView.x = 13.0;
           self.messageVoiceStatusImageView.y = self.bounds.size.height / 2.0 - self.messageVoiceStatusImageView.height / 2.0;
           
           [self.timeLbl sizeToFit];
            self.timeLbl.center = CGPointMake(CGRectGetMaxX(_messageVoiceStatusImageView.frame) + 8.0 + self.timeLbl.width / 2.0, _messageVoiceStatusImageView.center.y);
    }
   
}

@end
