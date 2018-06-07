//
//  CustomePageControl.m
//  ImageScroll
//
//  Created by 张三松 on 2017/3/23.
//  Copyright © 2017年 张三松. All rights reserved.
//

#import "CustomePageControl.h"
#import "UIView+Frame.h"

@implementation CustomePageControl

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    return self;
}

- (void)updateDots {
    
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIView* dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {

            dot.size = CGSizeMake(10, 4);
            dot.layer.cornerRadius = 2;
            dot.y = floorf((self.bounds.size.height - 4) / 2.0);
        }else{
            
            dot.height = 1.5;
            dot.width = 10;
            dot.layer.cornerRadius = 0.75;
            dot.y = floorf((self.bounds.size.height - 1.5) / 2.0);
        }
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self updateDots];
}


- (void)setCurrentPage:(NSInteger)page {
   
    [super setCurrentPage:page];

    [self updateDots];
}

@end
