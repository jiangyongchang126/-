//
//  TableView.h
//  JustTry
//
//  Created by 蒋永昌 on 16/5/20.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewDelegate.h"

typedef NS_ENUM(NSInteger, ShoppingType) {
    
    ShoppingTypeQuoting,   //求购中
    ShoppingTypeHistory,   //历史
    ShoppingTypeFuture    //未来
};

@interface TableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) id<ViewDelegate> myDelegate;
@property (nonatomic,assign)ShoppingType types;

@end
