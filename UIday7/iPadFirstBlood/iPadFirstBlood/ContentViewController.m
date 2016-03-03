//
//  ContentViewController.m
//  iPadFirstBlood
//
//  Created by JCQ on 15/10/13.
//  Copyright (c) 2015年 JCQ. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()
{
    UILabel                 *_label;
    UIPopoverController     *_splitPC;
    
    /** 学习pop的 */
    UIPopoverController     *_studyPop;
}
@end

// iPad屏幕尺寸是 {768, 1024}
@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    
    self.view.backgroundColor = [UIColor greenColor];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, self.view.frame.size.width - 60, 40)];
    _label.font = [UIFont systemFontOfSize:28.0f];
    _label.text = @"等着cell被揍吧！";
    _label.textColor = [UIColor blackColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, self.view.frame.size.width - 200, 80)];
    btn.backgroundColor = [UIColor redColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:25.0f];
    [btn setTitle:@"等着被临幸吧！" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick:(UIButton *)btn {
    // 初始化 UIPopoverController，需要一个UIViewController
    UIViewController *vc    = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor yellowColor];
    
    _studyPop = [[UIPopoverController alloc] initWithContentViewController:vc];
    // 设置popover的大小
    _studyPop.popoverContentSize = CGSizeMake(200, 200);
    
    /**
     *  POPover呈现方法
     *
     *  @param presentPopoverFromRect 以inView后面View的frame规划箭头的位置，简单考虑，写rect.origin来控制，rect.size写(0, 0)
     *  @param inView 在哪个视图上显示
     *  @param permittedArrowDirections 设置箭头的朝向
     */
    [_studyPop presentPopoverFromRect:CGRectMake(50, 10, 0, 0) inView:btn permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    
    _studyPop.delegate = self;
}

#pragma mark -- UISplitViewControllerDelegate --
/**
 *  在split界面加载之前调用的方法
 *
 *  @param svc             splitViewController   （例子中AppDelegate中创建的）
 *  @param aViewController 将要隐藏在左边的视图控制器 （例子中的leftNav）
 *  @param barButtonItem   代理方法提供的按钮,点击此按钮后可隐藏或显示左边视图(leftNav)
 *  @param pc              这是iPad编程中~独有~的控件，用它可以控制左边视图的隐藏([pc dismissPopoverAnimated:YES];) 和弹出 (弹出一般不建议使用)
 */
- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    // 设置左侧弹出按钮
    barButtonItem.title = @"Left";
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    _splitPC = pc;
}

#pragma mark LeftDelegate Method
- (void)sendValue:(NSString *)text {
    _label.text = text;
    
    // Popover隐藏的方法，点击cell隐藏左侧视图
    [_splitPC dismissPopoverAnimated:YES];
}

#pragma mark UIPopoverControllerDelegate
// 当POPover消失的时候调用此方法
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    NSLog(@"-BOOM-ShaKaLaKa-");
    
    // 全部置 nil，省内存
    _studyPop.delegate = nil;
    _studyPop = nil;
}

@end
