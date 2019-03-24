//
//  DES3Util.h
//  3DES加密工具类
//

#import <Foundation/Foundation.h>


@interface DES3Util : NSObject

// 加密方法
+ (NSString*)encrypt:(NSString*)key input:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)key input:(NSString*)encryptText;

@end