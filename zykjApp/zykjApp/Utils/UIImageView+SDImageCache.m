//
//  UIImageView+SDImageCache.m
//  TwoView
//
//  Created by zoulixiang on 16/6/13.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import "UIImageView+SDImageCache.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (SDImageCache)

-(void)loadImgWithUrl:(NSString *)str andPlaceHolderImage:(UIImage *)image{
    
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    
    
    UIImage *avatarImg = [imageCache imageFromDiskCacheForKey:str];
    if (avatarImg)
    {
        [self setImage:avatarImg];
    }
    else
    {
        NSURL *faceImgUrl = [NSURL URLWithString:str];
        [self sd_setImageWithURL:faceImgUrl placeholderImage:image options:SDWebImageRefreshCached | SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
}

-(void)loadImgWithUrl:(NSString *)str {
    
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    
    
    UIImage *avatarImg = [imageCache imageFromDiskCacheForKey:str];
    if (avatarImg)
    {
        [self setImage:avatarImg];
    }
    else
    {
        NSURL *faceImgUrl = [NSURL URLWithString:str];
        [self sd_setImageWithURL:faceImgUrl placeholderImage:[UIImage imageNamed:@"defaultHead"] options:SDWebImageRefreshCached | SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }

}
@end
