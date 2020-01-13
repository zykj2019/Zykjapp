//
//  ViewPagerController.m
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "ViewPagerController.h"

// TabView for tabs, that provides un/selected state indicators
@class TabView;

@implementation ViewPagerScrollView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIBezierPath *bezierPath;
    bezierPath = [UIBezierPath bezierPath];
    CGPoint beginPoint = CGPointMake(rect.origin.x, CGRectGetMaxY(rect) - 0.5);
    [bezierPath moveToPoint:beginPoint];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - 0.5)];
    [bezierPath setLineWidth:1.0];
    [kDefaultTabsViewBottomLineColor setStroke];
    [bezierPath stroke];
    
}
@end

@implementation TabView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)setSelected:(BOOL)selected {
    _selected = selected;
    // Update view as state changed
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.tabViewContent.center = CGPointMake(CGRectGetWidth(frame) / 2.0, CGRectGetHeight(frame) / 2.0);
}


- (void)drawRect:(CGRect)rect {
    
//    UIBezierPath *bezierPath;
    
    
    // Draw top line
    
    //    bezierPath = [UIBezierPath bezierPath];
    //    [bezierPath moveToPoint:CGPointMake(0.0, 0.0)];
    //    [bezierPath addLineToPoint:CGPointMake(rect.size.width, 0.0)];
    //    [[UIColor colorWithWhite:197.0/255.0 alpha:0.75] setStroke];
    //    [bezierPath setLineWidth:1.0];
    //    [bezierPath stroke];
    
    // Draw bottom line
    //    bezierPath = [UIBezierPath bezierPath];
    //    [bezierPath moveToPoint:CGPointMake(0.0, rect.size.height)];
    //    [bezierPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    //    [[UIColor colorWithWhite:197.0/255.0 alpha:0.75] setStroke];
    //    [bezierPath setLineWidth:1.0];
    //    [bezierPath stroke];
    
  
    // Draw an indicator line if tab is selected
//    if (self.selected) {
//        
//        bezierPath = [UIBezierPath bezierPath];
//        
//        if (_tabBottomModel == 0) {
//            //            Draw the indicator
//            [bezierPath moveToPoint:CGPointMake(0.0, rect.size.height-1)];
//            [bezierPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height -1)];
//            [bezierPath setLineWidth:2.0];
//        } else if (_tabBottomModel == 1.0) {
//            //默认
//            CGFloat lineW = 12.0;
//            CGFloat lineX = (self.width - lineW) / 2.0;
//            CGFloat lineY = self.height - 5.0 - 1.5;
//            bezierPath.lineCapStyle = kCGLineCapRound;
//            [bezierPath moveToPoint:CGPointMake(lineX, lineY)];
//            [bezierPath addLineToPoint:CGPointMake(lineW + lineX, lineY)];
//            [bezierPath setLineWidth:3.0];
//        }
//        
//        [self.indicatorColor setStroke];
//        [bezierPath stroke];
//    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tabViewContent.center = CGPointMake(self.width / 2.0, self.tabViewContent.height / 2.0 + 8.0);
}
@end


// ViewPagerController
@interface ViewPagerController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate> {
    UISwipeGestureRecognizer *swipeGestureRecognizer;
    unsigned long long _currentClickTime;
}

@property UIPageViewController *pageViewController;
@property (assign) id<UIScrollViewDelegate> origPageScrollViewDelegate;

@property ViewPagerScrollView *tabsView;
@property UIView *contentView;

@property (strong, nonatomic) UIView *tabsBottomLine;

@property NSMutableArray *tabs;
@property NSMutableArray *contents;

@property NSUInteger tabCount;
@property (getter = isAnimatingToTab, assign) BOOL animatingToTab;

@property (nonatomic) NSUInteger activeTabIndex;
@property(nonatomic,strong) UIColor *textOrginColor;

@property (strong, nonatomic) UIView *customView;

@property (strong, nonatomic) UIView *indicatorView;

@end


@implementation ViewPagerController

