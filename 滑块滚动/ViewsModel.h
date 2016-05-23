//
//  ViewsModel.h
//  HN
//
//  Created by 全程恺 on 14/8/21.
//  Copyright (c) 2014年 Danfort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface ViewsModel : NSObject

@property (nonatomic, retain) NSMutableArray *viewsArr;    //存储截图数组

singleton_interface(ViewsModel);

//截图
+ (UIImage *)getCut:(UIView *)view fromSize:(CGSize)size;

//获取最上层视图
+ (UIViewController *)getTopViewController;

//递归找出视图中的第一响应者
+ (UITextField *)findFistResponder:(UIView *)view;
@end
