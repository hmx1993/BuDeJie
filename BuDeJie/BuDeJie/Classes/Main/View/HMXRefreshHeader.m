//
//  HMXRefreshHeader.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/23.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXRefreshHeader.h"

@implementation HMXRefreshHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //自动切换透明度
        self.automaticallyChangeAlpha = YES;
        
        //隐藏时间
        self.lastUpdatedTimeLabel.hidden = YES;
        
        [self setTitle:@"🐴⬆️往⬇️拉" forState:MJRefreshStateIdle];
        [self setTitle:@"松开🐴上🌲新" forState:MJRefreshStatePulling];
        
        [self setTitle:@"正在刷新...." forState:MJRefreshStateRefreshing];
    }
    return self;
}


@end
