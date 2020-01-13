//
//  AppConfig.h
//  zykjApp
//
//  Created by zoulixiang on 2020/1/13.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfig : NSObject

@property (copy, nonatomic) NSString *iOS9LaterBaseFontName;

@property (copy, nonatomic) NSString *iOS9LaterBaseFontLightName;

@property (copy, nonatomic) NSString *iOS9LaterBaseFontMediumName;


- (UIFont *)baseFont:(CGFloat)size;

@end

