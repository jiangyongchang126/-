//
//  TableViewCell.h
//  JustTry
//
//  Created by 蒋永昌 on 16/5/20.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

{
    
    UIView *_bgView;
    UILabel *_nameLB;
    UILabel *_ageLB;
    UIView *_line;
    UILabel *_phoneLB;
}

@property(nonatomic,strong)NSString *model;

@end
