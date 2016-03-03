//
//  LeftViewController.h
//  iPadFirstBlood
//
//  Created by JCQ on 15/10/13.
//  Copyright (c) 2015年 JCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftDelegate <NSObject>

- (void)sendValue:(NSString *)text;

@end

@interface LeftViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) id <LeftDelegate> delegate;

@end
