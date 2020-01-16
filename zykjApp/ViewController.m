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
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(60, 60, 60, 60)];
    // Do any additional setup after loading the view, typically from a nib.
    [btn setTitle:@"push" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(60, 160, 60, 60)];
    // Do any additional setup after loading the view, typically from a nib.
    [btn2 setTitle:@"present" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    [self.view addSubview:btn2];
    
}

- (void)push{
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
    RouteVC *vc = [RouteVC new];
    
    [[ZykjRouter sharedRouter] pushTo: vc.class withDict:dict];
}

- (void)present{
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
    RouteVC *vc = [RouteVC new];
    
    [[ZykjRouter sharedRouter] presentVC: vc.class withDict:dict];
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