-(void)dealloc {
    _pageViewController.dataSource = nil;
    _pageViewController.delegate = nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self defaultSettings];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self defaultSettings];
    }
    return self;
}
#pragma mark - View life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (_scroll == 2) {
        swipeGestureRecognizer =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        swipeGestureRecognizer.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:swipeGestureRecognizer];
        
        swipeGestureRecognizer =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        swipeGestureRecognizer.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:swipeGestureRecognizer];
    }
    
    [self reloadData];
}
- (void)viewWillLayoutSubviews {
    
    CGRect frame;
    CGFloat baseY = self.topToViewMargin;
    //    CGFloat baseY = 0.0;
    
    frame = _tabsView.frame;
    CGFloat  tabsWidth = _customView ? (self.view.bounds.size.width - _customView.frame.size.width)  : self.view.bounds.size.width;
    frame.origin.x = 0.0;
    frame.origin.y = self.tabLocation ? baseY + _tabTop : self.view.frame.size.height - self.tabHeight - _tabTop;
    frame.size.width = tabsWidth;
    frame.size.height = self.tabHeight;
    _tabsView.frame = frame;
    
    if (_customView) {
        frame = _customView.frame;
        frame.origin.x =  _tabsView.frame.size.width;
        frame.origin.y = _tabsView.frame.origin.y;
        frame.size.height = self.tabHeight;
        _customView.frame = frame;
    }
    
    frame = _tabsBottomLine.frame;
    frame.origin.x = 0.0;
    frame.origin.y = CGRectGetMaxY(_tabsView.frame) - BottomLineHeight;
    frame.size.width = self.view.bounds.size.width;
    frame.size.height = BottomLineHeight;
    _tabsBottomLine.frame = frame;
    
    frame = _contentView.frame;
    frame.origin.x = 0.0;
    //    frame.origin.y = self.tabLocation ? baseY + self.tabHeight + self.contentTop : self.contentTop + baseY;
    frame.origin.y = self.tabLocation ? CGRectGetMaxY(_tabsView.frame) + self.contentTop : self.contentTop + baseY;
    frame.size.width = self.view.bounds.size.width;
    frame.size.height = self.tabLocation ? self.view.frame.size.height - frame.origin.y : self.view.frame.size.height -CGRectGetMinY(_tabsView.frame);
    _contentView.frame = frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_scroll) {
        ((UIScrollView*)[_pageViewController.view.subviews objectAtIndex:0]).scrollEnabled = NO;
    }
}
- (void)leftScroll {
    NSInteger index =  _activeTabIndex - 1;
    if (index < 0) {
        index = 0;
    }
    
   [self scrollIndex:index animated:YES];
    
}

- (void)rightScroll {
    NSInteger index =  _activeTabIndex + 1;
    if (index > self.tabs.count - 1) {
        index = self.tabs.count - 1;
    }
    [self scrollIndex:index animated:YES];
}

- (IBAction)scrollIndex:(NSInteger)index animated:(BOOL)animated {
    
    self.animatingToTab = YES;
    
    // Get the desired page's index
    
    // Get the desired viewController
    UIViewController *viewController = [self viewControllerAtIndex:index];
    
    // __weak pageViewController to be used in blocks to prevent retaining strong reference to self
    __weak UIPageViewController *weakPageViewController = self.pageViewController;
    __weak ViewPagerController *weakSelf = self;
    
    if (index < self.activeTabIndex) {
        [self.pageViewController setViewControllers:@[viewController]
                                          direction:UIPageViewControllerNavigationDirectionReverse
                                           animated:animated
                                         completion:^(BOOL completed) {
                                             //                                              weakSelf.animatingToTab = NO;
                                             weakSelf.animatingToTab = weakSelf.centerTabView ? YES : NO;
                                             
                                             // Set the current page again to obtain synchronisation between tabs and content
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [weakPageViewController setViewControllers:@[viewController]
                                                                                  direction:UIPageViewControllerNavigationDirectionReverse
                                                                                   animated:NO
                                                                                 completion:nil];
                                             });
                                         }];
    } else if (index > self.activeTabIndex) {
        [self.pageViewController setViewControllers:@[viewController]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:animated
                                         completion:^(BOOL completed) {
                                             //                                             weakSelf.animatingToTab = NO;
                                             weakSelf.animatingToTab = weakSelf.centerTabView ? YES : NO;
                                             
                                             // Set the current page again to obtain synchronisation between tabs and content
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [weakPageViewController setViewControllers:@[viewController]
                                                                                  direction:UIPageViewControllerNavigationDirectionForward
                                                                                   animated:NO
                                                                                 completion:nil];
                                             });
                                         }];
    }
    
    // Set activeTabIndex
    self.activeTabIndex = index;
}


