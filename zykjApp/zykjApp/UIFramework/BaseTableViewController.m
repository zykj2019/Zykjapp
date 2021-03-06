//
//  BaseTableViewController.m
//  zykjApp
//
//  Created by jsl on 2020/1/18.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableView.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

#pragma mark - 重写
- (void)configContainer {
    [super configContainer];
    
    if (!self.hiddenNav && self.navigationController) {
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeTop;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
}

- (UIView *)addMyContentView {
    UIView *myContentView = [super addMyContentView];
    if ([myContentView isKindOfClass:MyBaseLayout.class]) {
        MyBaseLayout *tmyContentView = (MyBaseLayout *)myContentView;
        tmyContentView.insetsPaddingFromSafeArea = UIRectEdgeNone;
    }
    return myContentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addOwnViews {
    [super addOwnViews];

     [self addMyTableView];
   
}

#pragma mark - public
//手动创建tableview
- (void)addMyTableView {
    [_tableView removeFromSuperview];
    
    _tableView = [BaseTableView customInst];
    _tableView.widthSize.equalTo(self.myContentView.widthSize);
    _tableView.heightSize.equalTo(self.myContentView.heightSize);
    
    if (!_delayCreateTableView) {
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    [self.myContentView addSubview:_tableView];
    
}

-(void)refreshNewTableViewData {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0;
}

@end

