//
//  PickerImageView.m
//  相机
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "ZLPickerImageView.h"

@interface ZLPickerImageView ()

@property (nonatomic , weak) UIView *maskView;
@property (nonatomic , weak) UIImageView *tickImageView;
@property (weak, nonatomic) UILabel *videoDurationView;
@property (weak, nonatomic) UIButton *selectBtn;

@end

@implementation ZLPickerImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (UIButton *)selectBtn {
    if (_selectBtn == nil) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectBtn setImage:[UIImage imageNamed:@"zlpicker_noSelect"] forState:UIControlStateNormal];
        [selectBtn setImage:[UIImage imageNamed:@"zlpicker_Select"] forState:UIControlStateSelected];
        [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectBtn];
        selectBtn.frame = CGRectMake(self.width - 30, 0, 30, 30);
        _selectBtn = selectBtn;
    }
    return _selectBtn;
}

- (UIView *)maskView{
    if (!_maskView) {
        UIView *maskView = [[UIView alloc] init];
        maskView.frame = self.bounds;
        maskView.backgroundColor = [UIColor whiteColor];
        maskView.alpha = 0.5;
        maskView.hidden = YES;
        [self addSubview:maskView];
        _maskView = maskView;
    }
    return _maskView;
}

- (UIImageView *)tickImageView{
    if (!_tickImageView) {
        UIImageView *tickImageView = [[UIImageView alloc] init];
        tickImageView.frame = CGRectMake(self.bounds.size.width - 40, 0, 40, 40);
        tickImageView.image = [UIImage imageNamed:@"AssetsPickerChecked"];
        tickImageView.hidden = YES;
        [self addSubview:tickImageView];
        _tickImageView = tickImageView;
    }
    return _tickImageView;
}

- (UILabel *)videoDurationView {
    if (!_videoDurationView) {
        UILabel *videoDurationView = [[UILabel alloc] init];
        videoDurationView.hidden = YES;
        videoDurationView.textColor = [UIColor whiteColor];
        videoDurationView.font = [UIFont systemFontOfSize:12.0];
         [self addSubview:videoDurationView];
        _videoDurationView = videoDurationView;
    }
    return _videoDurationView;
}

- (void)setMaskViewFlag:(BOOL)maskViewFlag{
    _maskViewFlag = maskViewFlag;
    
//    self.maskView.hidden = !maskViewFlag;
//    self.animationRightTick = maskViewFlag;
    
    self.selectBtn.selected = maskViewFlag;
}

- (void)setMaskViewColor:(UIColor *)maskViewColor{
    _maskViewColor = maskViewColor;
    
    self.maskView.backgroundColor = maskViewColor;
}

- (void)setMaskViewAlpha:(CGFloat)maskViewAlpha{
    _maskViewAlpha = maskViewAlpha;
    
    self.maskView.alpha = maskViewAlpha;
}

- (void)setVideoDuration:(NSInteger)videoDuration {
    _videoDuration = videoDuration;
    self.videoDurationView.hidden = _videoDuration == 0;
    NSString *minute = [NSString stringWithFormat:@"%ld",(long)(videoDuration / 60)];
    NSString *decadeSec = [NSString stringWithFormat:@"%ld",(long)((videoDuration % 60) / 10)];
    NSString *sec = [NSString stringWithFormat:@"%ld",(long)((videoDuration % 60) % 10)];
    
    self.videoDurationView.text = [NSString stringWithFormat:@"%@:%@%@",minute,decadeSec,sec];
    [self.videoDurationView sizeToFit];
    self.videoDurationView.center = CGPointMake(self.bounds.size.width - self.videoDurationView.width / 2.0 - 5.0, self.bounds.size.height - self.videoDurationView.height / 2.0 - 5.0);
}

- (void)setAnimationRightTick:(BOOL)animationRightTick{
    _animationRightTick = animationRightTick;
    self.tickImageView.hidden = !animationRightTick;
}

- (void)selectAction:(UIButton *)sender {
    if (_selectBlock) {
        _selectBlock();
    }
}

@end
