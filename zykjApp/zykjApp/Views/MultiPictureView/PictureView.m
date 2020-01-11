//
//  PictureView.m
//  Hdys
//
//  Created by air on 15/7/15.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import "PictureView.h"

@interface PictureView ()

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *delImgView;

@end

@implementation PictureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, frame.size.width - 10, frame.size.height - 10)];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        
        [self addSubview:_imgView];
        _delImgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 24, 0, 24, 24)];
        [_delImgView setImage:[UIImage imageNamed:@"del"]];
        _delImgView.userInteractionEnabled = YES;
        _delImgView.contentMode = UIViewContentModeScaleToFill;
        UITapGestureRecognizer *delTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(delImgTap:)];
        [_delImgView addGestureRecognizer:delTapGestureRecognizer];
        [self addSubview:_delImgView];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image type:(NSInteger)type
{
    [_imgView setImage:image];
    if (type == 1)
    {
        [_imgView setHighlightedImage:[UIImage imageNamed:@"add2"]];
        [_delImgView removeFromSuperview];
        _imgView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImgTap:)];
        [_imgView addGestureRecognizer:tapGestureRecognizer];
    }
    else
    {
        _imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImgTap:)];
        [_imgView addGestureRecognizer:tapGestureRecognizer];
    }
}


// 点击图片
- (void)showImgTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"点击图片");
    
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(showPicture:)])
    {
        [_delegate showPicture:self];
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
    //[self removeFromSuperview];
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(delPicture:)])
    {
        [_delegate delPicture:self];
    }
}


@end
