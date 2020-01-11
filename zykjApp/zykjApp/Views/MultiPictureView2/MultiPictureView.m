//
//  MultiPictureView.m
//  ZykjAppClient
//
//  Created by zoulixiang on 2018/6/14.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "MultiPictureView.h"

@interface MultiPictureView() <PictureDelegate>

@property (nonatomic, weak) id<MultiPicDelegate> delegate;
@property (nonatomic, weak) UIViewController *currentVC;

@end
@implementation MultiPictureView

- (CGFloat)showHeight {
//    if (_picViews.count == 1) {
//        //如果只有一项
//        Picture *picture = ((PictureView *)_picViews.firstObject).picture;
//        if (picture.pictureResource == PictureResourceVideo || picture.pictureResource == PictureResourceAudio) {
//            return picture.showSize.height ;
//        }
//    }
    //图片
    NSInteger countIndex = _picViews.count ? _picViews.count - 1 : 0;
    NSInteger row = (int)(countIndex / ROW_NUM) + 1;
    return row * ITEM_HEIGHT + (row - 1) * ROW_SPACE ;
}

- (PictureResource)resourceType {
    if (_picViews.count == 0) {
        return PictureResourceNone;
    }
    Picture *picture = ((PictureView *)_picViews.firstObject).picture;
    return picture.pictureResource;
}

- (void)showLimitingMessage {
    [[HUDHelper sharedInstance] tipMessage:[NSString stringWithFormat:@"最多只能添加%d张图片",_allPicCount]];
}

- (void)createMultiPicView:(UIViewController *)viewCtrl delegate:(id<MultiPicDelegate>)delegate {
    
    self.currentVC = viewCtrl;
    self.delegate = delegate;
    self.allPicCount = 9;
    self.picViews = @[].mutableCopy;
    
}

//获取当前图片组的Picture
- (NSArray *)getPictures {
    NSMutableArray *pictures = @[].mutableCopy;
    for (PictureView *view in  self.picViews) {
        [pictures addObject:view.picture];
    }
    return pictures;
}

/**
 //检查是否可以继续添加资源
 
 @param pictureResource 需要添加的资源类型
 @param currentResource 当前资源类型
 @param isShowTip 是否需要弹出提示
 @return 是否可以继续添加
 */
+ (BOOL)checkCanSelectResource:(PictureResource)pictureResource currentResource:(PictureResource)currentResource isShowTip:(BOOL)isShowTip {
    BOOL can = NO;
    if (currentResource == PictureResourceNone) {
        can = YES;
    } else if (currentResource == pictureResource && currentResource == PictureResourceImg) {
        can = YES;
    }
    else if (currentResource != pictureResource) {
        if (isShowTip) {
            [[HUDHelper sharedInstance] tipMessage:@"只能上传一种类型的资源，若要上传此类型的资源，需要取消已选择的资源类型"];
        }
    }
    else {
        if (isShowTip) {
            [[HUDHelper sharedInstance] tipMessage:@"已达到资源上传上限"];
        }
        
    }
    return can;
}

- (void)adjustPicFrame {
    
    for (int i = 0; i < self.picViews.count; i++) {
        PictureView *subView = self.picViews[i];
        CGRect frame = subView.frame;
        CGFloat x = ROW_MARGIN + (int)(i % ROW_NUM) * (ROW_SPACE + ITEM_WIDTH);
        CGFloat y = (int)(i / ROW_NUM) * (ROW_SPACE + ITEM_HEIGHT);
        frame.origin.x = x;
        frame.origin.y = y;
//        subView.frame = frame;
        [UIView animateWithDuration:0.3 animations:^{
            [subView setFrame:frame];
        }];
    }
}

- (void)delHandle:(PictureView *)pictureView {
    if (_picViews.count % ROW_NUM == 0)
    {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(didDelPic)])
        {
            [_delegate didDelPic];
        }
    }
    
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(delPic:)]) {
        [_delegate delPic:pictureView];
    }
    
    [self adjustPicFrame];
    
}
- (void)addNewPic:(NSArray *)pictures {
//    [ApplicationDelegate.window endEditing:YES];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    if (self.picViews.count + pictures.count > _allPicCount)
    {
        [[HUDHelper sharedInstance] tipMessage:[NSString stringWithFormat:@"最多只能添加%d张图片",_allPicCount]];
        return ;
    }
    
    for (Picture *picture in pictures) {
        PictureView *pictureView = picture.getPictureView;
         pictureView.delegate = self;
        [self addSubview:pictureView];
//        NSInteger index = self.picViews.count ? self.picViews.count - 1 : 0;
//        [self.picViews insertObject:pictureView atIndex:index];  // 从后端添加
        [self.picViews addObject:pictureView];
        
        if (self.picViews.count % ROW_NUM == 1 && self.picViews.count > 0)
        {
            if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(didAddPicEnd)])
            {
                [_delegate didAddPicEnd];
            }
        }
    }
    
    [self adjustPicFrame];
    
}
- (NSInteger)indexOfOnlyImgPics:(PictureView *)pictureView {
    NSInteger index = 0;
    for (PictureView *tpictureView in self.picViews) {
        if (tpictureView.picture.pictureResource == PictureResourceImg) {
            if (tpictureView == pictureView) {
                return index;
            }
            index++;
        }
        
    }
    return NSNotFound;
}


#pragma mark - PictureDelegate
// 删除图片
- (void)delPicture:(PictureView *)pictureView {
    WS(ws);
    
    [UIView animateWithDuration:0.2 animations:^{
        pictureView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        pictureView.delegate = nil;
        [ws.picViews removeObject:pictureView];
        [pictureView removeFromSuperview];
        [ws delHandle:pictureView];

    }];
    
    
    
}

- (void)showPicture:(PictureView *)pictureView {
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(didShowPic:)]) {
        [_delegate didShowPic:pictureView];
    }
}

@end
