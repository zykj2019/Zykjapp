//
//  ContantHead.h
//  coreText-Label
//
//  Created by zoulixiang on 16/7/23.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#ifndef MYCoretext_ContantHead_h
#define MYCoretext_ContantHead_h

typedef NS_ENUM(NSInteger, GestureType) {
    
    TapGesType = 1,
    LongGesType,
    
};

#define DELAYEXECUTE(delayTime,func) (dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{func;}))

//#define kSelf_SelectedColor [UIColor colorWithWhite:0 alpha:0.4] //点击背景  颜色
#define kSelf_SelectedColor [UIColor clearColor] //点击背景  颜色

#define kUserName_SelectedColor [UIColor colorWithWhite:0 alpha:0.25]//点击姓名颜色

#define kLinkColor    UIColorFromRGB(0x3fb3ff)               //链接颜色

#define FAVORTAG    @"favortag"

#define limitline 4

#define PicItemPattern    @"<uschool>(.*?)</uschool>"

#define PlaceHolder @" "

#define AttributedImageNameKey      @"ImageName"

#define AttributedImageSizeKey      @"ImageSize"

#define offSet_x    12.0            //图文

#endif /* ContantHead_h */
