//
//  HMXSqaureItem.h
//  BuDeJie
//
//  Created by hemengxiang on 16/4/7.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMXSqaureItem : NSObject

/*
 icon name url
 */
/* 图片 */
@property(nonatomic,strong)NSString *icon;

/* 名称 */
@property(nonatomic,strong)NSString *name;

/* 点击cell跳转的URL */
@property(nonatomic,strong)NSString *url;

@end
