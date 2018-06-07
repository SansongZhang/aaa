
//
//  ScrollImageView.m
//  ImageScroll
//
//  Created by 张三松 on 2017/3/23.
//  Copyright © 2017年 张三松. All rights reserved.
//

#import "ScrollImageView.h"
#import "CustomePageControl.h"

@interface ScrollImageView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) CGRect scrollViewFrame;

@property (nonatomic, strong) CustomePageControl *pageControl;

/**用与定时器中记录上一次的偏移量*/
@property (nonatomic, assign) CGFloat offsiteX;

/**处理后的数据源数组*/
@property (nonatomic, strong) NSMutableArray *imageDataSoureArray;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ScrollImageView

@synthesize dataSourArray = _dataSourArray;


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.scrollViewFrame = frame;
        
    }
    return self;
}

- (void)setUpScrollView {
    
    self.offsiteX = self.scrollView.frame.size.width;
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    self.pageControl.numberOfPages = self.dataSourArray.count;
    
    self.scrollView.contentSize = CGSizeMake(self.imageDataSoureArray.count * self.scrollViewFrame.size.width, self.scrollViewFrame.size.height);
    
    for (int i = 0; i < self.imageDataSoureArray.count; i++) {
        
        CGFloat w = i * self.scrollViewFrame.size.width;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(w, 0, self.scrollViewFrame.size.width, self.scrollViewFrame.size.height)];
        imageView.tag = 99 + i;
        imageView.backgroundColor = [UIColor greenColor];
        imageView.image = [UIImage imageNamed:self.imageDataSoureArray[i]];
        [self.scrollView addSubview:imageView];
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:NO];
    self.pageControl.currentPage = 0;
    
    [self addTimer];
}

//添加定时器
- (void)addTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

- (void)timerAction:(NSTimer *)timer {
    
    CGPoint offsite = self.scrollView.contentOffset;
    offsite.x = self.offsiteX + self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:offsite animated:YES];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self setupUIWithScrollView:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self setupUIWithScrollView:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
   
    if (self.timer) {
        
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!self.timer) {
        
        [self addTimer];
    }
}

- (void)setupUIWithScrollView:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (index == 0) {//显示为最后一张
        
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * (self.imageDataSoureArray.count - 2), 0) animated:NO];
        self.pageControl.currentPage = self.imageDataSoureArray.count - 2;
    }else  if (index == self.imageDataSoureArray.count - 1) {//显示为第一张
        
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0) animated:NO];
        self.pageControl.currentPage = 0;
        
    }else {
        
        self.pageControl.currentPage = index - 1;
    }
    self.offsiteX = scrollView.contentOffset.x;
}


- (void)setDataSourArray:(NSMutableArray *)dataSourArray {
    _dataSourArray = dataSourArray;
   
    if (dataSourArray.count) {
        
        [self.imageDataSoureArray addObject:dataSourArray.lastObject];
        [self.imageDataSoureArray addObjectsFromArray:dataSourArray];
        [self.imageDataSoureArray addObject:dataSourArray.firstObject];
        
        [self setUpScrollView];
    }
}



#pragma mark -- 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.scrollViewFrame];
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (CustomePageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[CustomePageControl alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width / 2 - 100, self.scrollView.frame.size.height - 30, 200, 30)];
        

    }
    return _pageControl;
}

- (NSMutableArray *)dataSourArray {
    if (!_dataSourArray) {
        _dataSourArray = [NSMutableArray array];
    }
    return _dataSourArray;
}

- (NSMutableArray *)imageDataSoureArray {
    if (!_imageDataSoureArray) {
        _imageDataSoureArray = [NSMutableArray array];
    }
    return _imageDataSoureArray;
}

@end
