//
//  ViewController.m
//  ScrollView循环滚动
//
//  Created by HC on 15/3/12.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "ViewController.h"
#import "HCScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *array = [NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg", nil];
    HCScrollView *hc = [[HCScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200) withImageArray:array];
    [self.view addSubview:hc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
