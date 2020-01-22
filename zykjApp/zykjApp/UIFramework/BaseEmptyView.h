//
//  BaseEmptyView.h
//  zykjApp
//
//  Created by DeerClass on 2020/1/22.
//  Copyright © 2020 zoulixiang. All rights reserved.
//  空页面全局

#import "BaseTableView.h"
#import "BaseTableViewCell.h"

@interface BaseEmptyItem : NSObject

@property (copy, nonatomic) NSString *title;

@property (strong, nonatomic) UIImage *emptyImage;

@property (copy, nonatomic) CommonVoidBlock resetRequestBlock;

- (instancetype)initWithTitle:(NSString *)title emptyImage:(UIImage *)emptyImage resetRequestBlock:(CommonVoidBlock)resetRequestBlock;

@end


@interface BaseEmptyTableViewCell : BaseRelativeTableViewCell

@property (strong, nonatomic) UILabel *titleLbl;

@property (strong, nonatomic) UIImageView *imgView;

@property (weak, nonatomic) BaseEmptyItem *baseEmptyItem;

@end

@interface BaseEmptyView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) BaseEmptyItem *baseEmptyItem;

+ (instancetype)initWithBaseEmptyItem:(BaseEmptyItem *)item;

@end

