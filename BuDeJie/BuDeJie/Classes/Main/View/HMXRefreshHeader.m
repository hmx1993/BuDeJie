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
        
//        //自动切换透明度
//        self.automaticallyChangeAlpha = YES;
//        
        //隐藏时间
//        self.lastUpdatedTimeLabel.hidden = YES;
        
//        [self setTitle:@"下拉🐴上刷新" forState:MJRefreshStateIdle];
//        [self setTitle:@"松开立即新" forState:MJRefreshStatePulling];
//        
//        [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
        
        //设置动态图片
        //设置普通状态下的图片
        NSMutableArray *imagesArray = [NSMutableArray array];
        for (NSInteger i = 1; i <= 60; i++) {
            NSString *imageName = [NSString stringWithFormat:@"dropdown_anim__000%zd",i];
            UIImage *image = [UIImage imageNamed:imageName];
            
            [imagesArray addObject:image];
        }
        
        [self setImages:imagesArray duration:2.0 forState:MJRefreshStateIdle];
        
        //设置即将刷新的图片
        NSMutableArray *imagesArray1 = [NSMutableArray array];
        for (NSInteger i = 1; i <= 3; i++) {
            NSString *imageName = [NSString stringWithFormat:@"dropdown_loading_0%zd",i];
            UIImage *image = [UIImage imageNamed:
                              imageName];
            
            [imagesArray1 addObject:image];
        }
        [self setImages:imagesArray1 forState:MJRefreshStatePulling];
        
        //设置正在刷新的图片
        [self setImages:imagesArray1 forState:MJRefreshStateRefreshing];
    }
    return self;
}



@end
