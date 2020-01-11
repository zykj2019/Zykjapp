//
//  BaseControl.h
//  ZykjAppWork
//
//  Created by jsl on 2019/7/24.
//  Copyright © 2019 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 - (void)addOwnViews
 解决先调用init 又调用initwithframe
 造成重复调用addOwnViews
 所以最好以后直接initwithframe
 */

@interface BaseControl : UIControl

@end


