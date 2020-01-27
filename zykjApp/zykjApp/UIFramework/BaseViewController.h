//
//  BaseViewController.h
//  SuperMama
//
//  Created by macbook on 15/7/7.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonBaseViewController.h"

@interface BaseViewController : CommonBaseViewController<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@end

///BaseRelativeViewController
@interface BaseRelativeViewController : BaseViewController

- (MyRelativeLayout *)myContentView;

@end



/// ///BaseRelativeViewController orientation：MyOrientation_Vert
@interface BaseLinearViewController : BaseViewController

- (MyLinearLayout *)myContentView;

@end


