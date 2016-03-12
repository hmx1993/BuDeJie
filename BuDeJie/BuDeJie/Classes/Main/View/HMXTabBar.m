//
//  HMXTabBar.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXTabBar.h"

@interface HMXTabBar ()

@property(nonatomic,weak)UIButton *plusButton;

@end


@implementation HMXTabBar

//懒加载
-(UIButton *)plusButton
{
    if (!_plusButton) {
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        //根据按钮的内容自适应
        [plusButton sizeToFit];
        
        _plusButton = plusButton;
        
        //添加到tabBar上面去
        [self addSubview:plusButton];
    }
    
    return _plusButton;
}


-(void)layoutSubviews{
    [super layoutSubviews];
}



@end
