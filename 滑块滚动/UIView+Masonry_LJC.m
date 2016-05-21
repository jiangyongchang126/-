//
//  UIView+Masonry_LJC.m
//  Dang
//
//  Created by 全程恺 on 15/5/7.
//  Copyright (c) 2015年 Danfort. All rights reserved.
//

#import "UIView+Masonry_LJC.h"
#import "Masonry.h"


@implementation UIView (Masonry_LJC)
- (void) distributeSpacingHorizontallyWith:(NSArray*)views
{
    UIView *firstView = views[0];
    
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(self);
        make.left.equalTo(self);
    }];
    
    UIView *lastView;
    for (int i = 1; i < views.count; i++) {
        
        if (!lastView) {
            
            lastView = firstView;
        }
        UIView *view = views[i];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(lastView.mas_right);
            make.width.top.bottom.equalTo(lastView);
            if (i == views.count - 1) {
                make.right.equalTo(self);
            }
        }];
        
        lastView = view;
    }
    
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(lastView);
    }];
    
    [self layoutSubviews];
}

- (void) distributeSpacingVerticallyWith:(NSArray*)views
{
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    
    for ( int i = 0 ; i < views.count+1 ; ++i )
    {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
    }
    
    
    UIView *v0 = spaces[0];
    
    __weak __typeof(&*self)ws = self;
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_top);
        make.centerX.equalTo(((UIView*)views[0]).mas_centerX);
    }];
    
    UIView *lastSpace = v0;
    for ( int i = 0 ; i < views.count; ++i )
    {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastSpace.mas_bottom);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(obj.mas_bottom);
            make.centerX.equalTo(obj.mas_centerX);
            make.height.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_bottom);
    }];
}



@end
