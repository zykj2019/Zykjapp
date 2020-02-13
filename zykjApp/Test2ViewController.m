//
//  Test2ViewController.m
//  zykjApp
//
//  Created by zoulixiang on 2020/1/27.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "Test2ViewController.h"

@interface Test2ViewController ()

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)addOwnViews {
    [super addOwnViews];
    self.myContentView.subviewSpace = 5;
    self.myContentView.orientation = MyOrientation_Horz;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kRedColor;
    view.mySize = CGSizeMake(100, 100);
    [self.myContentView addSubview:view];
    
    view = [[UIView alloc] init];
    view.backgroundColor = kGreenColor;
//    view.mySize = CGSizeMake(100, 100);
    view.weight = 1;
    view.myHeight = 100;
    [self.myContentView addSubview:view];
    
}

@end
