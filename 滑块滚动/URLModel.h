//
//  URLModel.h
//  滑块滚动
//
//  Created by 蒋永昌 on 16/5/21.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface URLModel : NSObject
{
    MBProgressHUD *_hud;
}

singleton_interface(URLModel);
@property(strong,nonatomic)NSMutableURLRequest *request;
@property(retain,nonatomic)AFHTTPRequestOperationManager *manager;

+ (void)requestWithURL:(NSString *)urlString
                params:(id)params
         completeBlock:(void (^)(AFHTTPRequestOperation*operation,id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
         fromClassName:(NSString *)className;

@end
