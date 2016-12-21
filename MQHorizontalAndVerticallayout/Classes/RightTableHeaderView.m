//
//  RightTableHeaderView.m
//  MQHorizontalAndVerticallayout
//
//  Created by macbook on 16/8/12.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import "RightTableHeaderView.h"
#import "UIView+YYAdd.h"


@implementation RightTableHeaderView 

- (void)configureWithItem:(id)item
{
    NSArray *datas = item;
    CGFloat widthForItem = self.frame.size.width / datas.count;
    CGFloat heightForItem = self.frame.size.height;
    UIButton *btn = [self viewWithTag:100];
    
    if (btn == NULL) {
        for (NSInteger i = 0 ; i < datas.count; i++) {
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(widthForItem * i, 0, widthForItem, heightForItem)];
            btn.backgroundColor = [UIColor lightGrayColor];
            [btn setTitle:datas[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 100 + i;
            [self addSubview:btn];
        }
    } else {
        for (int i = 0; i < datas.count; i++) {
            UIButton *btn = [self viewWithTag:100 + i];
            [btn setTitle:datas[i] forState:UIControlStateNormal];
        }
    }
}

- (void)btnClick:(UIButton *)btn {

    [self.delegate rightTableHeaderViewClick:btn.tag];
}

@end
