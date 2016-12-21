//
//  HeaderViewProtocol.h
//  MQHorizontalAndVerticallayout
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SortType) {  // 注意跟tag要一致
    SortTypeNumber = 99,
    SortTypeAge = 100,
    SortTypeMath,
    SortTypeChinese,
    SortTypeEnglish,
    SortTypeChemistry,
};

@protocol HeaderViewProtocol <NSObject>

- (void)rightTableHeaderViewClick:(SortType)type;

@end
