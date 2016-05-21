//
//  TableViewCell.m
//  JustTry
//
//  Created by 蒋永昌 on 16/5/20.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "TableViewCell.h"
#import "Masonry.h"

@implementation TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addUI];
        
    }
    
    return self;
}

- (void)addUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 4;
    _bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_bgView];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(4, 4, 5, 4));
        
    }];
    
    
    _nameLB = [UILabel new];
    _nameLB.text = @"蒋永昌";
    _nameLB.textColor = [UIColor redColor];
    _nameLB.font = [UIFont boldSystemFontOfSize:15];
    
    CGSize size = [_nameLB.text sizeWithFont:_nameLB.font];
    _nameLB.backgroundColor = [UIColor greenColor];
    
    [_bgView addSubview:_nameLB];
    
    [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_bgView).offset(8);
        make.top.equalTo(_bgView).offset(5);
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(25);
    }];
    
    
    _ageLB = [UILabel new];
    _ageLB.text = @"18";
    _ageLB.textColor = [UIColor blueColor];
    _ageLB.font = [UIFont boldSystemFontOfSize:17];
    
    
    _ageLB.backgroundColor = [UIColor greenColor];
    
    [_bgView addSubview:_ageLB];
    
    [_ageLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_nameLB.mas_right).offset(10);
        
        make.centerY.equalTo(_nameLB);
        
        make.width.mas_equalTo(50);
        
    }];
    
    _line = [UIView new];
    _line.backgroundColor = [UIColor blackColor];
    [_bgView addSubview:_line];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_nameLB);
        make.right.equalTo(_bgView).offset(-8);
        make.height.mas_equalTo(.5);
        make.top.equalTo(_nameLB.mas_bottom).offset(5);
    }];
    
    
    _phoneLB = [UILabel new];
    _phoneLB.font = [UIFont boldSystemFontOfSize:15];
    _phoneLB.backgroundColor = [UIColor clearColor];
    
    [_bgView addSubview:_phoneLB];
    
    [_phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_line).offset(5);
        make.left.equalTo(_line);
        make.bottom.equalTo(_bgView);
    }];
    
}

-(void)layoutSubviews{
    
    self.model = @"点击了cell";
    
    
    NSString *phone = @"1234567890";
    
    NSMutableAttributedString *phoneAttr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"蒋永昌:%@",phone]];
    
    CGSize size = [phoneAttr.string sizeWithFont:[UIFont boldSystemFontOfSize:18]];
    [_phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(size.width);
    }];
    
    [phoneAttr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, phoneAttr.length)];
    [phoneAttr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:[phoneAttr.string rangeOfString:phone]];
    
    [phoneAttr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, phoneAttr.length)];
    
    [phoneAttr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:[phoneAttr.string rangeOfString:phone]];
    
    _phoneLB.attributedText = phoneAttr;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
