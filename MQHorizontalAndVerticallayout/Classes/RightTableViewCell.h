//
//  RightTableViewCell.h
//  MQHorizontalAndVerticallayout
//
//  Created by macbook on 16/8/12.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface RightTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat widthForItem;
@property (nonatomic, assign) CGFloat heightForItem;

- (void)configureWithItem:(Model *)item;

@end
