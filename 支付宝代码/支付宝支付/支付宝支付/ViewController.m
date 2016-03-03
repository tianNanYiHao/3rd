//
//  ViewController.m
//  支付宝支付
//
//  Created by qianfeng on 15/7/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"

// 支付信息配置文件
#import "PartnerConfig.h"

// 数据签名文件
#import "DataSigner.h"

// 订单
#import "Order.h"

// 支付sdk
#import <AlipaySDK/AlipaySDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10, 100, 300, 40);
    [btn setTitle:@"支付" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

#pragma  mark - 支付方法
-(void)pay
{
    
    NSString *partner = PartnerID; //支付宝分配给商户的ID
    NSString *seller = SellerID; //收款支付宝账号（用于收💰）
    NSString *privateKey = PartnerPrivKey; //商户私钥
    
    /*
     * 生成订单信息及签名
     */
    //将商品信息赋予Order的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner; //商户ID
    order.seller = seller; //收款支付宝账号
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = @"香蕉"; //商品标题
    order.productDescription = @"5斤香蕉"; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格(重要)
    order.notifyURL =  @"http://www.xxx.com"; //回调URL（通知服务器端交易结果）(重要)
    // 1777297988
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    // 应用注册scheme, 在AlipayDEMO-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey); //通过私钥创建签名
    NSString *signedString = [signer signString:orderSpec]; //将订单信息签名
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",  orderSpec, signedString, @"RSA"];
    }
    
    //支付订单，如果安装有支付宝钱包客户端则直接进入客户端，否则进入网页支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSLog(@"callback reslut = %@",resultDic);
        
    }];
    
}

#pragma mark   ============== 产生随机订单号 ==============
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
