//
//  ViewController.m
//  zykjApp
//
//  Created by zoulixiang on 2018/3/14.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Common * m1 = [Common new];
    Common * m2 = [Common new];
    m1.key = @"kkkkkk1";
    m1.title = @"ttttttt1";
    m2.key = @"kkkkkkkkkkk2";
    
    
    NSDictionary *dic1 = @{
        @"key": @"KEY",
        @"title": @"TITLE"
    };
    NSDictionary *dic2 = @{
        @"key": @"KEY2"
    };
    
    NSDictionary* dict = [NSDictionary modelPropertiesFromDicts:@[dic1,dic2] andModels:@[m1,m2]];
    
    NSLog(@"wwww:%@",dict);
}

- (void)addOwnViews {
    [super addOwnViews];
    NSLog(@"addOwnViews");
}

- (void)configOwnViews
{
     NSLog(@"configOwnViews");
}


- (void)layoutSubviewsFrame {
     NSLog(@"layoutSubviewsFrame");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
