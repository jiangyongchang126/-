//
//  CommonTopScrollView.h
//  crc
//
//  Created by 全程恺 on 15/1/8.
//  Copyright (c) 2015年 Danfort. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIView+Masonry_LJC.h"


@interface BaseTopControl : UIControl <UIScrollViewDelegate>
{
    UIImageView *_squreView;
}

@property (copy, nonatomic) void (^SelectBlock)(NSInteger);
@property (assign, nonatomic) NSInteger selectIndex;
@property (assign, nonatomic) NSInteger count;

- (instancetype)initWithTitles:(NSArray *)titles;

@end