//
//  ZLPickerGlobal.m
//  ZykjAppClient
//
//  Created by jsl on 2019/12/3.
//  Copyright © 2019 zoulixiang. All rights reserved.
//

#import "ZLPickerGlobal.h"
static ZLPickerGlobal *_ZLPickerGlobal;

@implementation ZLPickerGlobal

+ (ZLPickerGlobal *)sharedInstance {
    static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
           _ZLPickerGlobal = [[ZLPickerGlobal alloc] init];
       });
       return _ZLPickerGlobal;
}

@end
