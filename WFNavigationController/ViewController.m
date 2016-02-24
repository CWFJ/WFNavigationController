//
//  ViewController.m
//  WFNavigationController
//
//  Created by Jason on 16/2/24.
//  Copyright © 2016年 raydon. All rights reserved.
//

#import "ViewController.h"
#import "WFNavigationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnTestClicked:(UIButton *)sender {
//    ((WFNavigationController *)self.navigationController).testBar = YES;
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
}

@end
