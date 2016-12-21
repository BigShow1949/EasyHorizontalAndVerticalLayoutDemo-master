//
//  RightTableViewCell.m
//  MQHorizontalAndVerticallayout
//
//  Created by macbook on 16/8/12.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import "RightTableViewCell.h"

@implementation RightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 这个属性一定要设置 不然就会出现左边右边的cell选中状态不一致
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)configureWithItem:(Model *)item
{
    NSArray *datas = @[item.age, item.math, item.chinese, item.english, item.chemistry];
    
    UILabel *label = [self viewWithTag:100];
    
    if (label == NULL) {
        
        for (NSInteger i = 0 ; i < datas.count; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.widthForItem * i, 0, self.widthForItem, self.heightForItem - 3)];
            
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 2;
            label.text = [NSString stringWithFormat:@"%@", datas[i]];
            label.tag = 100 + i;
            [self addSubview:label];
            
        }
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.heightForItem - .5,  self.widthForItem * datas.count, .5)];
        lineView.backgroundColor = ColorTableSeparator;
        [self.contentView addSubview:lineView];
        
    } else {
        for (int i = 0; i < datas.count; i++) {
            UILabel *label = [self viewWithTag:100 + i];
            label.text = [NSString stringWithFormat:@"%@", datas[i]];
        }
    }
}

@end
