//
//  ZHCityPickerView.h
//  CityPickerView
//
//  Created by Admin on 16/7/8.
//  Copyright © 2016年 王海军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHCityPickerModel.h"
#import "BRPickerViewMacro.h"

@protocol ZHCityPickerViewDelegate <NSObject>

- (void)pickerDidChange:(ZHCityPickerModel *)cityModel;

@end

@interface ZHCityPickerView : UIView

@property (nonatomic, strong) ZHCityPickerModel *cityModel;
@property (nonatomic, weak) id <ZHCityPickerViewDelegate> delegate;

/** 省 **/
@property (strong,nonatomic) NSArray *provinceList;

/** 市 **/
@property (strong,nonatomic) NSArray *cityList;
/** 区 **/
@property (strong,nonatomic) NSArray *districtsList;

- (instancetype)initWithDelegate:(id <ZHCityPickerViewDelegate>)delegate isHaveNavControler:(BOOL)isHaveNavControler;
- (void)showInView:(UIView *)view;
- (void)cancelPicker;

@end
