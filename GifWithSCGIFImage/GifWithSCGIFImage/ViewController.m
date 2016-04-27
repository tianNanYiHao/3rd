//
//  ViewController.m
//  GifWithSCGIFImage
//
//  Created by Aotu on 16/4/27.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "ViewController.h"
#import "SCGIFImageView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"1.gif" ofType:nil];
    NSData   *data = [NSData dataWithContentsOfFile:path];
    SCGIFImageView *imageGIFView = [[SCGIFImageView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.width)];
    [imageGIFView setData:data];
    [self.view addSubview:imageGIFView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
