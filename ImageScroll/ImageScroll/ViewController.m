//
//  ViewController.m
//  ImageScroll
//
//  Created by 张三松 on 2017/3/23.
//  Copyright © 2017年 张三松. All rights reserved.
//

#import "ViewController.h"
#import "ScrollImageView.h"
@interface ViewController ()

@property (nonatomic, strong) ScrollImageView *imageScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];

    [self.view addSubview:self.imageScrollView];
}


- (ScrollImageView *)imageScrollView {
    if (!_imageScrollView) {
        _imageScrollView = [[ScrollImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
        _imageScrollView.dataSourArray = [@[@"img01",@"img02",@"img03",@"img04"]mutableCopy];
    }
    return _imageScrollView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
