//
//  NSObject+Value.m
//  HuiBeiLifeMerchant
//
//  Created by niu mu on 13-8-24.
//  Copyright (c) 2013年 huiyinfeng. All rights reserved.
//

#import "NSObject+Value.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation NSObject (Value)
// 解档方法
- (void)encode:(NSCoder *)encoder
{
    // 1.获得所有的成员变量 outCount 成员数量  Ivar *ivars 成员变量列表
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList(self.class, &outCount);
    // 2.迭代列表 获取到所有成员值 进行解档
    for (int i = 0; i<outCount; i++) {
        Ivar ivar = ivars[i];
        // 属性名
        NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
        // 3.利用KVC获得值
        id value = [self valueForKey:name];
        [encoder encodeObject:value forKey:name];
    }
}


// 归档方法
- (void)decode:(NSCoder *)decoder
{
    // 1.获得所有的成员变量
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList(self.class, &outCount);
    
    for (int i = 0; i<outCount; i++) {
        Ivar ivar = ivars[i];
        
        // 2.属性名
        NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
        
        // 3.利用KVC设值
        [self setValue:[decoder decodeObjectForKey:name] forKey:name];
    }
}


- (void)setValues:(NSDictionary *)values
{
    Class c = [self class];
    
    while (c) {
        // 1.获得所有的成员变量
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        
        for (int i = 0; i<outCount; i++) {
            Ivar ivar = ivars[i];
            
            // 2.属性名
            NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
            
            // 删除最前面的_
            [name deleteCharactersInRange:NSMakeRange(0, 1)];
            
            // 3.取出属性值
            id value = [values objectForKey:name];
            if ([name isEqualToString:@"userId"]) {
                
                value = [values objectForKey:@"id"];
            }

            if (!value) {
                
//                if ([[self valueForKey:name] isMemberOfClass:[NSString class]]) {
//                    
//                }
//                BOOL res = [[NSClassFromString(name) class] isSubclassOfClass:[NSString class]];
//                [self setValue:@"" forKey:name];
                continue;
            }
            
            if (([value isKindOfClass:[NSString class]] && [value rangeOfString:@"null"].length) ||
                [value isKindOfClass:[NSNull class]]) {
                
                value = @"";
            }
            
            // 4.KVC赋值
            [self setValue:value forKey:name];
        }
        
        c = class_getSuperclass(c);
    }
}

- (NSDictionary *)setValuesArray:(NSArray *)values
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if ([self isMemberOfClass:[NSArray class]]) {
        
        NSArray *this = (NSArray *)self;
        for (int i = 0; i < this.count; i ++) {
            
            [dic setObject:this[i] forKey:[values[i] length] ? values[i] : @"\"\""];
        }
    }
    
    if ([dic allKeys]) {
        
        return dic;
    }
    return nil;
}

- (NSDictionary *)values
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    Class c = [self class];
    
    while (c && c != [NSObject class]) {
        // 1.获得所有的成员变量
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        
        for (int i = 0; i<outCount; i++) {
            Ivar ivar = ivars[i];
            
            // 2.属性名
            NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
            
            // 删除最前面的下划线_
            [name deleteCharactersInRange:NSMakeRange(0, 1)];
            
            // 3.取出属性值
            if (!name) {
                continue;
            }
            
            id value = [self valueForKey:name];
            if ([name isEqualToString:@"userId"]) {
                
                name = [NSMutableString stringWithString:@"id"];
            }
            
            if (value) {
                dict[name] = value;
            }
        }
        
        c = class_getSuperclass(c);
    }
    return dict;
}


+ (id)performSelector:(SEL)selector withObjects:(NSArray *)objects {
    
    // 获取方法的签名
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    if (signature) {
        //从中获取描述静态方法的nsinvocation 给这个描述添加 target SEL 以及参数(参数从2开始，0 和 1 分别是target SEL )
        NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:selector];
        for(int i = 0; i < [objects count]; i++){
            id object = [objects objectAtIndex:i];
            [invocation setArgument:&object atIndex: (i + 2)];
        }
        [invocation invoke];
        //返回值
        if (signature.methodReturnLength) {
            id anObject;
            [invocation getReturnValue:&anObject];
            return anObject;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}
@end
