//
//  ViewController.m
//  zykjApp
//
//  Created by zoulixiang on 2018/3/14.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "ViewController.h"
#import "BaseRestAPI.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
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
