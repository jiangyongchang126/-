//
//  AreaSelectView.m
//  4A
//
//  Created by 全程恺 on 14-1-13.
//  Copyright (c) 2014年 danfort. All rights reserved.
//

#import "AreaSelectView.h"

#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2

@implementation AreaSelectView

- (id)initWithSelectBlock:(void (^)(NSDictionary *, NSDictionary *, NSDictionary *))SelectCity
{
    self = [super init];
    if (self) {
        // Initialization code
        
        NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Area" ofType:@"plist"];
        
        _pickerArr = [NSArray arrayWithContentsOfFile:plistPath];
        
        _selectCity = SelectCity;
        [self reloadData];
        
        self.showsSelectionIndicator = YES;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)reloadData
{
    _firstPickerArray = _pickerArr;
    _secPickerArray = _firstPickerArray[_firstRow][@"area_city"];
    _thirdPickerArray = _secPickerArray[_secRow][@"area_district"];
    
    [self reloadAllComponents];
    
    _selectCity(_firstPickerArray[_firstRow], _secPickerArray[_secRow], [_thirdPickerArray count] > _thirdRow ? _thirdPickerArray[_thirdRow] : _secPickerArray[_secRow]);
}

//预先有城市的情况下，把当前的可视row移到城市的cell上
- (void)setCityName:(NSString *)cityName
{
    _cityName = cityName;
    
    if (self.cityName) {
        
        //遍历省份
//        for (NSString *stateName in _pickerArray) {
//            
//            //遍历省份下的城市
//            for (NSDictionary *cityDic in _dict[stateName]) {
//                
//                //在省份下的城市列表里面找有没有当前的城市，如果对上了，把当前城市所在的栏位记录，直接退出整个遍历过程
//                
//                if ([[cityDic allKeys] containsObject:self.cityName]) {
//                    
//                    _firstRow = [_pickerArray indexOfObject:stateName];
//                    
//                    [self selectRow:_firstRow inComponent:0 animated:NO];
//                    [self pickerView:self didSelectRow:_firstRow inComponent:0];
//                    return;
//                    
//                }
//            }
//        }
    }
}

#pragma mark--UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==FirstComponent) {
        return [_firstPickerArray count];
    }
    else if (component==SubComponent) {
        return [_secPickerArray count];
    }
    return [_thirdPickerArray count];
}


#pragma mark--
#pragma mark--UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *stateLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    
    stateLbl.backgroundColor = [UIColor clearColor];
    stateLbl.font = [UIFont systemFontOfSize:18];
    stateLbl.textAlignment = NSTextAlignmentCenter;
    
    if (component==FirstComponent) {
        stateLbl.text = _firstPickerArray[row][@"area_name"];
    }
    else if (component==SubComponent) {
        stateLbl.text = _secPickerArray[row][@"area_name"];
    }
    else
        stateLbl.text = _thirdPickerArray[row][@"area_name"];
    
    return stateLbl;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == FirstComponent) {
        
        _firstRow = row;
    }
    else if (component == SubComponent) {
        
        _secRow = row;
    }
    else
        _thirdRow = row;
    
    [self reloadData];
    
    if (_selectCity) {
        
        _selectCity(_firstPickerArray[_firstRow], _secPickerArray[_secRow], [_thirdPickerArray count] > _thirdRow ? _thirdPickerArray[_thirdRow] : _secPickerArray[_secRow]);
    }
}


@end
