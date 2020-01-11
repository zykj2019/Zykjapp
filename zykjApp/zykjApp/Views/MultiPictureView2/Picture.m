//
//  Picture.m
//  ZykjAppClient
//
//  Created by zoulixiang on 2018/6/14.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "Picture.h"
#import "MulitVideoView.h"

@interface Picture()

@end

@implementation Picture
- (void)dealloc {
     [self.KVOController unobserveAll];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       self.KVOController = [FBKVOController controllerWithObserver:self];
    }
    return self;
}
- (instancetype)initWithImge:(UIImage *)imge {
    if (self = [self init]) {
        self.imge = imge;
         self.pictureResource = PictureResourceImg;
        self.pathExtension = @"jpg";
    }
    return self;
}

- (instancetype)initVideoWithImge:(UIImage *)imge fileUrl:(NSURL *)url {
    if (self = [self init]) {
        self.imge = imge;
        self.fileUrl = url;
        self.pictureResource = PictureResourceVideo;
        self.pathExtension = @"mp4";
    }
    return self;
}

- (instancetype)initVideoWithAudioTime:(NSInteger)audioTime fileUrl:(NSURL *)url {
    if (self = [self init]) {
        self.audioTime = audioTime;
        self.fileUrl = url;
        self.pictureResource = PictureResourceAudio;
        self.pathExtension = Pro_Audio_File_Format;
    }
    return self;
}


//- (PictureView *)getPictureView {
//    PictureView *pictureView;
//    if (self.pictureResource == PictureResourceImg) {
//        pictureView = [[PictureView alloc] initWithFrame:CGRectMake(0, 0, ITEM_WIDTH, ITEM_HEIGHT)];
//    } else if (self.pictureResource == PictureResourceVideo) {
//        CGSize size = self.showSize;
//       pictureView = [[MulitVideoView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//    } else if (self.pictureResource == PictureResourceAudio) {
//        CGSize size = self.showSize;
//        pictureView = [[MulitAudioView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//    }
//
//    pictureView.picture = self;
//    pictureView.layer.cornerRadius = 6.0;
//
//
//    return pictureView;
//
//}

- (PictureView *)getPictureView {
    PictureView *pictureView;
//    if (self.pictureResource == PictureResourceImg) {
//        pictureView = [[PictureView alloc] initWithFrame:CGRectMake(0, 0, ITEM_WIDTH, ITEM_HEIGHT)];
//    } else if (self.pictureResource == PictureResourceVideo) {
////        CGSize size = self.showSize;
//        pictureView = [[PictureView alloc] initWithFrame:CGRectMake(0, 0, ITEM_WIDTH, ITEM_HEIGHT)];
//    } else if (self.pictureResource == PictureResourceAudio) {
////        CGSize size = self.showSize;
//       pictureView = [[PictureView alloc] initWithFrame:CGRectMake(0, 0, ITEM_WIDTH, ITEM_HEIGHT)];
//    }
     pictureView = [[PictureView alloc] initWithFrame:CGRectMake(0, 0, ITEM_WIDTH, ITEM_HEIGHT)];
    pictureView.picture = self;
    pictureView.layer.cornerRadius = 6.0;
   
   
    return pictureView;
    
}

- (PictureView *)getWechatStyleAudioView {
    PictureView *pictureView;
    CGSize size = self.showSize;
    pictureView = [[MulitAudioView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    pictureView.picture = self;
    pictureView.layer.cornerRadius = 6.0;
    
    return pictureView;
}
- (CGSize)showSize {
  
    return [self showSizeMaxWidth:(ScreenWidth - 2 * ROW_MARGIN)];
}

- (CGSize)showSizeMaxWidth:(CGFloat)maxWidth {
    CGSize size = CGSizeZero;
    if (self.pictureResource == PictureResourceImg) {
        size = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    } else if (self.pictureResource == PictureResourceVideo) {
        CGFloat width = maxWidth;
        CGFloat height = width * 0.48;
        size = CGSizeMake(width, height);
    } else if (self.pictureResource == PictureResourceAudio) {
        NSInteger audioTime = self.audioTime;
        CGFloat height = 44.0;
        size = CGSizeMake(MAX(110.0, 200.0 * (audioTime / Pro_Audio_Max_Time)), height);
        
    }
    return size;
}

@end
