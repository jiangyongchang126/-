//
//  ViewController.m
//  滑块滚动
//
//  Created by 蒋永昌 on 16/5/17.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "ViewController.h"
#import "BaseTopControl.h"
#import "TableView.h"


@interface ViewController ()<UIScrollViewDelegate,ViewDelegate>
{
    UIScrollView *_contentSC;
    BaseTopControl *_seg;
    
    TableView *_historyTB;
    TableView *_nowTB;
    TableView *_futureTB;

}

@property(nonatomic,retain)UIView *historyView;
@property(nonatomic,retain)UIView *nowView;
@property(nonatomic,retain)UIView *futureView;


@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"JustForFun";
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addsubViews];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)addsubViews{
    
    _seg = [[BaseTopControl alloc] initWithTitles:@[@"历史", @"现在",@"未来"]];
    [_seg addTarget:self action:@selector(clickSegmentAction) forControlEvents:UIControlEventValueChanged];
    _seg.selectIndex = 0;
    [self.view addSubview:_seg];
    
    _contentSC = [UIScrollView new];
    _contentSC.scrollEnabled = NO;
    _contentSC.delegate = self;
    
    [self.view addSubview:_contentSC];
    
    [_contentSC addSubview:self.historyView];
    [_contentSC addSubview:self.nowView];
    [_contentSC addSubview:self.futureView];
    
    [self updateAL];

}

- (void)updateAL{
    
    [_seg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(4);
        make.right.equalTo(self.view).offset(-4);
        make.top.equalTo(self.view).offset(20);
        make.height.mas_equalTo(35);
    }];
    
    [_contentSC mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_seg.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_historyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(_contentSC);
        make.left.top.equalTo(_contentSC);
    }];
    
    [_nowView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(_contentSC);
        make.top.equalTo(_contentSC);
        make.left.equalTo(_historyView.mas_right);
    }];
    
    
    [_futureView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(_contentSC);
        make.top.equalTo(_contentSC);
        make.left.equalTo(_nowView.mas_right);
    }];
    


}


- (void)clickSegmentAction
{
    [_contentSC setContentOffset:CGPointMake(_contentSC.frame.size.width * _seg.selectIndex, 0) animated:YES];
}

// 实现代理方法
- (void)ShouldEnterDetailViewControllerWithItem:(id)item{
    
    NSLog(@"%@",item);
    
}



-(UIView *)historyView{
    
    if (!_historyView) {
        
        _historyView = [UIView new];
        _historyTB = [[TableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _historyTB.types = ShoppingTypeHistory;
//        _historyTB.myDelegate = self;
        [_historyView addSubview:_historyTB];
        
        _historyTB.myDelegate = self;
        [_historyTB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(_historyView);
        }];
        
    }
    
    return _historyView;
}

-(UIView *)nowView{
    
    if (!_nowView) {
        
        _nowView = [UIView new];
        _nowTB = [[TableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _nowTB.types = ShoppingTypeQuoting;
        //        _historyTB.myDelegate = self;
        [_nowView addSubview:_nowTB];
        
        _nowTB.myDelegate = self;
        [_nowTB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(_nowView);
        }];
        
    }
    
    return _nowView;

}

-(UIView *)futureView{
    
    if (!_futureView) {
        
        _futureView = [UIView new];
        _futureTB = [[TableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _futureTB.types = ShoppingTypeFuture;
        _futureTB.myDelegate = self;
        [_futureView addSubview:_futureTB];
        
        
        [_futureTB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(_futureView);
        }];
        
    }
    
    return _futureView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
