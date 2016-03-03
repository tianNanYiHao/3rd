//
//  AppDelegate.m
//  iPadFirstBlood
//
//  Created by JCQ on 15/10/13.
//  Copyright (c) 2015年 JCQ. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "ContentViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    LeftViewController    *left    = [[LeftViewController alloc] init];
    ContentViewController *content = [[ContentViewController alloc] init];
#warning Don't forget set delegate！
    left.delegate = content;
    
    UISplitViewController  *splitVC = [[UISplitViewController alloc] init];
    UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:left];
    UINavigationController *contNav = [[UINavigationController alloc] initWithRootViewController:content];
    
    /**
     *  设置viewControllers，这是一个装有UIViewController类型元素的数组
     *  （数组中可以装标签栏控制器、导航栏控制器、等UIViewController类型的石视图）
     *  数组元素只能是两个，
     *  第一个元素是隐藏在左边
     *  第二个元素在屏幕上显示
     */
    splitVC.viewControllers = @[leftNav, contNav];
    // 设置代理
    splitVC.delegate = content;
    
    // 设置侧滑的最大值，有最大限制的
//    splitVC.maximumPrimaryColumnWidth = 500.0f;
    // 设置侧滑的最小值
//    splitVC.minimumPrimaryColumnWidth = 10.0f;
    
    self.window.rootViewController = splitVC;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
