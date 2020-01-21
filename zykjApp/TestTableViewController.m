//
//  TestTableViewController.m
//  zykjApp
//
//  Created by jsl on 2020/1/18.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "TestTableViewController.h"
#import "LineView.h"

@interface TestView : UIView

@end

@implementation TestView


@end

@implementation TestTableViewCell


@end

@interface TestTableViewController () {
    LineView *lineView;
}

@end

@implementation TestTableViewController

- (void)configParams {
    self.hiddenNav = YES;
}
// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return YES;
}
// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    [self.navigationController setNavigationBarHidden:YES];
    NSLog(@"%@",NSStringFromCGPoint(self.view.layer.anchorPoint));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lineView = [[LineView alloc] init];
    lineView.backgroundColor = kRedColor;
    lineView.myHeight = 2.0;
    lineView.leftPos.equalTo(self.view.leftPos).offset(20);
    lineView.rightPos.equalTo(self.view.rightPos).offset(20);
    lineView.bottomPos.equalTo(self.view.bottomPos).offset(20);
    [self.view addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.mas_equalTo(self.view);
//        make.height.mas_equalTo(20);
//    }];
    
    LineView *line = [[LineView alloc] init];
    line.frame = CGRectMake(0, 100, 100, 100);
    [self.view addSubview:line];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = [NSString stringWithFormat:@"wwwwwww"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}


@end
