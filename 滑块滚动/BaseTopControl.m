//
//  CommonTopScrollView.m
//  crc
//
//  Created by 全程恺 on 15/1/8.
//  Copyright (c) 2015年 Danfort. All rights reserved.
//

#import "BaseTopControl.h"

@implementation BaseTopControl

- (instancetype)initWithTitles:(NSArray *)titles
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _squreView = [UIImageView new];
        _squreView.backgroundColor =[UIColor blueColor];
        [self addSubview:_squreView];
        
        self.count = titles.count;
        
        NSMutableArray *btns = [NSMutableArray array];
        for (int i = 0; i < titles.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            btn.tag = i+1;
            [btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [btns addObject:btn];
        }
        
        [self distributeSpacingHorizontallyWith:btns];
    }
    
    return self;
}

#pragma mark - action
- (void)selectAction:(UIButton *)btn
{
    for (int i = 1; i < self.count+1; i++) {
        
        UIButton *botton = (UIButton *)[self viewWithTag:i];
        botton.selected = NO;
    }
    
    btn.selected = YES;
    
    CGFloat width = [btn.titleLabel.text sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(1000, 1000)].width;
    [_squreView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self);
        make.height.mas_equalTo(@2);
        make.centerX.equalTo(btn);
        make.width.mas_equalTo(width + 10);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
       
        [self layoutIfNeeded];
    }];
    
    _selectIndex = btn.tag - 1;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    
    UIButton *btn = [self viewWithTag:selectIndex + 1];
    [self selectAction:btn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
