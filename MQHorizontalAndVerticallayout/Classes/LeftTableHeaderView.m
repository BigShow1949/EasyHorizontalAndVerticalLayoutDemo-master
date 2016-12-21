//
//  LeftTableHeaderView.m
//  MQHorizontalAndVerticallayout
//
//  Created by macbook on 16/8/12.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import "LeftTableHeaderView.h"
#import "UIView+YYAdd.h"

@interface LeftTableHeaderView ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation LeftTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = ColorWhite;
        self.btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.btn.backgroundColor = [UIColor lightGrayColor];
        [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
    }
    return self;
}

- (void)configureWithItem:(id)item
{
    [self.btn setTitle:item forState:UIControlStateNormal];
}

- (void)btnClick {
    [self.delegate rightTableHeaderViewClick:SortTypeNumber];
}

@end
