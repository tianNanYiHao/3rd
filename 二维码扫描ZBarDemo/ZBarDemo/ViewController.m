//
//  ViewController.m
//  ZBarDemo
//
//  Created by 张诚 on 14/12/23.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import "ViewController.h"
#import "ZCZBarViewController.h"
//生成二维码
#import "QRCodeGenerator.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(100, 100, 100, 100);
    [button setTitle:@"扫描" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 200, 200)];
    
    //第一个参数是你生成二维码的文字，也就是别人扫描出来的结果，第二个参数是图像的清晰度
    imageView.image=[QRCodeGenerator qrImageForString:@"二维码生成" imageSize:300];
    [self.view addSubview:imageView];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)buttonClick{
ZCZBarViewController*vc=[[ZCZBarViewController alloc]initWithBlock:^(NSString *str, BOOL isSucceed) {
    
    if (isSucceed) {
        
        NSLog(@"%@",str);
        
    }else{
        
        NSLog(@"扫描失败");
        
    }
}];
    [self presentViewController:vc animated:YES completion:nil];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
