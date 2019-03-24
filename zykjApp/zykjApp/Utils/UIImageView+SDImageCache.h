//
//  UIImageView+SDImageCache.h
//  TwoView
//
//  Created by zoulixiang on 16/6/13.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SDImageCache)

-(void)loadImgWithUrl:(NSString *)str andPlaceHolderImage:(UIImage *)image;
-(void)loadImgWithUrl:(NSString *)str;
@end
