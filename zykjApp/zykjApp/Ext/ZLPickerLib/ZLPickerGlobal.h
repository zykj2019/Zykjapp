//
//  ZLPickerGlobal.h
//  ZykjAppClient
//
//  Created by jsl on 2019/12/3.
//  Copyright © 2019 zoulixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 全局存储值 为了避免透过很多层获取值或者设置值
@interface ZLPickerGlobal : NSObject

// 是否显示原图发送
@property (nonatomic , assign) BOOL isShowOriginalFileSend;

//是否当前选择原图发送
@property (nonatomic , assign) BOOL isOriginalFileSend;

+ (ZLPickerGlobal *)sharedInstance;

@end

