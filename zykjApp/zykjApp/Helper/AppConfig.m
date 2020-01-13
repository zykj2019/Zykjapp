//
//  AppConfig.m
//  zykjApp
//
//  Created by zoulixiang on 2020/1/13.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig

- (NSString *)iOS9LaterBaseFontName {
    return @"PingFangSC-Regular";
    
}

- (NSString *)iOS9LaterBaseFontLightName {
    return @"PingFangSC-Light";
    
}

- (NSString *)iOS9LaterBaseFontMediumName {
    return @"PingFangSC-Medium";
    
}
- (NSUInteger)appThemeHex {
    return 0x4bcda0;
}
- (UIFont *)baseFont:(CGFloat)size {
    
    return  IsIOS9Later ? [UIFont fontWithName:self.iOS9LaterBaseFontName size:size] : [UIFont systemFontOfSize:size];
}

- (UIFont *)baseFontLight:(CGFloat)size {
     return  IsIOS9Later ? [UIFont fontWithName:self.iOS9LaterBaseFontLightName size:size] : [UIFont systemFontOfSize:size];
}

- (UIFont *)baseFontMedium:(CGFloat)size {
    return  IsIOS9Later ? [UIFont fontWithName:self.iOS9LaterBaseFontMediumName size:size] : [UIFont systemFontOfSize:size];
}

- (UIImage *)defaultHeaderImg {
    return [UIImage imageNamed:@"defaultPic.png"];
}

- (UIImage *)defaultPicImg {
    return [UIImage imageNamed:@"defaultPic.png"];
}

- (UIImage *)iconRetunImg {
    return [UIImage imageNamed:@"return_action"];
}

- (UIImage *)iconRetunHighImg {
    return [UIImage imageNamed:@"return_action_high"];
}

- (CGFloat)viewMargin {
    return 15.0;
}

- (CGFloat)viewObjMargin {
    return 5.0;
}

- (CGFloat)bottomLineWidth {
    return 0.5;
}

- (CGFloat)bottomLineHeight {
    return 0.5;
}

- (CGFloat)bitsPerPixel {
    return 6.0;
}

- (CGFloat)videoWidth {
    return 960.0;
}

- (CGFloat)videoHeight {
    return 540;
}

- (CGFloat)videoMaxTime {
    return 300.0;
}

- (CGFloat)videoMinTime {
    return 300.0;
}
@end