- (IBAction)handleTapGesture:(id)sender {
    
    unsigned long long currentClickTime = [[NSDate date] timeIntervalSince1970] * 1000;
    if (currentClickTime - _currentClickTime < 450) {
        return;
    }
    _currentClickTime = currentClickTime;
    
    self.animatingToTab = YES;
    
    // Get the desired page's index
    UITapGestureRecognizer *tapGestureRecognizer = (UITapGestureRecognizer *)sender;
    UIView *tabView = tapGestureRecognizer.view;
    __block NSUInteger index = [_tabs indexOfObject:tabView];
    
    [self scrollIndex:index animated:YES];
}

#pragma mark -
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    
//    // Re-align tabs if needed
//    self.activeTabIndex = self.activeTabIndex;
//}

#pragma mark - target
- (void)swipe:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self rightScroll];
    } else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self leftScroll];
    }
}

#pragma mark - Setter/Getter //更改字体随着变色方法
- (void)setActiveTabIndex:(NSUInteger)activeTabIndex {
    
    TabView *activeTabView;
    
    UILabel *laber;
    // Set to-be-inactive tab unselected
    activeTabView = [self tabViewAtIndex:self.activeTabIndex];
    activeTabView.selected = NO;
    
    if ([[activeTabView.subviews lastObject] isKindOfClass:[UILabel class]] && _textOrginColor) {
        laber =  [activeTabView.subviews lastObject];
        laber.textColor =_textOrginColor;
        
    }
    // Set to-be-active tab selected
    activeTabView = [self tabViewAtIndex:activeTabIndex];
    
    activeTabView.selected = YES;
    
    if ([[activeTabView.subviews lastObject] isKindOfClass:[UILabel class]]) {
        laber = [activeTabView.subviews lastObject];
        
        _textOrginColor = laber.textColor;
        laber.textColor = self.indicatorTextColor;
        
    }
    
    // Set current activeTabIndex
    _activeTabIndex = activeTabIndex;
    
    // Inform delegate about the change
    if ([self.delegate respondsToSelector:@selector(viewPager:didChangeTabToIndex:)]) {
        [self.delegate viewPager:self didChangeTabToIndex:self.activeTabIndex];
    }
    
    // Bring tab to active position
    // Position the tab in center if centerCurrentTab option provided as YES
    
    UIView *tabView = [self tabViewAtIndex:self.activeTabIndex];
    CGRect frame = tabView.frame;
    
    if (self.centerCurrentTab) {
        
        frame.origin.x += (frame.size.width / 2);
        frame.origin.x -= _tabsView.frame.size.width / 2;
        frame.size.width = _tabsView.frame.size.width;
        
        if (frame.origin.x < 0) {
            frame.origin.x = 0;
        }
        
        if ((frame.origin.x + frame.size.width) > _tabsView.contentSize.width) {
            frame.origin.x = (_tabsView.contentSize.width - _tabsView.frame.size.width);
        }
    } else {
        
        if (!_centerTabView) {
            frame.origin.x -= self.tabOffset;
            frame.size.width = self.tabsView.frame.size.width;
        }
        
    }
    
    [_tabsView scrollRectToVisible:frame animated:YES];
    [self animationIndicatorView:_activeTabIndex animated:YES];
}

#pragma mark -
- (void)animationIndicatorView:(NSInteger)index animated:(BOOL)animated{

    if (self.tabs.count) {
        CGFloat width = 0.0;
        for (int i = 0; i < index+1; i++) {
            TabView *tabView =  self.tabs[index];
            width += index == i ? tabView.width / 2.0 : tabView.width;
        }
        if (animated) {
            [UIView animateWithDuration:0.2 animations:^{
                self.indicatorView.x = width - self.indicatorView.width / 2.0;
            }];
        } else {
            self.indicatorView.x = width - self.indicatorView.width / 2.0;
        }
    }
   
   
}

