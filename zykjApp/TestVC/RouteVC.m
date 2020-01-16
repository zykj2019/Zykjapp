//
//  RouteVC.m
//  zykjApp
//
//  Created by lyman on 2020/1/16.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "RouteVC.h"

@interface RouteVC ()

@end

@implementation RouteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 99, 140, 40)];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 130, 140, 40)];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 180, 140, 40)];
    
    lab1.text = self.KEY;
    lab2.text = self.KEY2;
    lab.text = self.TITLE;
    
    [self.view addSubview:lab];
    [self.view addSubview:lab1];
    [self.view addSubview:lab2];
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
