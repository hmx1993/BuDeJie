//
//  HMXFastLogin.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/7.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXFastLogin.h"

@implementation HMXFastLogin

+(instancetype)fastLogin
{
    return [[NSBundle mainBundle] loadNibNamed:@"HMXFastLogin" owner:nil options:nil][0];
}

@end
