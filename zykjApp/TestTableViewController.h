//
//  TestTableViewController.h
//  zykjApp
//
//  Created by jsl on 2020/1/18.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ViewPagerController.h"
#import "BaseTableViewCell.h"

@interface TestTableViewCell : BaseTableViewCell

@property (strong, nonatomic) UILabel *titleLbl;

@property (strong, nonatomic) UILabel *contentLbl;
@end

@interface TestTableViewController : BaseTableViewController

@end

