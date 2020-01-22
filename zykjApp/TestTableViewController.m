//
//  TestTableViewController.m
//  zykjApp
//
//  Created by jsl on 2020/1/18.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "TestTableViewController.h"
#import "LineView.h"
#import "MyAudioViewController.h"
#import "WKWebViewController.h"
#import "BaseEmptyView.h"


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
    [super configParams];
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
//    self.delegate = self;
//    self.dataSource = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    lineView = [[LineView alloc] init];
//    lineView.backgroundColor = kRedColor;
//    lineView.myHeight = 2.0;
//    lineView.leftPos.equalTo(self.view.leftPos).offset(20);
//    lineView.rightPos.equalTo(self.view.rightPos).offset(20);
//    lineView.bottomPos.equalTo(self.view.bottomPos).offset(20);
//    [self.view addSubview:lineView];
////    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.bottom.right.mas_equalTo(self.view);
////        make.height.mas_equalTo(20);
////    }];
//    
//    LineView *line = [[LineView alloc] init];
//    line.frame = CGRectMake(0, 100, 100, 100);
//    [self.view addSubview:line];
    self.tableView.estimatedRowHeight = 60;
       self.tableView.rowHeight = UITableViewAutomaticDimension;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    WKWebViewController *dst = [[WKWebViewController alloc] init];
    [dst loadWebURLSring:@"http://www.baidu.com"];
//    [self presentViewController:dst animated:YES completion:nil];
    [self.navigationController pushViewController:dst animated:YES];
}
#pragma mark - UITableViewDataSource
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     BaseEmptyItem *baseEmptyItem = [[BaseEmptyItem alloc] initWithTitle:@"dfdfdf" emptyImage:nil resetRequestBlock:nil];
    BaseEmptyTableViewCell *cell = [BaseEmptyTableViewCell cellWithTableView:tableView];
    cell.baseEmptyItem = baseEmptyItem;
  
//    [cell layouts];
    CGSize size = [cell.rootLayout sizeThatFits:CGSizeMake(tableView.frame.size.width, 0)];
   
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
      NSLog(@"%.2f",tableView.width);
       return UITableViewAutomaticDimension;
}


#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    
    return 1;
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"wwwww";
    label.textColor = kBlueColor;
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    UIViewController *dst = [[UIViewController alloc] init];
    dst.view.backgroundColor = kRedColor;
    return dst;
}

#pragma mark - ViewPagerDelegate

- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab: //0为开始时第一页；1为开始第二页
            return 0.0;
            break;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
            break;
        case ViewPagerOptionTabLocation:
            return 1.0;
            break;
        case ViewPagerOptionTabWidth:
            return ScreenWidth/4;
            break;
        case ViewPagerOptionCenterTabView:
            return 1.0;
            break;
        default:
            break;
    }
    
    return value;
}

- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            
            return kMainTextColor;
            break;
        case ViewPagerTabsView:
            
            return kNavColor;
            break;
        case ViewPagerTextIndicator:
            
            return kBlackColor;
            break;
        default:
            return color;
            break;
    }
    
}

@end
