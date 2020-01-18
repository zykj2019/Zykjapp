//
//  UIFramework.h
//  CommonLibrary
//
//  Created by Alexi on 13-11-6.
//  Copyright (c) 2013年 ywchen. All rights reserved.
//

#ifndef CommonLibrary_UIFramework_h
#define CommonLibrary_UIFramework_h


#define kSupportLibraryPage 0
#define kSupportPopupView 0
#define kSupportScrollController 0

// CommonLibrary中常用的字体
#define kCommonLargeTextFont       [UIFont systemFontOfSize:16]
#define kCommonMiddleTextFont      [UIFont systemFontOfSize:14]
#define kCommonSmallTextFont       [UIFont systemFontOfSize:12]

#define kTableViewMultipleTag      21
#define kTableViewNormalTag         0

#define kIconReturnTag        150

#import "ZYWeakTimerObject.h"

#import "CustomNav.h"
#import "ZykjRouter.h"

#import "UILabel+ND.h"
#import "UIViewController+ND.h"
#import "UIViewController+Layout.h"
#import "CommonBaseViewController.h"
#import "NavigationViewController.h"

#import "BaseViewController.h"

#if kSupportScrollController
#import "ScrollBaseViewController.h"
#import "BaseCollectionViewController.h"
#endif

#import "UIView+Layout.h"

#import "NSObject+loadPadClass.h"

#if kSupportPopupView
#import "PopupView.h"
#endif

#import "MenuAbleItem.h"
#import "MenuItem.h"

#import "KeyValue.h"

#import "PageScrollView.h"

#import "BaseAppDelegate.h"

// 过渡动画
#import "UINavigationController+Transition.h"

#import "KeyValue.h"

#import "BaseTableViewController.h"


#endif
