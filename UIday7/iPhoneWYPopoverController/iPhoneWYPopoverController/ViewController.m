//
//  ViewController.m
//  iPhoneWYPopoverController
//
//  Created by JCQ on 15/10/13.
//  Copyright (c) 2015年 JCQ. All rights reserved.
//

#import "ViewController.h"
#import "WYPopoverController.h"
#import "ListViewController.h"

@interface ViewController () <WYPopoverControllerDelegate>
{
    WYPopoverController *_popover;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(60, 200, 200, 60)];
    btn.backgroundColor = [UIColor orangeColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    
    [btn setTitle:@"你TM点我啊!" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

// 点击按钮，跳出来popover
- (void)btnClick:(UIButton *)btn {
    ListViewController *vc = [[ListViewController alloc] init];
    
    // popover用 vc的preferredContentSize属性来约束自己的大小
    vc.preferredContentSize = CGSizeMake(200, 200);
    vc.view.backgroundColor = [UIColor redColor];
    
    // 创建popover
    _popover = [[WYPopoverController alloc] initWithContentViewController:vc];
    // 设置代理
    _popover.delegate = self;
    [_popover presentPopoverFromRect:CGRectMake(100, 0, 0, 0) inView:btn permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES];
}

#pragma mark -- WYPopoverControllerDelegate --
/**
 *  当点击朦层调用这个方法，返回YES可以隐藏，反之不行
 */
- (BOOL)popoverControllerShouldDismiss:(WYPopoverController *)popoverController
{
    return YES;
}

/**
 *  当popover消失的时候调用的方法
 */
- (void)popoverControllerDidDismiss:(WYPopoverController *)popoverController
{
    NSLog(@"看不见我~");
    
    // 写下面的2句，可以省内存
    _popover.delegate = nil;
    _popover = nil;
}

@end