- (void)defaultSettings {
    
    // Default settings
    _tabHeight = kDefaultTabHeight;
    _tabOffset = kDefaultTabOffset;
    _tabWidth = kDefaultTabWidth;
    
    _tabLocation = kDefaultTabLocation;
    
    _startFromSecondTab = kDefaultStartFromSecondTab;
    
    _centerCurrentTab = kDefaultCenterCurrentTab;
    _tabFirstX = kDefaultTabX;
    // Default colors
    _indicatorColor = kDefaultIndicatorColor;
    _tabsViewBackgroundColor = kDefaultTabsViewBackgroundColor;
    _contentViewBackgroundColor = kDefaultContentViewBackgroundColor;
    _tabBottomModel = kTabBottomModel;
    
    // pageViewController
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:nil];
    
    //Setup some forwarding events to hijack the scrollview
    self.origPageScrollViewDelegate = ((UIScrollView*)[_pageViewController.view.subviews objectAtIndex:0]).delegate;
    [((UIScrollView*)[_pageViewController.view.subviews objectAtIndex:0]) setDelegate:self];
    
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    
    self.animatingToTab = YES;
}
- (void)reloadData {
    
    // Get settings if provided
    if (!self.delegate || !self.dataSource) {
        return;
    }
    [_tabsView removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(viewPager:valueForOption:withDefault:)]) {
        _tabHeight = [self.delegate viewPager:self valueForOption:ViewPagerOptionTabHeight withDefault:kDefaultTabHeight];
        _tabOffset = [self.delegate viewPager:self valueForOption:ViewPagerOptionTabOffset withDefault:kDefaultTabOffset];
        _tabTop =  [self.delegate viewPager:self valueForOption:ViewPagerOptionTabTop withDefault:kTabTop];
        _tabWidth = [self.delegate viewPager:self valueForOption:ViewPagerOptionTabWidth withDefault:kDefaultTabWidth];
        _tabFirstX = [self.delegate viewPager:self valueForOption:ViewPagerOptionFirstTabX withDefault:kDefaultTabX];
        _tabLocation = [self.delegate viewPager:self valueForOption:ViewPagerOptionTabLocation withDefault:kDefaultTabLocation];
        _contentTop = [self.delegate viewPager:self valueForOption:ViewPagerOptionContentTop withDefault:kContentTop];
        _startFromSecondTab = [self.delegate viewPager:self valueForOption:ViewPagerOptionStartFromSecondTab withDefault:kDefaultStartFromSecondTab];
        
        _centerCurrentTab = [self.delegate viewPager:self valueForOption:ViewPagerOptionCenterCurrentTab withDefault:kDefaultCenterCurrentTab];
        
        _centerTabView = [self.delegate viewPager:self valueForOption:ViewPagerOptionCenterTabView withDefault:kDefaultCenterTabView];
        _centerCurrentTab = _centerTabView ? 0.0 : _centerCurrentTab;
        _tabBottomModel = [self.delegate viewPager:self valueForOption:ViewPagerOptionTabBottomModel withDefault:kTabBottomModel];
    }
    
    // Get colors if provided
    if ([self.delegate respondsToSelector:@selector(viewPager:colorForComponent:withDefault:)]) {
        _indicatorColor = [self.delegate viewPager:self colorForComponent:ViewPagerIndicator withDefault:kDefaultIndicatorColor];
        _indicatorTextColor = [self.delegate viewPager:self colorForComponent:ViewPagerTextIndicator withDefault:nil];
        _indicatorTextColor = _indicatorTextColor ? _indicatorTextColor : _indicatorColor;
        _tabsViewBackgroundColor = [self.delegate viewPager:self colorForComponent:ViewPagerTabsView withDefault:kDefaultTabsViewBackgroundColor];
        _contentViewBackgroundColor = [self.delegate viewPager:self colorForComponent:ViewPagerContent withDefault:kDefaultContentViewBackgroundColor];
    }
    
    // Empty tabs and contents
    [_tabs removeAllObjects];
    [_contents removeAllObjects];
    
    _tabCount = [self.dataSource numberOfTabsForViewPager:self];
    
    // Populate arrays with [NSNull null];
    _tabs = [NSMutableArray arrayWithCapacity:_tabCount];
    for (int i = 0; i < _tabCount; i++) {
        [_tabs addObject:[NSNull null]];
    }
    
    _contents = [NSMutableArray arrayWithCapacity:_tabCount];
    for (int i = 0; i < _tabCount; i++) {
        [_contents addObject:[NSNull null]];
    }
    
    _customView = [self.delegate respondsToSelector:@selector(viewPagerForCustomView:)] ? [self.delegate viewPagerForCustomView:self] : nil;
    // Add tabsView
    CGFloat screenWidth = self.view.frame.size.width;
    CGRect tabsFrame = CGRectMake(0.0, 0.0, screenWidth, self.tabHeight);
    if (_customView) {
        CGRect customFrame = _customView.frame;
        tabsFrame = CGRectMake(0, 0, screenWidth - _customView.width, self.tabHeight);
        _customView.frame = CGRectMake(tabsFrame.size.width, 0, customFrame.size.width, self.tabHeight);
        [self.view insertSubview:_customView atIndex:0];
    }
    
    _tabsView = [[ViewPagerScrollView alloc] initWithFrame:tabsFrame];
    _tabsView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _tabsView.backgroundColor = self.tabsViewBackgroundColor;
    _tabsView.showsHorizontalScrollIndicator = NO;
    _tabsView.showsVerticalScrollIndicator = NO;
    
    [self.view insertSubview:_tabsView atIndex:0];
    
    
    //bottomLine
    [_tabsBottomLine removeFromSuperview];
    _tabsBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.5)];
    _tabsBottomLine.backgroundColor = kDefaultTabsViewBottomLineColor;
    
    //    [self.view addSubview:_tabsBottomLine];
    //    [self.view bringSubviewToFront:_tabsBottomLine];
    
    // Add tab views to _tabsView
    CGFloat contentSizeWidth = _tabFirstX;
    for (int i = 0; i < _tabCount; i++) {
        
        UIView *tabView = [self tabViewAtIndex:i];
        
        CGRect frame = tabView.frame;
        frame.origin.x = contentSizeWidth;
        
        CGFloat width = [self.delegate respondsToSelector:@selector(viewPager:tabWidthForTabAtIndex:)] ? [self.delegate viewPager:self tabWidthForTabAtIndex:i] : self.tabWidth;
        
        frame.size.width = width;
        tabView.frame = frame;
        
        [_tabsView addSubview:tabView];
        
        contentSizeWidth += tabView.frame.size.width;
        
        // To capture tap events
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [tabView addGestureRecognizer:tapGestureRecognizer];
    }
    
    _tabsView.contentSize = CGSizeMake(contentSizeWidth, self.tabHeight);
    
    if (_centerTabView) {
        CGFloat contentOffset = MAX(0, (_tabsView.frame.size.width - contentSizeWidth) / 2.0 );
        _tabsView.contentInset = UIEdgeInsetsMake(0, contentOffset, 0, -contentOffset);
    }
    
    // Add contentView
    _contentView = [self.view viewWithTag:kPageViewTag];
    
    if (!_contentView) {
        
        _contentView = _pageViewController.view;
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _contentView.backgroundColor = self.contentViewBackgroundColor;
        _contentView.bounds = self.view.bounds;
        _contentView.tag = kPageViewTag;
        
        [self.view insertSubview:_contentView atIndex:0];
    }
    
    // Set first viewController
    UIViewController *viewController;
    
    if (self.startFromSecondTab) {
        viewController = [self viewControllerAtIndex:1];
    } else {
        viewController = [self viewControllerAtIndex:0];
    }
    
    if (viewController == nil) {
        viewController = [[UIViewController alloc] init];
        viewController.view = [[UIView alloc] init];
    }
    
    [_pageViewController setViewControllers:@[viewController]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
    
    // Set activeTabIndex
    self.activeTabIndex = self.startFromSecondTab;
    
    self.animatingToTab = _centerTabView ? YES : NO;
    
    [self configIndicatorView];
}

