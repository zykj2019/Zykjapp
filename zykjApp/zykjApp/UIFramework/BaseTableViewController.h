//
//  BaseTableViewController.h
//  zykjApp
//
//  Created by jsl on 2020/1/18.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate> {
     UITableView *_tableView;
}

///不马上设置tableview的代理 子类调用refreshNewTableViewData方法设置代理 当设置yes时候 需要后续调用- (void)refreshNewTableViewData 来刷新tableview
@property (assign, nonatomic) BOOL delayCreateTableView;

@property (strong, nonatomic) UITableView *tableView;

/**
 设置tableview代理 = self;
 配合着delayCreateTableView = yes使用
 */
- (void)refreshNewTableViewData;

@end

