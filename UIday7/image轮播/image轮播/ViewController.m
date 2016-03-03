//
//  ViewController.m
//  image轮播
//
//  Created by JCQ on 15/10/13.
//  Copyright (c) 2015年 JCQ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
{
    /**
     *  详情图（大的滚动视图）
     */
    UIScrollView    *_scrollView;
    /**
     *  索引图（最上面小的滚动视图）
     */
    UIScrollView    *_indexScrollView;
    /**
     *  下标
     */
    NSInteger       _index;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _index = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configUI];
}

- (void)configUI {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, 375, 500)];
    [self.view addSubview:_scrollView];
    
    NSArray *imagesArray = @[@"0", @"1", @"2", @"3"];
    
    for (NSInteger i = 0; i < imagesArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 500)];
        imageView.image = [UIImage imageNamed:imagesArray[i]];
        
        // 在对下面的图片进行缩放的时候，为了不影响其他的图片，需要将每张图片再放到一个小的scrollView上，将小scrollView放在大scrollView上
        UIScrollView *smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(i * 375, 0, 375, 500)];
        
        // 把每张图都添加到smallScrollView上
        [smallScrollView addSubview:imageView];
        
        smallScrollView.delegate = self;
        
        // 要实现缩放效果，必须设置最大、最小缩放比例
        smallScrollView.maximumZoomScale = 1.5;
        smallScrollView.minimumZoomScale = 0.5;
        
        // 设置可以翻页
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(375 * imagesArray.count, 500);
        [_scrollView addSubview:smallScrollView];
    }
    
    _scrollView.delegate = self;
    
    // 设置上面的索引图（小滚动视图）
    _indexScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 375, 150)];
    
    for (NSInteger i = 0; i < imagesArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100 * i, 0, 100, 150)];
        imageView.image = [UIImage imageNamed:imagesArray[i]];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100 + i;
        
        _indexScrollView.contentSize = CGSizeMake(100 * imagesArray.count, 150);
        [_indexScrollView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [imageView addGestureRecognizer:tap];
    }
    
    [self.view addSubview:_indexScrollView];
    
    // 三个按钮
    NSArray *titles=@[@"btn_prepage.png",@"btn_home.png",@"btn_nextpage.png"];
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30 + 130 * i, 610, 50, 50);
        btn.tag = 200 + i;
        [btn setBackgroundImage:[UIImage imageNamed:titles[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    // 给下面的scrollView添加2个手指请按手势，实现隐藏和现实的indexScrollView
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingersTap:)];
    [_scrollView addGestureRecognizer:tapTwo];
    
    // 设置默认为第一页
    self.navigationItem.title = [NSString stringWithFormat:@"第%ld页", _index + 1];
}
/**
 *  触摸上面小图
 */
- (void)tapClick:(UITapGestureRecognizer *)tap {
    // 获取用户触摸的图片
    UIImageView *imageView = (UIImageView *)tap.view;
    // 计算得出当前所在的页数
    _index = imageView.tag - 100;
    
    [_scrollView setContentOffset:CGPointMake(_index * 375, 0) animated:YES];
    
    // 更新标题
    self.navigationItem.title = [NSString stringWithFormat:@"第%ld页",_index+1];
}

/**
 *  点击三个按钮事件
 */
- (void)btnClick:(UIButton *)btn {
    // 如果是“上一页”按钮
    if (btn.tag == 200) {
        if (_index > 0) {
            _index --;
        }
    }
    // 如果是“下一页”按钮
    else if (btn.tag == 202) {
        if (_index < 3) {
            _index ++;
        }
    }
    // 如果是“主页”按钮
    else if (btn.tag == 201) {
        // 返回第一页
        _index = 0;
    }
    
    // 设置滚动视图的内容偏移量
    [_scrollView setContentOffset:CGPointMake(_index * 375, 0) animated:YES];
    
    // 更新标题
    self.navigationItem.title=[NSString stringWithFormat:@"第%ld页",_index+1];
}

/**
 *  两指双击图片
 */
- (void)twoFingersTap:(UITapGestureRecognizer *)tap {
    // 判断索引视图的 y坐标 是否处于显示状态，如果是，就将其向上移150高度
    if (_indexScrollView.frame.origin.x == 64) {
        [UIView animateWithDuration:0.25 animations:^{
            _indexScrollView.frame = CGRectMake(0, 64 - 150, 375, 150);
        }];
        
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            _indexScrollView.frame = CGRectMake(0, 64, 375, 150);
        }];
    }
}

#pragma mark -- UIScrollViewDelegate Method 
/**
 *  需要缩放的视图，默认第一个
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollView.subviews[0];
}

/**
 *  滚动大图时修改标题
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 根据滚动图片的偏移量计算现值显示的是第几页
    _index = scrollView.contentOffset.x / 375;
    
    // 更新标题
    self.navigationItem.title = [NSString stringWithFormat:@"第%ld页", _index + 1];
}

@end
