//
//  WFNavigationController.m
//  WFNavigationController
//
//  Created by Jason on 16/2/24.
//  Copyright © 2016年 raydon. All rights reserved.
//

#import "WFNavigationController.h"
#import "WFHookTool.h"
#import "WFNavigationBar.h"

@interface WFNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate, UINavigationBarDelegate>
@property (nonatomic, strong) WFNavigationBar *currBar;
@end

static UINavigationController *_selfController;
#define ASS_KEY @"NavgationBar"

@implementation WFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _selfController = self;
    
    [WFHookTool hookInstanceSEL:@selector(viewWillAppear:) dstClass:[UIViewController class] hookSEL:@selector(topContollerWillAppear:) hookClass:[self class]];
    [WFHookTool hookInstanceSEL:@selector(viewDidAppear:) dstClass:[UIViewController class] hookSEL:@selector(topContollerDidAppear:) hookClass:[self class]];
    
    [WFHookTool hookInstanceSEL:@selector(viewWillDisappear:) dstClass:[UIViewController class] hookSEL:@selector(topContollerWillDisappear:) hookClass:[self class]];
    [WFHookTool hookInstanceSEL:@selector(viewDidLoad) dstClass:[UIViewController class] hookSEL:@selector(topContollerDidLoad) hookClass:[self class]];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UINavigationBar *)navigationBar {
    if(!_currBar) {
        return [super navigationBar];
    }
    else {
        return _currBar;
    }
}
-(void)topContollerDidAppear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    
    WFNavigationBar *currBar = (WFNavigationBar *)objc_getAssociatedObject(self, ASS_KEY);
    if(!currBar) return;
    
    [currBar removeFromSuperview];
    [self.view.superview addSubview:currBar];
}

-(void)topContollerDidLoad {
    NSLog(@"%s", __FUNCTION__);
    [_selfController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj == self) {
            if(![_selfController valueForKey:@"currBar"]) {
                WFNavigationBar *currBar = (WFNavigationBar *)objc_getAssociatedObject(self, ASS_KEY);
                if(!currBar) {
                    currBar = (WFNavigationBar *)_selfController.navigationBar;
                    objc_setAssociatedObject(self, ASS_KEY, currBar, OBJC_ASSOCIATION_RETAIN);
                }
                [_selfController setValue:currBar forKey:@"currBar"];
            }
            else
            {
                WFNavigationBar *currBar = (WFNavigationBar *)objc_getAssociatedObject(self, ASS_KEY);
                if(!currBar) {
                    currBar = [[WFNavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
                    objc_setAssociatedObject(self, ASS_KEY, currBar, OBJC_ASSOCIATION_RETAIN);
                }
                [_selfController setValue:currBar forKey:@"currBar"];
            }
        }
    }];
}

-(void)topContollerWillAppear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [_selfController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj == self) {
            WFNavigationBar *currBar = (WFNavigationBar *)objc_getAssociatedObject(self, ASS_KEY);
            if(!currBar) {
                currBar = [[WFNavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
                objc_setAssociatedObject(self, ASS_KEY, currBar, OBJC_ASSOCIATION_RETAIN);
            }
            [_selfController setValue:currBar forKey:@"currBar"];
            [currBar removeFromSuperview];
            [self.view addSubview:currBar];
        }
    }];
}

- (void)topContollerWillDisappear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    WFNavigationBar *currBar = (WFNavigationBar *)objc_getAssociatedObject(self, ASS_KEY);
    if(!currBar) return;
    
    [currBar removeFromSuperview];
    [self.view addSubview:currBar];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [super pushViewController:viewController animated:animated];
}
@end
