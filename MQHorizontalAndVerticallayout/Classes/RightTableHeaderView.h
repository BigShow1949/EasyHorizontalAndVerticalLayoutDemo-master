//
//  RightTableHeaderView.h
//  MQHorizontalAndVerticallayout
//
//  Created by macbook on 16/8/12.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderViewProtocol.h"

@interface RightTableHeaderView : UIView<HeaderViewProtocol>

@property (nonatomic, assign) CGFloat widthForItem;
@property (nonatomic, assign) CGFloat heightForItem;

- (void)configureWithItem:(id)item;

@property (nonatomic, weak) id<HeaderViewProtocol> delegate;

@end
