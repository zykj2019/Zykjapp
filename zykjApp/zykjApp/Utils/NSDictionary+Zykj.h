//
//  NSDictionary+Zykj.h
//  zykjApp
//
//  Created by lyman on 2020/1/16.
//  Copyright © 2020 zoulixiang. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Zykj)

/**
 字典数组 + model数组 映射到 新的字典
 @param keysDict dic数组 @[@{models属性名: 目标字典key}....]
 @param models 模型数组
 @return  新的字典，@{keysDict的value: models.keiDict.key.....}
*/
+ (NSDictionary*) modelPropertiesFromDicts: (NSArray<NSDictionary *> *)keysDict andModels:(NSArray<NSObject *> *)models;

@end

NS_ASSUME_NONNULL_END
