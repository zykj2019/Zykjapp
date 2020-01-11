//
//  AllHeader.h
//  zykjApp
//
//  Created by zoulixiang on 2019/3/24.
//  Copyright © 2019年 zoulixiang. All rights reserved.
//

#ifndef AllHeader_h
#define AllHeader_h

//#import <Noarc/JSONKit.h>
//#import <Noarc/OpenUDID.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAsset.h>
#import "NoArcHeader.h"
#import "ExtHeader.h"
#import "UtilsHeader.h"
#import "HelperHeader.h"
#import "UIFramework.h"
#import "ViewsHeader.h"

#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#endif /* AllHeader_h */
