//
//  AppConfig.m
//  zykjApp
//
//  Created by zoulixiang on 2020/1/13.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig

- (UIFont *)baseFont:(CGFloat)size {
    
    return  IsIOS9Later ? [UIFont fontWithName:self.iOS9LaterBaseFontName size:size] : [UIFont systemFontOfSize:size];
}
@end
