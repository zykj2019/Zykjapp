//
//  NavViewPagerController.m
//  ICNavViewPager
//
//  Created by zoulixiang on 16/6/30.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import "NavViewPagerController.h"

#define TABWIDTH    50
#define TABHEIGHT   42

@interface TabViews : UIView
@property (nonatomic, getter = isSelected) BOOL selected;
@property (nonatomic) UIColor *indicatorColor;
@property (strong, nonatomic) UILabel *label;

@end

@implementation TabViews

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        if (_label == nil) {
            _label = [[UILabel alloc] init];
            [_label setFont:[UIFont systemFontOfSize:13.0]];
            _label.textColor = [UIColor blackColor];
            [self addSubview:_label];
        }
       
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _label = [[UILabel alloc] init];
        [_label setFont:[UIFont systemFontOfSize:13.0]];
        _label.textColor = [UIColor blackColor];
        [self addSubview:_label];
    }
    return self;
}
- (void)setSelected:(BOOL)selected {
    _selected = selected;
    // Update view as state changed
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    
    if (self.selected) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [self.label setTextColor:self.indicatorColor];
        CGContextSetLineWidth(ctx, 3);
        CGContextMoveToPoint(ctx,0 , self.frame.size.height - 1.5);
        CGContextAddLineToPoint(ctx, self.frame.size.width, self.frame.size.height - 1.5);
        
        [self.indicatorColor set];
        CGContextStrokePath(ctx);
    } else {
        
        [self.label setTextColor:[UIColor blackColor]];
    }
   
}

@end
@interface NavViewPagerController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>{
    NSUInteger currentIndex;
}

@property (strong, nonatomic) NSMutableArray *tabsArray;
@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation NavViewPagerController

-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    _pageViewController.view.frame = self.view.bounds;
}
- (void)viewDidLoad {
   
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _tabsArray = [NSMutableArray array];
    
    NSInteger count = self.titleArray.count;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, count * TABWIDTH, TABHEIGHT)];
    topView.backgroundColor = [UIColor clearColor];
    topView.clipsToBounds = YES;
    
    for (int i = 0; i < count; i++) {
        
        TabViews *tabView = [[TabViews alloc] init];
        tabView.frame = CGRectMake(i * TABWIDTH, 0, TABWIDTH, TABHEIGHT);
        tabView.label.text = self.titleArray[i];
        tabView.indicatorColor = self.textColor;
        
        [tabView.label sizeToFit];
        [tabView.label setFrame:CGRectMake((TABWIDTH - tabView.label.frame.size.width)/2, (TABHEIGHT - tabView.label.frame.size.height)/2,tabView.label.frame.size.width , tabView.label.frame.size.height)];
        [topView addSubview:tabView];
        [_tabsArray addObject:tabView];
        tabView.tag = i;
        if (i == _defaultIndex) {
            tabView.selected =YES;
        }
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [tabView addGestureRecognizer:tapGestureRecognizer];
    }
    
    self.navigationItem.titleView = topView;
    
    
    [self initPageViewController];
   
    currentIndex = _defaultIndex;
    
    UIViewController *dst = _vcArray[0];
    
    [_pageViewController setViewControllers:@[dst] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)initPageViewController{
    
    //定义UIPageViewController
    if (_pageViewController == nil) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        _pageViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _pageViewController.view.bounds = self.view.bounds;
        [self.view addSubview:_pageViewController.view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
	
    
    TabViews *tabView = (TabViews *)sender.view;
    UIViewController *vc = _vcArray[tabView.tag];
    if (tabView.tag > currentIndex) {
        [_pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    } else {
        
        [_pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];

    }
    TabViews *oTabView = self.tabsArray[currentIndex];
    oTabView.selected = NO;
    
    tabView.selected = YES;
    currentIndex = [self.tabsArray indexOfObject:tabView];
    
}

- (NSUInteger)indexForViewController:(UIViewController *)viewController {
    
    return [_vcArray indexOfObject:viewController];
}

#pragma mark - UIPageViewControllerDataSource 页面手动切换的方法
//页面手动切换的方法
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexForViewController:viewController];
    if (index == _vcArray.count - 1) {
        return nil;
    }
    return _vcArray[++index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
     NSUInteger index = [self indexForViewController:viewController];
    if (index == 0) {
        return nil;
    }
    
    return _vcArray[--index];
}

#pragma mark - UIPageViewControllerDelegate  页面手动切换后的调用方法
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    UIViewController *viewController = self.pageViewController.viewControllers[0];
    TabViews *orgView = _tabsArray[currentIndex];
    orgView.selected = NO;
   currentIndex  = [self indexForViewController:viewController];
    TabViews *tabView = _tabsArray[currentIndex];
    tabView.selected = YES;
}


@end
