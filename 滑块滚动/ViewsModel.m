//
//  ViewsModel.m
//  HN
//
//  Created by 全程恺 on 14/8/21.
//  Copyright (c) 2014年 Danfort. All rights reserved.
//

#import "ViewsModel.h"
#import "AppDelegate.h"

@implementation ViewsModel

singleton_implementation(ViewsModel);

+ (UIImage *)getCut:(UIView *)view fromSize:(CGSize)size
{
    float scale = [UIScreen mainScreen].scale;//获取屏幕分辨率，1是普通分辨率，2是高分辨率
    
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIViewController *)getTopViewController
{
    UIViewController *appRootViewController;
    UIWindow *window;
    
    window = [UIApplication sharedApplication].keyWindow;
    
    appRootViewController = window.rootViewController;
    
    UIViewController *topViewController = appRootViewController;
    while (topViewController.presentedViewController != nil)
    {
        topViewController = topViewController.presentedViewController;
    }
    
    return topViewController;
}

#pragma mark 递归找出第一响应者
+ (UITextField *)findFistResponder:(UIView *)view {
    
    for (UIView *child in view.subviews) {
        
        if ([child respondsToSelector:@selector(isFirstResponder)] &&
            [child isFirstResponder]) {
            
            return (UITextField *)child;
        }
        
        UITextField *field = [self findFistResponder:child];
        if (field) {
            return field;
        }
    }
    
    return nil;
}



@end
