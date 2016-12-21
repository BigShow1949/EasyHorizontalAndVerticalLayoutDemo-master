//
//  NSArray+Extension.h
//  MQHorizontalAndVerticallayout
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

/**
 获取 cls 类的属性数组
 */
+ (instancetype)getProperties:(Class)cls;
@end
