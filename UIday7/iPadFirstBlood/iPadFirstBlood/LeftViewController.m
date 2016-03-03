//
//  LeftViewController.m
//  iPadFirstBlood
//
//  Created by JCQ on 15/10/13.
//  Copyright (c) 2015年 JCQ. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController () 
{
    UITableView     *_tableView;
    NSMutableArray  *_dataArray;
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addData)];
    self.navigationItem.rightBarButtonItem = barItem;
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    [self.view addSubview:_tableView];
}

- (void)addData {
    // 拿到当前时间
    NSDate *date = [NSDate date];
    
    [_dataArray addObject:[NSString stringWithFormat:@"%@", date]];
    [_tableView reloadData];
}

#pragma mark UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate) {
        [_delegate sendValue:_dataArray[indexPath.row]];
    }
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
