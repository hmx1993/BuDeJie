//
//  HMXSubTagItem.h
//  BuDeJie
//
//  Created by hemengxiang on 16/4/6.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMXSubTagItem : NSObject

/*
 "image_list" = "";
 "sub_number" = 5918;
 "theme_name" = "\U6d77\U8d3c\U738b"; 
 */

/** 图片的URL */
@property(nonatomic,strong)NSString *image_list;
/** 关注人数 */
@property(nonatomic,strong)NSString *sub_number;
/** 用户名 */
@property(nonatomic,strong)NSString *theme_name;
@end
