//
//  PictureView.h
//  Hdys
//
//  Created by air on 15/7/15.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PictureView;
@protocol PictureDelegate

- (void)addPicture;
- (void)delPicture:(PictureView *)pictureView;
- (void)showPicture:(PictureView *)pictureView;

@end

@interface PictureView : UIView

@property (nonatomic, assign) id<PictureDelegate> delegate;

- (void)setImage:(UIImage *)image type:(NSInteger)type;

@end
