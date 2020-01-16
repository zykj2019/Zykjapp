//
//  NSDictionary+Zykj.m
//  zykjApp
//
//  Created by lyman on 2020/1/16.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "NSDictionary+Zykj.h"


@implementation NSDictionary (Zykj)


+ (NSDictionary*) modelPropertiesFromDicts: (NSArray<NSDictionary *> *)keysDict andModels:(NSArray<NSObject *> *)models {
    if (keysDict.count != models.count) {
        return nil;
    }
    NSMutableDictionary *paramdict = @{}.mutableCopy;
    for (int i = 0; i< keysDict.count; i++) {
        NSObject *model =  models[i];
        NSDictionary *dict = keysDict[i];
        
        NSArray<NSString *> *subkeys = dict.allKeys;
        for (int j = 0; j < subkeys.count; j++) {
            NSString *keyStr = subkeys[j];
            NSString *vcProName = dict[keyStr];
            vcProName = vcProName.length == 0 ? keyStr : vcProName;
            if (j == 0 && ([model isKindOfClass:NSString.class]
                           || [model isKindOfClass:NSArray.class]
                           || [model isKindOfClass:NSValue.class]
                           || [model isKindOfClass:NSNumber.class]
                           || [model isKindOfClass:NSDictionary.class])) {
                
                paramdict[vcProName] = model;
                break;
            }
            NSObject *subValue = [model valueForKey:keyStr];
            
            if (subValue) {
                paramdict[vcProName] = subValue;
            }
        }
    }
    return paramdict;
}

@end
