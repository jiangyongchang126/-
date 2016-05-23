//
//  AreaSelectView.h
//  4A
//
//  Created by 全程恺 on 14-1-13.
//  Copyright (c) 2014年 danfort. All rights reserved.
//  地址选择器

#import <UIKit/UIKit.h>

@interface AreaSelectView : UIPickerView <UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray *_pickerArr; //原始数据源
    NSArray *_firstPickerArray;      //第一排数据
    NSArray *_secPickerArray;   //第二排数据
    NSArray *_thirdPickerArray;   //第二排数据
    NSInteger _firstRow, _secRow, _thirdRow;
    void (^_selectCity)(NSDictionary *, NSDictionary *, NSDictionary *);
}

@property (nonatomic, copy) NSString *cityName; //记录会话框中原本的城市名

- (instancetype)initWithSelectBlock:(void (^)(NSDictionary *, NSDictionary *, NSDictionary *))SelectCity;
@end
