//
//  MyAudioBtn.m
//  ZykjAppClient
//
//  Created by zoulixiang on 2019/3/6.
//  Copyright © 2019年 zoulixiang. All rights reserved.
//

#import "MyAudioBtn.h"

@implementation MyAudioBtn

- (void)setAudioHelp:(MyAudioHelp *)audioHelp {
    _audioHelp = audioHelp;
    _audioHelp.myAudioBtn = self;
    if ([audioHelp respondsToSelector:@selector(clickAction:)]) {
        [self addTarget:audioHelp action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)setTimeDuration:(NSInteger)timeDuration {
    _timeDuration = timeDuration;
    if (timeDuration > 0) {
        NSString *text = self.timeDurationStr;
        [self setTitle:text forState:UIControlStateNormal];
    }
    
}

- (void)setAudioStatus:(MyAudioBtnStatus)audioStatus {
    _audioStatus = audioStatus;
    switch (audioStatus) {
        case MyAudioBtnStatusNoStart: {
            self.timeDuration = 0;
            UIImage *img = [UIImage imageNamed:@"yuyin"];
            NSString *text = nil;
            [self setImage:img forState:UIControlStateNormal];
            [self setTitle:text forState:UIControlStateNormal];
            
        }
            
            break;
        case MyAudioBtnStatusStarting: {
            UIImage *img = [UIImage new];
            NSString *text = self.timeDurationStr;
            [self setImage:img forState:UIControlStateNormal];
            [self setTitle:text forState:UIControlStateNormal];
        }
            break;
            
        case MyAudioBtnStatusPause: {
            UIImage *img = [UIImage imageNamed:@"kaishi"];
            NSString *text = nil;
            [self setImage:img forState:UIControlStateNormal];
            [self setTitle:text forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    MyAudioBtn *btn = [super buttonWithType:buttonType];
    [btn addOwnViews];
    [btn configOwnViews];
    return btn;
}



- (void)configOwnViews {
    [super configOwnViews];
    
    self.backgroundColor = kAppThemeColor;
    self.titleLabel.font = BaesFont(13.0);
    [self setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self setTitleColor:kClearColor forState:UIControlStateSelected];
    
    self.audioStatus = MyAudioBtnStatusNoStart;
    
}

#pragma mark -
//时间描述
- (NSString *)timeDurationStr {
    NSString *decadeMinute = [NSString stringWithFormat:@"%ld",(long)((_timeDuration / 60) / 10)];
    NSString *minute = [NSString stringWithFormat:@"%ld",(long)(_timeDuration / 60)];
    NSString *decadeSec = [NSString stringWithFormat:@"%ld",(long)((_timeDuration % 60) / 10)];
    NSString *sec = [NSString stringWithFormat:@"%ld",(long)((_timeDuration % 60) % 10)];
    
    return [NSString stringWithFormat:@"%@%@:%@%@",decadeMinute,minute,decadeSec,sec];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addRoundBorder];
}

@end