//配置指示器
- (void)configIndicatorView {
    //指示器 默认
    [_indicatorView removeFromSuperview];
    _indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = self.indicatorColor;
  
    [self.tabsView addSubview:_indicatorView];
    
    //frame
    CGFloat y = self.tabsView.height - 2.0;
    CGFloat indicatorViewWidth = self.tabWidth;
    CGFloat indicatorViewHeight = 3.0;
    if (_tabBottomModel == 1.0) {
        y = self.tabsView.height - ((_tabHeight / kDefaultTabHeight) * 6.0) - indicatorViewHeight / 2.0;
        indicatorViewWidth = 25.0;
        _indicatorView.layer.cornerRadius = indicatorViewHeight / 2.0;
    }
    
    _indicatorView.frame = CGRectMake(0, y, indicatorViewWidth, indicatorViewHeight);
    
    [self animationIndicatorView:self.activeTabIndex animated:NO];
}

- (TabView *)tabViewAtIndex:(NSUInteger)index {
    
    if (index >= _tabCount) {
        return nil;
    }
    
    if ([[_tabs objectAtIndex:index] isEqual:[NSNull null]]) {
        
        // Get view from dataSource
        UIView *tabViewContent = [self.dataSource viewPager:self viewForTabAtIndex:index];
        
        // Create TabView and subview the content
        TabView *tabView = [[TabView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tabWidth, self.tabHeight)];
        
        [tabView addSubview:tabViewContent];
        tabView.tabViewContent = tabViewContent;
        
        [tabView setClipsToBounds:YES];
        [tabView setIndicatorColor:self.indicatorColor];
        
        tabViewContent.center = tabView.center;
        
        tabView.tabBottomModel = _tabBottomModel;
        
        // Replace the null object with tabView
        [_tabs replaceObjectAtIndex:index withObject:tabView];
    }
    
    return [_tabs objectAtIndex:index];
}
- (NSUInteger)indexForTabView:(UIView *)tabView {
    
    return [_tabs indexOfObject:tabView];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (index >= _tabCount) {
        return nil;
    }
    
    if ([[_contents objectAtIndex:index] isEqual:[NSNull null]]) {
        
        UIViewController *viewController;
        
        if ([self.dataSource respondsToSelector:@selector(viewPager:contentViewControllerForTabAtIndex:)]) {
            viewController = [self.dataSource viewPager:self contentViewControllerForTabAtIndex:index];
        } else if ([self.dataSource respondsToSelector:@selector(viewPager:contentViewForTabAtIndex:)]) {
            
            UIView *view = [self.dataSource viewPager:self contentViewForTabAtIndex:index];
            
            // Adjust view's bounds to match the pageView's bounds
            UIView *pageView = [self.view viewWithTag:kPageViewTag];
            view.frame = pageView.bounds;
            
            viewController = [UIViewController new];
            viewController.view = view;
        } else {
            viewController = [[UIViewController alloc] init];
            viewController.view = [[UIView alloc] init];
        }
        
        [_contents replaceObjectAtIndex:index withObject:viewController];
    }
    
    return [_contents objectAtIndex:index];
}
- (NSUInteger)indexForViewController:(UIViewController *)viewController {
    
    return [_contents indexOfObject:viewController];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:viewController];
    index++;
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:viewController];
    index--;
    return [self viewControllerAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    UIViewController *viewController = self.pageViewController.viewControllers[0];
    self.activeTabIndex = [self indexForViewController:viewController];
}

