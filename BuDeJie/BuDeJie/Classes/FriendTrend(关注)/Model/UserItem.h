//
//  UserItem.h
//  BuDeJie
//
//  Created by hemengxiang on 16/4/25.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserItem : NSObject

/** 粉丝数 */
@property(nonatomic,strong)NSString *fans_count;
/** 昵称 */
@property(nonatomic,strong)NSString *screen_name;
/** 头像 */
@property(nonatomic,strong)NSString *header;

@end
