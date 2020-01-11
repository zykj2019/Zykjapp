//
//  ZHCityPickerModel.m
//  CityPickerView
//
//  Created by Admin on 16/7/8.
//  Copyright © 2016年 王海军. All rights reserved.
//

#import "ZHCityPickerModel.h"

@implementation ZHCityPickerModel

-(NSString *)description {
    if (!_provinceId) {
        return nil;
    }
    
     NSString *areaStr;
    if (![_provinceId isEqualToString:_cityId]) {
        areaStr = [NSString stringWithFormat:@"%@|%@|%@",self.province,self.city,_district];
    } else {
        areaStr = [NSString stringWithFormat:@"%@|%@",self.province,_district];
    }
    return areaStr;
}

- (ZHCityPickerModel *)copyMe {
    if (!_provinceId) {
        return nil;
    }
    ZHCityPickerModel *cityModel = [[ZHCityPickerModel alloc] init];
    cityModel.cityId = _cityId;
     cityModel.province = _province;
     cityModel.city = _city;
     cityModel.district = _district;
     cityModel.provinceId = _provinceId;
     cityModel.districtId = _districtId;
    return cityModel;
}

@end