#pragma mark - UIScrollViewDelegate, Responding to Scrolling and Dragging
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.origPageScrollViewDelegate scrollViewDidScroll:scrollView];
    }
    
    if (![self isAnimatingToTab]) {
        UIView *tabView = [self tabViewAtIndex:self.activeTabIndex];
        
        // Get the related tab view position
        CGRect frame = tabView.frame;
        
        CGFloat movedRatio = (scrollView.contentOffset.x / scrollView.frame.size.width) - 1;
        frame.origin.x += movedRatio * frame.size.width;
        
        if (self.centerCurrentTab) {
            
            frame.origin.x += (frame.size.width / 2);
            frame.origin.x -= _tabsView.frame.size.width / 2;
            frame.size.width = _tabsView.frame.size.width;
            
            if (frame.origin.x < 0) {
                frame.origin.x = 0;
            }
            
            if ((frame.origin.x + frame.size.width) > _tabsView.contentSize.width) {
                frame.origin.x = (_tabsView.contentSize.width - _tabsView.frame.size.width);
            }
        } else {
            
            if (!_centerTabView) {
                frame.origin.x -= self.tabOffset;
                frame.size.width = self.tabsView.frame.size.width;
            }
            
        }
        
        [_tabsView scrollRectToVisible:frame animated:NO];
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.origPageScrollViewDelegate scrollViewWillBeginDragging:scrollView];
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.origPageScrollViewDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.origPageScrollViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.origPageScrollViewDelegate scrollViewShouldScrollToTop:scrollView];
    }
    return NO;
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.origPageScrollViewDelegate scrollViewDidScrollToTop:scrollView];
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.origPageScrollViewDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.origPageScrollViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

#pragma mark - UIScrollViewDelegate, Managing Zooming
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.origPageScrollViewDelegate viewForZoomingInScrollView:scrollView];
    }
    
    return nil;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.origPageScrollViewDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.origPageScrollViewDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.origPageScrollViewDelegate scrollViewDidZoom:scrollView];
    }
}

#pragma mark - UIScrollViewDelegate, Responding to Scrolling Animations
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.origPageScrollViewDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

@end
