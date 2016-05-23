//
//  NSObject+Value.h
//  HuiBeiLifeMerchant
//
//  Created by niu mu on 13-8-24.
//  Copyright (c) 2013年 huiyinfeng. All rights reserved.
//

/*instancetype 与 id 的区别
 instancetype 只能作为返回值，id既可以作为返回值，又可以作为参数传递
 instancetype 返回的必须是本类 而在多态的情况下，id返回的可能是子类，调用方法时，Instancetype 调用不了子类方法
 instancetype 可以不进行转换便可以调用自身方法 。 id 获取到对象后 需要进行转换才能调用声明的方法
 */

/*   利用了OC的runtime机制
 
    1. 所有在.m中声明HBMCodingM 的类 都可以进行归档解档   
    此分类给基类NSObject添加归档解档方法
    适用于大量数据对象的归档 解档。
    数据的批量处理。
 
    2.HBMWithDictH 声明此宏 便可以自动生成withDict工厂方法，
 
    3. - (NSDictionary *)values; 获取自身所有成员属性封装好得字典
 
    + (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;
    动态调用方法，带返回值，多参数 
    当需要动态调用一个集合中得所有对象的某个带返回值，多参数的方法时
 */




#define HBMWithDictH(prefix) \
+ (instancetype)prefix##WithDict:(NSDictionary *)dict;

#define HBMWithDictM(className, prefix) \
+ (instancetype)prefix##WithDict:(NSDictionary *)dict \
{ \
    className *obj = [[self alloc] init]; \
    [obj setValues:dict]; \
    return obj; \
}

#define HBMSetter(className, subfix, param) \
- (void)set##subfix:(id)param \
{ \
    if ([param isKindOfClass:[NSDictionary class]]) { \
        _##param = [className param##WithDict:param]; \
    } else { \
        _##param = param; \
    } \
}

#define HBMCodingM \
- (id)initWithCoder:(NSCoder *)decoder \
{ \
    if (self = [super init]) { \
        [self decode:decoder]; \
    } \
    return self; \
} \
 \
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
    [self encode:encoder]; \
}

#import <Foundation/Foundation.h>

@interface NSObject (Value)
// 设置数据
- (void)setValues:(NSDictionary *)values;
- (NSDictionary *)setValuesArray:(NSArray *)values;
- (NSDictionary *)values;
- (void)decode:(NSCoder *)decoder;
- (void)encode:(NSCoder *)encoder;
+ (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;
@end